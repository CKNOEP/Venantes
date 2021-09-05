--[[
Name: SphereInventory-1.0
Revision: $Rev: 10000 $
Developed by: Zirah
Maintainer: LädyGaga and Yinmaris on Sulfuron (EU, Alliance)
Description: inventory handling for sphere addons
Dependencies: Ace3
]]

local MAJOR_VERSION = 'SphereInventory-2.0'
local MINOR_VERSION = '$Revision: 10000 $'


local SphereInventory = LibStub:NewLibrary("SphereInventory-2.0", 1)
if not SphereInventory then  return end -- already loaded and no upgrade necessary

--[[
local SphereInventory = Mixin {
    'InventoryScan',
    'InventoryScanBag',
    'InventoryParseLink',
    'InventoryCheckItem',
    'InventoryGetItemData',
    'InventoryGetItemCooldown',
    'InventoryGetMountData',
    'InventorySetItem',
}
]]
function SphereInventory:InventoryScan()
    if InCombatLockdown() then
        self.bagUpdatePending = true;
        return;
    end
    self.inventoryItems = {
        ['HEARTHSTONE'] = nil,
        ['MOUNT'] = nil,
        ['MOUNT_AQ'] = nil,
        ['MOUNT_FLY'] = nil,
        ['POTION_HP'] = nil,
        ['POTION_MP'] = nil,
        ['DRINK'] = nil,
        ['FOOD'] = nil,
    }
    if not self.PT then
        self.PT = LibStub:GetLibrary("LibPeriodicTable-3.1");
    end
    for bagId=0, 4, 1 do
        self:InventoryScanBag(bagId);
    end
    self.bagUpdatePending = false;
end

function SphereInventory:InventoryScanBag(bagId) 
    -- For each slot
	for slotId=1, GetContainerNumSlots(bagId), 1 do
        local itemLink = GetContainerItemLink(bagId, slotId);
       
		if itemLink ~= nil then
            local itemId = self:InventoryParseLink(itemLink);
             print (itemId,itemLink)
			local _, itemCount = GetContainerItemInfo(bagId, slotId);
            self:InventoryCheckItem(itemId, itemCount);
        end
    end
end

function SphereInventory:InventoryCheckItem(itemId, itemCount)
    print (itemId, itemCount)
	local _, _, _, _, itemMinLevel = GetItemInfo(itemId);
    -- hearthstone?  
	
   if itemId == 6948 then
        self:InventorySetItem('HEARTHSTONE', itemId, 1, false);
    -- is it a heal potion?
    elseif self.PT:ItemInSet(itemId, 'Consumable.Potion.Recovery.Healing.Basic') then
        if self.inventoryItems['POTION_HP'] == nil or self.inventoryItems['POTION_HP'].count <= 0 then
            self:InventorySetItem('POTION_HP', itemId, itemCount, false);
        elseif self.inventoryItems['POTION_HP'].id == itemId then
            self.inventoryItems['POTION_HP'].count = self.inventoryItems['POTION_HP'].count + itemCount;
        elseif self.db.profile.buttonPotionWeakest and self.inventoryItems['POTION_HP'].minLevel > itemMinLevel then
            self:InventorySetItem('POTION_HP', itemId, itemCount, false);
        elseif (not self.db.profile.buttonPotionWeakest) and self.inventoryItems['POTION_HP'].minLevel < itemMinLevel then
            self:InventorySetItem('POTION_HP', itemId, itemCount, false);
        end
    -- is it a mana potion?
    elseif self.PT:ItemInSet(itemId, 'Consumable.Potion.Recovery.Mana.Basic') then
        if self.inventoryItems['POTION_MP'] == nil or self.inventoryItems['POTION_MP'].count <= 0 then
            self:InventorySetItem('POTION_MP', itemId, itemCount, false);
        elseif self.inventoryItems['POTION_MP'].id == itemId then
            self.inventoryItems['POTION_MP'].count = self.inventoryItems['POTION_MP'].count + itemCount;
        elseif self.db.profile.buttonPotionWeakest and self.inventoryItems['POTION_MP'].minLevel > itemMinLevel then
            self:InventorySetItem('POTION_MP', itemId, itemCount, false);
        elseif (not self.db.profile.buttonPotionWeakest) and self.inventoryItems['POTION_MP'].minLevel < itemMinLevel then
            self:InventorySetItem('POTION_MP', itemId, itemCount, false);
        end
    -- is it some conjured food
    elseif self.PT:ItemInSet(itemId, 'Consumable.Food.Edible.Basic.Conjured') then
        if self.inventoryItems['FOOD'] == nil or self.inventoryItems['FOOD'].count <= 0 then
            self:InventorySetItem('FOOD', itemId, itemCount, true);  
        elseif self.inventoryItems['FOOD'].id == itemId then
            self.inventoryItems['FOOD'].count = self.inventoryItems['FOOD'].count + itemCount;
        elseif not self.inventoryItems['FOOD'].conjured then
            self:InventorySetItem('FOOD', itemId, itemCount, true); 
        elseif self.db.profile.buttonDrinkWeakest and self.inventoryItems['FOOD'].minLevel > itemMinLevel then
            self:InventorySetItem('FOOD', itemId, itemCount, true); 
        elseif (not self.db.profile.buttonDrinkWeakest) and self.inventoryItems['FOOD'].minLevel < itemMinLevel then
            self:InventorySetItem('FOOD', itemId, itemCount, true); 
        end
    -- is it some food
    elseif self.PT:ItemInSet(itemId, 'Consumable.Food.Edible.Basic.Non-Conjured') then
        if self.inventoryItems['FOOD'] == nil or self.inventoryItems['FOOD'].count <= 0 then
            self:InventorySetItem('FOOD', itemId, itemCount, false);  
        elseif self.inventoryItems['FOOD'].id == itemId then
            self.inventoryItems['FOOD'].count = self.inventoryItems['FOOD'].count + itemCount;
        elseif self.db.profile.buttonDrinkWeakest and (not self.inventoryItems['FOOD'].conjured) and self.inventoryItems['FOOD'].minLevel > itemMinLevel then
            self:InventorySetItem('FOOD', itemId, itemCount, false);  
        elseif (not self.db.profile.buttonDrinkWeakest) and (not self.inventoryItems['FOOD'].conjured) and self.inventoryItems['FOOD'].minLevel < itemMinLevel then
            self:InventorySetItem('FOOD', itemId, itemCount, false);  
        end
    -- is it a conjured drink
    elseif self.PT:ItemInSet(itemId, 'Consumable.Water.Conjured') then
        if self.inventoryItems['DRINK'] == nil or self.inventoryItems['DRINK'].count <= 0 then
            self:InventorySetItem('DRINK', itemId, itemCount, true);  
        elseif self.inventoryItems['DRINK'].id == itemId then
            self.inventoryItems['DRINK'].count = self.inventoryItems['DRINK'].count + itemCount;
        elseif not self.inventoryItems['DRINK'].conjured then
            self:InventorySetItem('DRINK', itemId, itemCount, true); 
        elseif self.db.profile.buttonDrinkWeakest and self.inventoryItems['DRINK'].minLevel > itemMinLevel then
            self:InventorySetItem('DRINK', itemId, itemCount, true); 
        elseif (not self.db.profile.buttonDrinkWeakest) and  self.inventoryItems['DRINK'].minLevel < itemMinLevel then
            self:InventorySetItem('DRINK', itemId, itemCount, true); 
        end
    -- is it a drink
    elseif self.PT:ItemInSet(itemId, 'Consumable.Water.Basic') then   
        if self.inventoryItems['DRINK'] == nil or self.inventoryItems['DRINK'].count <= 0 then
            self:InventorySetItem('DRINK', itemId, itemCount, false);  
        elseif self.inventoryItems['DRINK'].id == itemId then
            self.inventoryItems['DRINK'].count = self.inventoryItems['DRINK'].count + itemCount;
        elseif self.db.profile.buttonDrinkWeakest and (not self.inventoryItems['DRINK'].conjured) and self.inventoryItems['DRINK'].minLevel > itemMinLevel then
            self:InventorySetItem('DRINK', itemId, itemCount, false);  
        elseif (not self.db.profile.buttonDrinkWeakest) and (not self.inventoryItems['DRINK'].conjured) and self.inventoryItems['DRINK'].minLevel < itemMinLevel then
            self:InventorySetItem('DRINK', itemId, itemCount, false);  
        end
    -- is it a mount?
    elseif self.PT:ItemInSet(itemId, 'Misc.Mount.Normal') or self.PT:ItemInSet(itemId, 'Misc.Mount.Ahn\'Qiraj') or self.PT:ItemInSet(itemId, 'Misc.Mount.Flying') then
        -- normal/epic riding  mount
        if self.PT:ItemInSet(itemId, 'Misc.Mount.Normal') then
            if self.inventoryItems['MOUNTS'] == nil then
                self:InventorySetItem('MOUNTS', itemId, 1, false);  
            elseif self.inventoryItems['MOUNTS'].minLevel < itemMinLevel then
                self:InventorySetItem('MOUNTS', itemId, 1, false);  
            end
        end
        -- aq mount
        if self.PT:ItemInSet(itemId, 'Misc.Mount.Ahn\'Qiraj') then
            if self.inventoryItems['MOUNTS_AQ'] == nil then
                self:InventorySetItem('MOUNTS_AQ', itemId, false);  
            elseif self.inventoryItems['MOUNTS_AQ'].minLevel < itemMinLevel then
                self:InventorySetItem('MOUNTS_AQ', itemId, 1, false);  
            end        
        end
        -- flying mount 
        if self.PT:ItemInSet(itemId, 'Misc.Mount.Flying') then
		print ("mount F " ,itemId)	
		if self.inventoryItems['MOUNTS_FLY'] == nil then
                self:InventorySetItem('MOUNTS_FLY', itemId, 1, false);  
            elseif self.inventoryItems['MOUNTS_FLY'].minLevel < itemMinLevel then
                self:InventorySetItem('MOUNTS_FLY', itemId, 1, false);  
            end        
        end
    end
end

function SphereInventory:InventorySetItem(groupId, itemId, itemCount, conjured)
    local itemName, itemString, _, itemLevel, itemMinLevel, _, _, _, _, itemTexture = GetItemInfo(itemId);
    local itemTextureFile = 'WoWUnknownItem01';
    if itemTexture ~= nil then 
        _, _, itemTextureFile = string.find(itemTexture, '([^\\]+)$'); 
    end
    if Venantes.playerData.level ~= nil and itemMinLevel ~= nil and itemMinLevel <= Venantes.playerData.level then
        if self.inventoryItems[groupId] == nil then
            self.inventoryItems[groupId] = {};
        end
        self.inventoryItems[groupId]['id'] = itemId;
        self.inventoryItems[groupId]['name'] = itemName;
        self.inventoryItems[groupId]['count'] = itemCount;
        self.inventoryItems[groupId]['minLevel'] = itemMinLevel;
        self.inventoryItems[groupId]['texture'] = itemTextureFile;
        self.inventoryItems[groupId]['conjured'] = conjured;
        self.inventoryItems[groupId]['spell'] = GetItemSpell(itemName);
    end
end

function SphereInventory:InventoryParseLink(linkStr) 
	if (linkStr) then
		local _, _, id = string.find(linkStr,'|Hitem:(%d+)');
		if (id) then
			return tonumber(id);
		end
	end
end

function SphereInventory:InventoryGetItemCooldown(itemName)
    if itemName ~= nil and itemName then
       --print ("itemName",itemName,Id) 
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
	itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =
    GetItemInfo(itemName)
	local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4,
    Suffix, Unique, LinkLvl, Name = string.find(itemLink,
    "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
	--print ("itemName",itemName,Id)
		local startTime, duration, enable = GetItemCooldown(Id);
        if enable and startTime ~= nil and startTime > 0 and duration ~= nil and duration > 1 then
            return math.floor(startTime - GetTime() + duration + 0.5);
        end
    end
    return 0;
end

function SphereInventory:InventoryGetItemData(groupId) 
    
	if self.inventoryItems ~= nil and self.inventoryItems[groupId] ~= nil then
        local cooldown = self:InventoryGetItemCooldown(self.inventoryItems[groupId].name); 
       -- print(self.inventoryItems[groupId].count, self.inventoryItems[groupId].name, self.inventoryItems[groupId].texture, self.inventoryItems[groupId].spell, cooldown)
		return self.inventoryItems[groupId].count, self.inventoryItems[groupId].name, self.inventoryItems[groupId].texture, self.inventoryItems[groupId].spell, cooldown;
    else
        return nil;
    end
end

function SphereInventory:InventoryGetMountData()
    local currentMount = nil;
    if  self.inventoryItems == nil then
        self.inventoryItems = {};
    end

	if Venantes.playerData.inAQ and self.inventoryItems['MOUNTS_AQ'] ~= nil then
        currentMount = 'MOUNTS_AQ';
    end
    if currentMount == nil and Venantes.playerData.inOutlands and self.inventoryItems['MOUNTS_FLY'] ~= nil then
        currentMount = 'MOUNTS_FLY';
    end
    if currentMount == nil and self.inventoryItems['MOUNTS'] ~= nil then
        currentMount = 'MOUNTS';
    end
    if currentMount ~= nil and self.inventoryItems[currentMount] ~= nil then
        return self.inventoryItems[currentMount].name, self.inventoryItems[currentMount].texture, self.inventoryItems[currentMount].spell;
    end
    return nil;
end

