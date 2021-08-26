--[[
Name: PeriodicTable-3.0
Revision: $Rev: 25335 $
Author: Nymbia (nymbia@gmail.com)
Many thanks to Tekkub for writing PeriodicTable 1 and 2, and for permission to use the name PeriodicTable!
Website: http://www.wowace.com/wiki/PeriodicTable-3.0
Documentation: http://www.wowace.com/wiki/PeriodicTable-3.0/API
SVN: http://svn.wowace.com/wowace/trunk/PeriodicTable-3.0/PeriodicTable-3.0/
Description: Library of compressed itemid sets.
Dependencies: AceLibrary
License: LGPL v2.1
Copyright (C) 2007 Nymbia

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
]]
local MAJOR_VERSION = "PeriodicTable-3.0"
local MINOR_VERSION = "$Rev: 25335 $"
if not AceLibrary then error(MAJOR_VERSION.." requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION,MINOR_VERSION) then return end
local PT3 = {}
local cache = {}
local sets
local embedversions
-- Internal
function PT3:getUpgradeData()
	return sets, embedversions
end
local function getItemID(item)
	if not item then
		return
	end
	if tonumber(item) then
		return tonumber(item)
	end
	return tonumber(item:match("item:(%d+)"))
end
local function makeNonPresentMultiSet(parentname)
	local setstring = "m,"
	for k,v in pairs(sets) do
		if k:match("^"..parentname.."%.") then
			setstring = setstring..k..","
		end
	end
	if setstring:len() > 2 then
		sets[parentname] = setstring:sub(1,-2)
		return sets[parentname]
	end
end
local function uncompress(setstring)
	if not setstring then
		return
	end
	if setstring:sub(1,2) == "m," or setstring:sub(1,2) == "u," then
		return setstring
	elseif setstring:sub(1,2) == "o," then
		local newsetstring = "o,"
		for itemstring in setstring:sub(3):gmatch("([^,]+)") do
			local id, value = itemstring:match("^([^:]+):(.+)$")
			if id then
				newsetstring = newsetstring..tonumber(id,36)..":"..value..","
			else
				newsetstring = newsetstring..tonumber(itemstring,36)..","
			end
		end
		return newsetstring:sub(1,-2)
	elseif setstring:sub(1,2) == "c[" then
		local newsetstring = "c"
		for set in setstring:gmatch("(%b[])") do
			local childstring,rest = set:sub(2,-2):match("([^,]+,)(.+)$")
			newsetstring = newsetstring.."["..childstring..uncompress(rest).."]"
		end
		return newsetstring
	else
		local newsetstring = ""
		for itemstring in setstring:gmatch("([^,]+)") do
			local id, value = itemstring:match("^([^:]+):(.+)$")
			if id then
				newsetstring = newsetstring..tonumber(id,36)..":"..tonumber(value,36)..","
			else
				newsetstring = newsetstring..tonumber(itemstring,36)..","
			end
		end
		return newsetstring:sub(1,-2)
	end
end
local function breakCType(set)
	local setstring = sets[set]
	if not setstring then
		return
	end
	local newstring = "m,"
	for subsetstring in setstring:gmatch("(%b[])") do
		local childname, rest = subsetstring:sub(2,-2):match("([^,]+),(.+)$")
		sets[set.."."..childname] = rest
		newstring = newstring..set.."."..childname..","
	end
	sets[set] = newstring:sub(1, -2)
	return true
end
local function isInCType(set)
	local parent, child = set:match("^(.+)%.([^%.]+)$")
	if parent and sets[parent] then
		if sets[parent]:sub(1,2) == "c[" and sets[parent]:match("%["..child..",") then
			return parent
		end
	elseif parent then
		return isInCType(parent)
	end
end
local function seekchild(item, setstring)
	for substring in setstring:gmatch("(%b[])") do
		if substring:match(item) then
			if substring:match("c%[") then
				return substring:match("%[([^,]+)").."."..seekchild(item, setstring:sub(2,-2))
			else
				return substring:match("%[([^,]+)")
			end
		end
	end
end
local function getsetstring(set)
	if sets[set] then
		return sets[set]
	else
		local parent = isInCType(set)
		if parent then
			breakCType(parent)
			return getsetstring(set)
		else
			return makeNonPresentMultiSet(set)
		end
	end
end
local function cacheSet(set)
	if not set or cache[set] then
		return cache[set]
	end
	local setstring = uncompress(getsetstring(set))
	if not setstring then
		return
	end
	if setstring:sub(1,2) == "m," then
		cache[set] = {}
		for childset in setstring:sub(3):gmatch("([^,]+)") do
			if not cache[childset] then
				cacheSet(childset)
			end
			for k,v in pairs(cache[childset]) do
				cache[set][k] = v
			end
		end
		return cache[set]
	elseif setstring:sub(1,2) == "c[" then
		breakCType(set)
		return cacheSet(set)
	elseif setstring:sub(1,2) == "o," or setstring:sub(1,2) == "u," then
		cache[set] = {}
		for itemstring in setstring:sub(3):gmatch("([^,]+)") do
			local id, value = itemstring:match("^([^:]+):(.+)$")
			id, value = id or itemstring, value or true
			cache[set][tonumber(id)] = value
		end
		return true
	else
		cache[set] = {}
		for itemstring in setstring:gmatch("([^,]+)") do
			local id, value = itemstring:match("^([^:]+):(.+)$")
			id, value = id or itemstring, value or true
			cache[set][tonumber(id)] = value
		end
		return true
	end
end
-- API
function PT3:GetSetTable(set)
	if cache[set] then
		return cache[set]
	else
		if cacheSet(set) then
			return cache[set]
		end
	end
end
function PT3:GetSetStringCompressed(set)
	return getsetstring(set)
end
function PT3:GetSetStringUncompressed(set)
	return uncompress(getsetstring(set))
end
function PT3:ItemInSet(item, set, subsetflag)
	item = getItemID(item)
	if not item then
		return
	end
	if cache[set] and not subsetflag then
		return cache[set][item], set
	else
		local setstring = self:GetSetStringUncompressed(set)
		if setstring then
			if setstring:sub(1,2) == "c[" then
				breakCType(set)
				return self:ItemInSet(item, set)
			elseif setstring:sub(1,2) == "m," then
				for setname in setstring:sub(3):gmatch("([^,]+)") do
					local found, foundset = self:ItemInSet(item, setname)
					if found then
						return found, foundset
					end
				end
			else
				local id, rest = setstring:match("("..item..")([^,]-)")
				if rest and rest:len() > 1 then
					return rest:sub(2), set
				elseif tonumber(id) == tonumber(item) then
					return true, set
				end
			end
		end
	end
end
function PT3:AddData(arg1, arg2, arg3)
	if not arg3 and type(arg2) == "string" then
		sets[arg1] = arg2
		if cache[arg1] then
			cache[arg1] = nil
		end
		--!! if there's caches of parents (or children, if this is a c[] set), kill 'em.
	else
		if arg3 then
			local version = tonumber(arg2:match("(%d+)"))
			if embedversions[arg1] and embedversions[arg1] >= version then
				return
			end
			embedversions[arg1] = version
			for k,v in pairs(arg3) do
				self:AddData(k,v)
			end
			return
		end
		for k,v in pairs(arg2) do
			self:AddData(k,v)
		end
	end
end
function PT3:ItemSearch(item)
	item = getItemID(item)
	local matches = {}
	for k,v in pairs(sets) do
		local setstring = uncompress(v)
		if setstring:match("^"..item.."$") or setstring:match(","..item.."$") or setstring:match("^"..item.."%D") or setstring:match(","..item.."%D") then
			if v:sub(1,2) == "c[" then
				table.insert(matches, k.."."..seekchild(item,setstring))
			else
				table.insert(matches, k)
			end
		end
	end
	if #matches > 0 then
		return matches
	end
end
function PT3:GetNumSets()
	local num = 0
	for k,v in pairs(sets) do
		num = num + 1
	end
	return num
end
function PT3:GetNumCachedSets()
	local num = 0
	for k,v in pairs(cache) do
		num = num + 1
	end
	return num
end
function PT3:GetBetter(set, itema, itemb)
	local vala = self:ItemInSet(itema, set)
	local valb = self:ItemInSet(itemb, set)
	if tonumber(vala) and tonumber(valb) then
		if tonumber(vala) > tonumber(valb) then
			return itema, tonumber(vala)
		else
			return itemb, tonumber(valb)
		end
	end
end
function PT3:GetBest(set)
	local highestitem
	local highestvalue = 0
	if cache[set] then
		for k,v in pairs(cache[set]) do
			if tonumber(v) and tonumber(v) > highestvalue then
				highestvalue = tonumber(v)
				highestitem = tonumber(k)
			end
		end
		if highestitem then
			return highestitem, highestvalue
		else
			return
		end
	end
	local setstring = self:GetSetStringUncompressed(set)
	if setstring then
		if setstring:sub(1,2) == "c[" then
			breakCType(set)
			return self:GetBest(set)
		elseif setstring:sub(1,2) == "m," then
			for setname in setstring:sub(3):gmatch("([^,]+)") do
				local id, value = self:GetBest(setname)
				if value and tonumber(value) and tonumber(value) > highestvalue then
					highestitem = tonumber(id)
					highestvalue = tonumber(value)
				end
			end
		else
			for itemstr in setstring:gmatch("([^,]+)") do
				local id, value = itemstr:match("^([^:]+):(.+)$")
				if value and tonumber(value) and tonumber(value) > highestvalue then
					highestitem = tonumber(id)
					highestvalue = tonumber(value)
				end
			end
		end
	end
	if highestitem then
		return highestitem, highestvalue
	end
end
local function activate(self, oldLib, oldDeactivate)
	if oldLib then
		sets, embedversions = oldLib:getUpgradeData()
	else
		sets = {}
		embedversions = {}
	end
	if oldDeactivate then oldDeactivate(oldLib) end
end
AceLibrary:Register(PT3, MAJOR_VERSION, MINOR_VERSION, activate)
PT3=nil
