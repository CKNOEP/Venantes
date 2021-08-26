VenantesFuBar = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "FuBarPlugin-2.0");

VenantesFuBar.name = "Venantes";
VenantesFuBar.version = Venantes.versions;
VenantesFuBar.date = Venantes.date;
VenantesFuBar.hasIcon = "Interface\\Icons\\INV_Weapon_Bow_07";
VenantesFuBar.hasNoColor = true;
VenantesFuBar.defaultMinimapPosition = 285;
VenantesFuBar.clickableTooltip = false;
VenantesFuBar.hideWithoutStandby = true;
VenantesFuBar.independentProfile = true;
VenantesFuBar.cannotDetachTooltip = true;

-- localisation

function VenantesFuBar:OnInitialize()
	self.db = Venantes:AcquireDBNamespace("fubar");
	fubarOptions = {
		type = 'group',
        args = {}
	}
	self.OnMenuRequest = fubarOptions;
end

local L = AceLibrary('AceLocale-2.2'):new('Venantes');
local Tablet = AceLibrary("Tablet-2.0");

function VenantesFuBar:OnTooltipUpdate()
    GameTooltip:Hide();
	local cat = Tablet:AddCategory("columns", 2)
    local ammoCount, ammoName = Venantes:GetAmmoCount(L['AMMO']);
    if ammoName ~= nil then
        cat:AddLine('text', '|cffffffff'..ammoName..': |r', 'text2', ammoCount);
    end
    local itemCount, itemName = Venantes:InventoryGetItemData('DRINK');
    if itemName ~= nil and itemCount ~= nil then
        cat:AddLine('text', '|cffffffff'..itemName..': |r', 'text2', itemCount);
    end
    local itemCount, itemName = Venantes:InventoryGetItemData('FOOD');
    if itemName ~= nil and itemCount ~= nil then
        cat:AddLine('text', '|cffffffff'..itemName..': |r', 'text2', itemCount);
    end
    local itemCount, itemName = Venantes:InventoryGetItemData('POTION_MP');
    if itemName ~= nil and itemCount ~= nil then
        cat:AddLine('text', '|cffffffff'..itemName..': |r', 'text2', itemCount);
    end
    local itemCount, itemName = Venantes:InventoryGetItemData('POTION_HP');
    if itemName ~= nil and itemCount ~= nil then
        cat:AddLine('text', '|cffffffff'..itemName..': |r', 'text2', itemCount);
    end
	Tablet:SetHint(L['CLICK_TOGGLE_CONFIG']);
end

function VenantesFuBar:OnClick(button)
    GameTooltip:Hide();
    VenantesConfig_Toggle();
end
