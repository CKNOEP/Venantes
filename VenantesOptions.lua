------------------------------------------------------------------------------------------------------
-- Venantes Options Dialog
--
-- Dev : Zirah on Blackhand (EU, Alliance)
-- Maintainer: LädyGaga and Yinmaris on Sulfuron (EU, Alliance)
-- Based on Ideas by:
--   Serenity and Cryolysis by Kaeldra of Aegwynn 
--   Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
--   Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
------------------------------------------------------------------------------------------------------

VenantesOptions = {};
local SphereCore = LibStub:GetLibrary("SphereCore-3.0");
local SphereButtons = LibStub:GetLibrary("SphereButtons-2.0");

local L = LibStub("AceLocale-3.0"):GetLocale('Venantes');
local SphereInventory = LibStub:GetLibrary("SphereInventory-2.0");

VenantesOptions.tabFrameNames = { 'Sphere', 'Buttons', 'Messages', 'Inventory', 'Debug' };


-- Initialize the options
function VenantesOptions:Initialize()
    UIPanelWindows["VenantesOptionsFrame"] = { area = "LEFT", pushable = 5, whileDead = 1  };

    VenantesOptionsFrameTitleText:SetText(GetAddOnMetadata('Venantes', 'Title')..' '..GetAddOnMetadata('Venantes', 'Version'));
    
    -- make dragable
    VenantesOptionsFrame:RegisterForDrag('LeftButton');
    
    -- tooltips
    self:InitializeLabel(VenantesOptionsLabel_Tooltips);
    self:InitializeCheckbox(VenantesOptionsCheckButton_Tooltips, Venantes.db.profile.buttonTooltips);
    self:InitializeLabel(VenantesOptionsLabel_DefaultTooltips);
    self:InitializeCheckbox(VenantesOptionsCheckButton_DefaultTooltips, Venantes.db.profile.buttonDefaultTooltips);
    
    -- menu behaviuor
    self:InitializeLabel(VenantesOptionsLabel_MenuKeepOpen);
    self:InitializeCheckbox(VenantesOptionsCheckButton_MenuKeepOpen, Venantes.db.profile.menuKeepOpen);
    
    -- message options
    self:InitializeLabel(VenantesOptionsLabel_OnScreen);
    self:InitializeCheckbox(VenantesOptionsCheckButton_OnScreen, Venantes.db.profile.messagesOnScreen);
    self:InitializeLabel(VenantesOptionsLabel_DebugTexture);
    self:InitializeCheckbox(VenantesOptionsCheckButton_DebugTexture, Venantes.db.profile.messagesMissingTexture);
    self:InitializeLabel(VenantesOptionsLabel_Raid);
    self:InitializeCheckbox(VenantesOptionsCheckButton_Raid, Venantes.db.profile.messagesRaidMode);
    self:InitializeLabel(VenantesOptionsLabel_MsgRandom);
    self:InitializeCheckbox(VenantesOptionsCheckButton_MsgRandom, Venantes.db.profile.messagesRandom);
    self:InitializeLabel(VenantesOptionsLabel_MsgRandomHuntersMark);
    self:InitializeCheckbox(VenantesOptionsCheckButton_MsgRandomHuntersMark, Venantes.db.profile.messagesRandomHuntersMark);
    self:InitializeLabel(VenantesOptionsLabel_MsgRandomTranqShot);
    self:InitializeCheckbox(VenantesOptionsCheckButton_MsgRandomTranqShot, Venantes.db.profile.messagesRandomTranqShot);
    self:InitializeLabel(VenantesOptionsLabel_MsgRandomPetCall);
    self:InitializeCheckbox(VenantesOptionsCheckButton_MsgRandomPetCall, Venantes.db.profile.messagesRandomPetCall);
    self:InitializeLabel(VenantesOptionsLabel_MsgRandomPetRevive);
    self:InitializeCheckbox(VenantesOptionsCheckButton_MsgRandomPetRevive, Venantes.db.profile.messagesRandomPetRevive);
    self:InitializeLabel(VenantesOptionsLabel_MsgRandomMount);
    self:InitializeCheckbox(VenantesOptionsCheckButton_MsgRandomMount, Venantes.db.profile.messagesRandomMount);
    self:InitializeSlider(VenantesOptionsSlider_MsgRandomLanguage, Venantes.db.profile.messagesLanguage, L['MESSAGES_LANGUAGE']);
    VenantesOptionsSlider_MsgRandomLanguage:SetMinMaxValues(1, SphereCore:GetSpeechLanguageCount());
    
    -- Sphere Options
    self:InitializeLabel(VenantesOptionsLabel_LockSphere);
    self:InitializeLabel(VenantesOptionsLabel_LockButtons);
    self:InitializeLabel(VenantesOptionsLabel_ButtonOrderCCW);
    self:InitializeCheckbox(VenantesOptionsCheckButton_SphereLocking, Venantes.db.profile.sphereLocking);
    self:InitializeCheckbox(VenantesOptionsCheckButton_ButtonLocking, Venantes.db.profile.buttonLocking);
    self:InitializeCheckbox(VenantesOptionsCheckButton_ButtonOrderCCW, Venantes.db.profile.buttonOrderCCW);
    VenantesOptionsSlider_SphereSkin:SetMinMaxValues(1, SphereButtons:SphereGetSkinsCount());
    self:InitializeSlider(VenantesOptionsSlider_SphereSkin, Venantes.db.profile.sphereSkin, L['SPHERE_SKIN']);
    self:InitializeSlider(VenantesOptionsSlider_SphereRotation, Venantes.db.profile.sphereRotation, L['SPHERE_ROTATION']);
    self:InitializeSlider(VenantesOptionsSlider_SphereOpacity, Venantes.db.profile.sphereOpacity, L['SPHERE_OPACITY']);
    self:InitializeSlider(VenantesOptionsSlider_ButtonOpacity, Venantes.db.profile.buttonOpacity, L['BUTTON_OPACITY']);
    self:InitializeSlider(VenantesOptionsSlider_SphereScale, Venantes.db.profile.sphereScale, L['SPHERE_SCALE']);
    self:InitializeSlider(VenantesOptionsSlider_ButtonScale, Venantes.db.profile.buttonScale, L['BUTTON_SCALE']);
    local sphereCircleStatusCount, sphereTextStatusCount = SphereButtons:SphereGetStatusCount();
    VenantesOptionsSlider_SphereCircle:SetMinMaxValues(0, sphereCircleStatusCount);
    self:InitializeSlider(VenantesOptionsSlider_SphereCircle, Venantes.db.profile.sphereStatusCircle, L['SPHERE_CIRCLE']);
    VenantesOptionsSlider_SphereText:SetMinMaxValues(0, sphereTextStatusCount);
    self:InitializeSlider(VenantesOptionsSlider_SphereText, Venantes.db.profile.sphereStatusText, L['SPHERE_TEXT']);
    VenantesOptionsSlider_SphereActionLeft:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
    self:InitializeSlider(VenantesOptionsSlider_SphereActionLeft, Venantes.db.profile.sphereActionLeft, L['TOOLTIP_LEFTCLICK']);
    VenantesOptionsSlider_SphereActionRight:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
  
    self:InitializeSlider(VenantesOptionsSlider_SphereActionRight, Venantes.db.profile.sphereActionRight, L['TOOLTIP_RIGHTCLICK']);
    -- button options
    self:InitializeLabel(VenantesOptionsLabel_ShowButtons);
    self:InitializeLabel(VenantesOptionsLabel_Drink);
    self:InitializeCheckbox(VenantesOptionsCheckButton_Drink, Venantes.db.profile.buttonDrinkVisible);
    self:InitializeLabel(VenantesOptionsLabel_DrinkWeakest);
    self:InitializeCheckbox(VenantesOptionsCheckButton_DrinkWeakest, Venantes.db.profile.buttonDrinkWeakest);
    self:InitializeLabel(VenantesOptionsLabel_Potion);
    self:InitializeCheckbox(VenantesOptionsCheckButton_Potion, Venantes.db.profile.buttonPotionVisible);
    self:InitializeLabel(VenantesOptionsLabel_PotionWeakest);
    self:InitializeCheckbox(VenantesOptionsCheckButton_PotionWeakest, Venantes.db.profile.buttonPotionWeakest);
    self:InitializeLabel(VenantesOptionsLabel_Mount);
    self:InitializeCheckbox(VenantesOptionsCheckButton_Mount, Venantes.db.profile.buttonMountVisible);
    self:InitializeLabel(VenantesOptionsLabel_PetMenu);
    self:InitializeCheckbox(VenantesOptionsCheckButton_PetMenu, Venantes.db.profile.buttonPetMenuVisible);
    self:InitializeLabel(VenantesOptionsLabel_AspectMenu);
    self:InitializeCheckbox(VenantesOptionsCheckButton_AspectMenu, Venantes.db.profile.buttonAspectMenuVisible);
    self:InitializeLabel(VenantesOptionsLabel_TrackingMenu);
    self:InitializeCheckbox(VenantesOptionsCheckButton_TrackingMenu, Venantes.db.profile.buttonTrackingMenuVisible);
    self:InitializeLabel(VenantesOptionsLabel_TrapsMenu);
    self:InitializeCheckbox(VenantesOptionsCheckButton_TrapsMenu, Venantes.db.profile.buttonTrapsMenuVisible);
    -- action button options
    self:InitializeLabel(VenantesOptionsLabel_ActionOne);
    self:InitializeCheckbox(VenantesOptionsCheckButton_ActionOne, Venantes.db.profile.buttonActionOneVisible);
    VenantesOptionsSlider_ActionOneLeft:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
    self:InitializeSlider(VenantesOptionsSlider_ActionOneLeft, Venantes.db.profile.buttonActionOneLeft, L['TOOLTIP_LEFTCLICK']);
    VenantesOptionsSlider_ActionOneRight:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
    self:InitializeSlider(VenantesOptionsSlider_ActionOneRight, Venantes.db.profile.buttonActionOneRight, L['TOOLTIP_RIGHTCLICK']);
    self:InitializeLabel(VenantesOptionsLabel_ActionTwo);
    self:InitializeCheckbox(VenantesOptionsCheckButton_ActionTwo, Venantes.db.profile.buttonActionTwoVisible);
    VenantesOptionsSlider_ActionTwoLeft:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
    self:InitializeSlider(VenantesOptionsSlider_ActionTwoLeft, Venantes.db.profile.buttonActionTwoLeft, L['TOOLTIP_LEFTCLICK']);
    VenantesOptionsSlider_ActionTwoRight:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
    self:InitializeSlider(VenantesOptionsSlider_ActionTwoRight, Venantes.db.profile.buttonActionTwoRight, L['TOOLTIP_RIGHTCLICK']);
    self:InitializeLabel(VenantesOptionsLabel_ActionThree);
    self:InitializeCheckbox(VenantesOptionsCheckButton_ActionThree, Venantes.db.profile.buttonActionThreeVisible);
    VenantesOptionsSlider_ActionThreeLeft:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
    self:InitializeSlider(VenantesOptionsSlider_ActionThreeLeft, Venantes.db.profile.buttonActionThreeLeft, L['TOOLTIP_LEFTCLICK']);
    VenantesOptionsSlider_ActionThreeRight:SetMinMaxValues(0, SphereButtons:ButtonGetActionCount());
    self:InitializeSlider(VenantesOptionsSlider_ActionThreeRight, Venantes.db.profile.buttonActionThreeRight, L['TOOLTIP_RIGHTCLICK']);   

    -- debug 
    self:InitializeLabel(VenantesOptionsDebugItemTitle);
    self:InitializeLabel(VenantesOptionsDebugTexture);
    self:ShowTextureMessages();
  
    self:TabButtonClick('Sphere', 'TAB_SPHERE');
end

function VenantesOptions:UpdateData() 
    self:ShowTextureMessages();
end

function VenantesOptions:ShowTextureMessages()
    local textureStr = '';
    if Venantes.missingTextures ~= nil and type(Venantes.missingTextures) == 'table' then
        for texture, _ in pairs(Venantes.missingTextures) do
            textureStr = texture..', '..textureStr;
        end
        VenantesOptionsDebugTextureMsgs:SetText(textureStr);
    end
end

function VenantesOptions:InitializeLabel(element) 
    if element ~= nil then
        local stringIdent = element:GetText();
        if L[stringIdent]  ~= nil then
            element:SetText(L[stringIdent])
        end
    end
end

function VenantesOptions:InitializeCheckbox(element, value) 
    if element ~= nil then
        element:SetChecked(value);
    end
end

function VenantesOptions:InitializeSlider(element, value, topText, leftText, rightText) 
    --print ("init slider",element, value, topText, leftText, rightText)
	if element ~= nil then
        element:SetValue(value);
        local elementName = element:GetName();
        if topText ~= nil then
            getglobal(elementName..'Text'):SetText(topText);
        end
        if leftText ~= nil then
            getglobal(elementName..'Low'):SetText(leftText);
        else
            getglobal(elementName..'Low'):SetText('');
        end
        if leftText ~= nil then
            getglobal(elementName..'High'):SetText(rightText);
        else
            getglobal(elementName..'High'):SetText('');
        end        
    end
end

function VenantesOptions:TabButtonClick(tabId, tabTitle)
    local tabFrame, tabButton;
	for i=1, table.getn(self.tabFrameNames), 1 do
		tabFrame = getglobal('VenantesOptionsFrame'..self.tabFrameNames[i]);
		tabButton = getglobal('VenantesOptionsTab'..self.tabFrameNames[i]);
        if tabId == self.tabFrameNames[i] then
            if tabButton ~= nil then
                tabButton:SetChecked(true);
            end
            if tabFrame ~= nil then
                ShowUIPanel(tabFrame);
            end
        else
            if tabButton ~= nil then
                tabButton:SetChecked(false);
            end
            if tabFrame ~= nil then
                HideUIPanel(tabFrame);
            end
        end
        if L[tabTitle] ~= nil then
            VenantesOptionsFrameSubTitleText:SetText(L[tabTitle]);
        end
	end
end

function VenantesOptions:ShowTooltip(element, elementId, anchor)  
  
	if not self.initialized then
        return;
    end

    GameTooltip:SetOwner(element, anchor);
	
 
    -- show value
    if elementId == 'VALUE' then    
        GameTooltip:AddLine(element:GetValue());
   
   elseif elementId == 'ACTION_VALUE' then -- The 3 Buttons    
        local actionIdx = math.floor(element:GetValue()+ 0.5);
        local actionType, actionName, _, _, _, _, actionSlotName = SphereButtons:ButtonGetActionInfo(actionIdx);
        
		
		
		if actionType == 'slot' and actionSlotName then
            local actionPrefix = actionSlotName;
            if L['SLOT_'..actionSlotName] ~= nil then
                actionPrefix = L['SLOT_'..actionSlotName];
            end
            if actionName ~= nil then
            --GameTooltip:AddLine(actionPrefix..': '..actionName);
            GameTooltip:AddDoubleLine(actionPrefix..': '..actionName, " ", 1, 1, 1, 1, 1, 1)
			--GameTooltip:AddDoubleLine("|T"..134532..":0|t ", " ", 1, 1, 1, 1, 1, 1)
			-- Texture
		
			--GameTooltip:AddTexture(134532)
			GameTooltip:AddLine(actionPrefix);
			GameTooltip:AddTexture(132329, {width = 32, height = 32})
				
			else 
                GameTooltip:AddLine(actionPrefix..': '..L['NONE']);
            end            
        else
           
		   local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(actionName)
		   
		   
			for i = 1, GetNumSpellTabs() do
				local _, _, offset, numSlots = GetSpellTabInfo(i)
				for j = offset+1, offset+numSlots do
					
				
				local spell_name = select(2,GetSpellBookItemInfo(j, BOOKTYPE_SPELL))
				local namespell_name = select(1,GetSpellInfo(spell_name))
		   
				if name == namespell_name then
				print(i, j, GetSpellBookItemInfo(j, BOOKTYPE_SPELL),name,namespell_name)
				ID_BOOKTYPE_SPELL = j
				end
				
				end
			end
		   
		   
		   
		   if actionName ~= nil then
                --GameTooltip:AddDoubleLine(actionName, " ", 1, 1, 1, 1, 1, 1)
    			--GameTooltip:AddTexture(132329, {width = 32, height = 32})       
				GameTooltip:SetSpellBookItem(ID_BOOKTYPE_SPELL,BOOKTYPE_SPELL)
		   else 
                GameTooltip:AddLine(L['NONE']);
           end
        end
    elseif elementId == 'SKIN' then   
        local skinName = SphereButtons:SphereGetSkinName(math.floor(element:GetValue() + 0.5)); 

		if skinName ~= nil then
            GameTooltip:AddLine(skinName);
        else 
            GameTooltip:AddLine('Solid');
        end
    elseif elementId == 'SPHERE_CIRCLE' then   
        local circleStatus = SphereButtons:SphereGetStatusInfo(math.floor(element:GetValue() + 0.5), nil); 
        if circleStatus ~= nil then
            if L['STATUS_'..circleStatus] ~= nil then
                GameTooltip:AddLine(L['STATUS_'..circleStatus]);
            else
                GameTooltip:AddLine(circleStatus);
            end
        else 
            GameTooltip:AddLine(L['NONE']);
        end
    elseif elementId == 'SPHERE_TEXT' then   
        local _, textStatus = SphereButtons:SphereGetStatusInfo(nil, math.floor(element:GetValue() + 0.5)); 
        if textStatus ~= nil then
            if L['STATUS_'..textStatus] ~= nil then
                GameTooltip:AddLine(L['STATUS_'..textStatus]);
            else
                GameTooltip:AddLine(textStatus);
            end
        else 
            GameTooltip:AddLine(L['NONE']);
        end        
    -- get directly from localisation
    elseif elementId == 'MSG_LANGUAGE' then
        GameTooltip:AddLine(SphereCore:GetSpeechLanguage(math.floor(element:GetValue()+ 0.5)));
    elseif L[elementId] ~= nil then    
        GameTooltip:AddLine(L[elementId]);
    end
  
	-- and done, show it!
	GameTooltip:Show();
end

function VenantesOptions:HideTooltip()
    GameTooltip:Hide();
end

function VenantesOptions:Invalidate(status, positions, dragable)
    if dragable then
        SphereButtons:ButtonSetDragable();
        SphereButtons:ButtonSetPositions();
    elseif positions then
        SphereButtons:ButtonSetPositions();
        SphereButtons:ButtonUpdateMenus();
    end
    if status then
        Venantes:UpdateActions();
    end
    Venantes:UpdateStatus();
end

function VenantesOptions:SetOptionSlider(element, optionName) 

   local optionValue = math.floor(element:GetValue()+ 0.5);
   
	Venantes.db.profile[optionName] = optionValue;
end

function VenantesOptions:RoundValueSlider(input)
 
 return math.floor(input + 0.5);
 
end


function VenantesOptions:SetOptionCheckbox(element, optionName) 
    local checked = element:GetChecked();
    if (checked) then
        Venantes.db.profile[optionName] = true;
    else
        Venantes.db.profile[optionName] = false;
    end
end

function VenantesOptions:OnDebugItemDrop() 
    if CursorHasItem() then
        if GetCursorInfo ~= nil then
            local cursorType, itemId = GetCursorInfo();
            if itemId ~= nil then
                local itemName, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemId);
                if itemName ~= nil then
                    VenantesOptionsDebugItemIcon:SetTexture(itemTexture);
                    VenantesOptionsDebugItemEdit:SetText(itemName..' - '..itemId);
                end
            end
        else
            SphereCore:ShowMessage('Sorry, but this works only in WoW >= 2.0.3', 'USER');
        end
    end
end
function VenantesOptions:InventoryScan() 
SphereInventory:InventoryScan() 
end