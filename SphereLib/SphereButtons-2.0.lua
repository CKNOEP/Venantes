--[[
Name: SphereButtons-2.0
Revision: $Rev: 10000 $
Maintainer: LädyGaga and Yinmaris on Sulfuron (EU, Alliance)

Description: inventory handling for sphere addons
Dependencies: Ace3
]]

local MAJOR_VERSION,MINOR_VERSION = "SphereButtons-2.0", 1
local LibStub = _G.LibStub
local SphereButtons = LibStub:NewLibrary("SphereButtons-2.0", 1)
if not SphereButtons then  return end -- already loaded and no upgrade necessary
local SphereCore = LibStub:GetLibrary("SphereCore-3.0");

--SphereButtons =  {}
-- icon texture path table


-- button setup and positions


function SphereButtons:ButtonSetup(buttonPrefix, buttonWidgets)
    --setup des boutons autour de la sphere
	if self.buttons == nil then
        self.buttons = {};
    end
    self.buttons.prefix = buttonPrefix;
    self.buttons.widgets = buttonWidgets;
    self.buttons.skin = self:SphereGetSkinName(Venantes.db.profile.sphereSkin);
	--self.buttons.skin = self:SphereGetSkinName(1);
    
     _G[self.buttons.prefix..'Sphere']:RegisterForClicks('LeftButtonUp', 'MiddleButtonUp', 'RightButtonUp');
    for i=1, table.getn(self.buttons.widgets), 1 do
        -- make clickable
        local button = _G[self.buttons.prefix..'Button'..self.buttons.widgets[i]];
        --print (button:GetName())
		if button ~= nil then
            button:RegisterForClicks('LeftButtonUp', 'MiddleButtonUp', 'RightButtonUp');
            -- artwork texture 
            local textureBorder = button:CreateTexture(self.buttons.prefix..'Button'..self.buttons.widgets[i]..'_Border', 'BORDER');
            textureBorder:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\ButtonBorder');
            textureBorder:SetWidth(button:GetWidth());
            textureBorder:SetHeight(button:GetHeight());
            textureBorder:SetPoint('CENTER', button, 'CENTER', 0, 0);
        end
    end
    self:ButtonSetPositions();
    self:ButtonSetDragable();
end

-- register status modes for sphere
function SphereButtons:SphereRegisterStatus(sphereCircleStatus, sphereTextStatus)
    if self.sphere == nil then
      self.sphere = {};
    end
    if sphereCircleStatus ~= nil then
        self.sphere.circleStatus = sphereCircleStatus;
    else
        self.sphere.circleStatus = {};
    end
    if sphereTextStatus ~= nil then
        self.sphere.textStatus = sphereTextStatus;
    else
        self.sphere.textStatus = {};
    end
end

-- get status mode count
function SphereButtons:SphereGetStatusCount()
    local circleStatusCount = 0;
    local textStatusCount = 0;
    if self.sphere.circleStatus ~= nil then
        circleStatusCount = table.getn(self.sphere.circleStatus);
    end
    if self.sphere.textStatus ~= nil then
        textStatusCount = table.getn(self.sphere.textStatus);
    end
    return circleStatusCount, textStatusCount;
end

-- get current status mode
function SphereButtons:SphereGetStatusInfo(sphereCircleStatus, sphereTextStatus)
    if self.sphere == nil then
      self.sphere = {};
    end
    local circleStatus = nil;
    local textStatus = nil;
    if self.sphere.circleStatus ~= nil and self.sphere.circleStatus[sphereCircleStatus] ~= nil then
        circleStatus = self.sphere.circleStatus[sphereCircleStatus];
    end
    if self.sphere.textStatus ~= nil and self.sphere.textStatus[sphereTextStatus] ~= nil then
        textStatus = self.sphere.textStatus[sphereTextStatus];
    end
    return circleStatus, textStatus;
end

-- set status 
function SphereButtons:SphereSetStatusValues(sphereCircleValue, sphereTextValue)
    if sphereCircleValue ~= nil then
        if sphereCircleValue < 0 then 
            sphereCircleValue = 0;
        elseif sphereCircleValue > 16 then
            sphereCircleValue = 16;        
        end
        local sphereCircle = _G[self.buttons.prefix..'CircleShards'];
        if sphereCircle ~= nil then
            sphereCircle:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\Shards\\Shard'..sphereCircleValue);
        end
    end
    if sphereTextValue ~= nil then
        local sphereText = _G[self.buttons.prefix..'SphereCaption'];
        if  sphereText ~= nil then
            sphereText:SetText(sphereTextValue);
        end
    end
end

function SphereButtons:SphereRegisterSkins(skins)
    if self.buttons == nil then
        self.buttons = {};
    end
    if skins then
        self.buttons.skins = skins;
    end
end

function SphereButtons:SphereGetSkinsCount()
    if self.buttons ~= nil and self.buttons.skins ~= nil then
        return table.getn(self.buttons.skins);
    else
        return 0;
    end
end

function SphereButtons:SphereGetSkinName(skinId)
    
	
	if self.buttons ~= nil and self.buttons.skins ~= nil and self.buttons.skins[skinId] ~= nil then

		return self.buttons.skins[skinId];
    --elseif self.buttons ~= nil and self.buttons.skins ~= nil and self.buttons.skins[1] ~= nil then
        --return self.buttons.skins[1];    
    else
        --return 'Solid?';
    end
end

function SphereButtons:ButtonRegisterMenu(menuId, menuActions)--Boutons Menu autours de la sphère
    
	if self.buttons == nil then
        self.buttons = {};
    end
    if self.buttons.menus == nil then
        self.buttons.menus = {}
    end
    self.buttons.menus[menuId] = menuActions;
end

function SphereButtons:ButtonUpdateMenuStatus() -- Petits boutons des menus
    if self.buttons ~= nil and self.buttons.menus ~= nil then
        local currentMana = UnitPower("player", SPELL_POWER_MANA);
        if currentMana == nil then
            currentMana = 0;
        end
        for menuId, menuActions in pairs(self.buttons.menus) do
            local menuButton = _G[self.buttons.prefix..'Button'..menuId];
            if menuButton ~= nil then            
                for i = 1, table.getn(menuActions), 1 do
                    local buttonId = menuId..i;
                    -- type, name, texture, tooltip, cooldown, mana
                    local actionType, actionName, _, _, actionCooldown, actionMana = SphereCore:Get_ActionInfo(menuActions[i].type, menuActions[i].data);
					--print (buttonId, actionType, actionName, actionCooldown, actionMana )	
					

				   if actionType ~= nil and actionName ~= nil then
                        local buttonEnabled = true;
                        if actionCooldown and actionCooldown > 0 then
                            cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionCooldown);
                            if cooldownString then
                                self:ButtonSetCaption(buttonId, self:GetButtonCooldownStr(cooldownString, cooldownUnit));
                                buttonEnabled = false;
                            else
                                self:ButtonSetCaption(buttonId, '');        
                            end
                        else 
                            self:ButtonSetCaption(buttonId, '');
                        end
                        if actionMana and actionMana > currentMana then
                            buttonEnabled = false;
                        end
                        if buttonEnabled then
                            self:ButtonSetStatus(buttonId, true);
                        else           
                            self:ButtonSetStatus(buttonId, false);                        
                        end
                    end
                end
            end
        end
    end
end
 
function SphereButtons:ButtonUpdateMenus()
    if self.buttons ~= nil and self.buttons.menus ~= nil then
        for menuId, menuActions in pairs(self.buttons.menus) do
            local menuButton = _G[self.buttons.prefix..'Button'..menuId];
            if menuButton ~= nil then
                local menuStateHeader = _G[self.buttons.prefix..'Button'..menuId..'StateHeader'];
                print (menuStateHeader)
				if menuStateHeader == nil then -- init
                    -- create state header
                    --Introduit a WLTK Patch 3.0 - SecureHandlerClickTemplate
				--  menuStateHeader = CreateFrame('Frame', self.buttons.prefix..'Button'..menuId..'StateHeader', nil, "SecureHandlerAttributeTemplate SecureHandlerClickTemplate SecureHandlerEnterLeaveTemplate");
                    menuStateHeader = CreateFrame('Frame', self.buttons.prefix..'Button'..menuId..'StateHeader', nil,  'SecureHandlerStateTemplate SecureHandlerAttributeTemplate');

                    menuStateHeader:SetAllPoints(menuButton);     
                    
                    -- events to childs
                    menuButton:SetAttribute('childraise1', true);
                    menuButton:SetAttribute('childstate1', '$input');
                    
                    -- mouse down
                    menuButton:SetAttribute('onmousedownbutton1', 'mdn');
                    menuButton:SetAttribute('anchorchild-mdn', menuStateHeader);
                    menuButton:SetAttribute('childstate-mdn', '^mousedown');
                    menuButton:SetAttribute('childreparent-mdn', 'true');
                            
                    -- mouse up
                    menuButton:SetAttribute('onmouseupbutton1', 'mup');
                    menuButton:SetAttribute('anchorchild-mup', menuStateHeader);
                    menuButton:SetAttribute('childstate-mup', 'mouseup');
                    menuButton:SetAttribute('childverify-mup', true);
                        
                    -- statemaps
                    menuStateHeader:SetAttribute('state', 0);
                    menuStateHeader:SetAttribute('statemap-anchor-mousedown', '1-0');
                    menuStateHeader:SetAttribute('statemap-anchor-mouseup', '1:');
                    menuStateHeader:SetAttribute('delaystatemap-anchor-mouseup', '1:0');
                    menuStateHeader:SetAttribute('delaytimemap-anchor-mouseup', '4');
                    menuStateHeader:SetAttribute('delayhovermap-anchor-mouseup', 'true');                    
                end
               
				if Venantes.db.profile.menuKeepOpen then
                    menuButton:SetAttribute('onmouseupbutton1', '');                
                elseif Venantes.db.profile.menuCloseTimeout and Venantes.db.profile.menuCloseTimeout > 0 then
                    menuButton:SetAttribute('onmouseupbutton1', 'mup');                
                    menuStateHeader:SetAttribute('delaytimemap-anchor-mouseup', Venantes.db.profile.menuCloseTimeout);
                print (Venantes.db.profile.menuCloseTimeout , Venantes.db.profile.menuCloseTimeout) 
				else
                    menuButton:SetAttribute('onmouseupbutton1', '');                
                end                
                
                
				local relPoint = menuButton;
                local relOffsetY = 0;
                local relFactorY = 0;
                local relReverseY = false;
                local buttonOffset = 5;
                local relDirection = 'LEFT';
                if Venantes.db.profile.buttonLocking and self.buttons.positions ~= nil and self.buttons.positions[menuId] ~= nil then
                    local menuPos = self.buttons.positions[menuId];
                    if menuPos < 90 then 
                        --menu right top
                        relFactorY = menuPos;
                        relDirection = 'RIGHT';                    
                    elseif menuPos < 180 then
                        --menu left top
                        relFactorY = 180 - menuPos;
                        relDirection = 'LEFT';                    
                    elseif menuPos < 270 then
                        --menu left bottom
                        relFactorY = - (270 - menuPos);
                        relDirection = 'LEFT';
                        relReverseY = true;
                    else
                        --menu right bottom
                        relFactorY = - (360 - menuPos);
                        relDirection = 'RIGHT';                    
                    end
                    if not (relFactorY == 0) then
                        relOffsetY = math.floor(relFactorY * 8 / 90) * 2;
                        if relReverseY then
                            relOffsetY = -16 - relOffsetY;
                        end
                    end
                elseif UIParent ~= nil then
                    local uiCenterX = UIParent:GetWidth() / 2;
                    local buttonCenterX = menuButton:GetCenter();
                    if buttonCenterX > uiCenterX then
                        relDirection = 'LEFT';
                    else 
                        relDirection = 'RIGHT';
                    end                
                end
                for i = 1, table.getn(menuActions), 1 do
                    local button = _G[self.buttons.prefix..'Button'..menuId..i];
                    local actionType, actionName, actionTexture = SphereCore:Get_ActionInfo(menuActions[i].type, menuActions[i].data);
                   -- print (actionType, actionName, actionTexture)
					if actionType ~= nil and actionName ~= nil and actionTexture ~= nil then
                        if button == nil then
                           --print ("D", self.buttons.prefix..'DynamicButtonTemplate')
							button = CreateFrame('Button', self.buttons.prefix..'Button'..menuId..i, menuStateHeader, self.buttons.prefix..'DynamicButtonTemplate');
                            -- artwork
                            local textureBorder = button:CreateTexture(self.buttons.prefix..'Button'..menuId..i..'_Border', 'BORDER');
                            textureBorder:SetWidth(button:GetWidth());
                            textureBorder:SetHeight(button:GetHeight());
                            textureBorder:SetPoint('CENTER', button, 'CENTER', 0, 0);                            
                            -- Hide in state 0, show in all other states
                            button:SetAttribute('hidestates', '0');
                            -- Add the btn to the driver header
                            menuStateHeader:SetAttribute('addchild', button);
                        end
                        -- set skin
                        _G[self.buttons.prefix..'Button'..menuId..i..'_Border']:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\ButtonBorder');
                        button:SetHighlightTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\ButtonHighlight');
                        button:SetAlpha(Venantes.db.profile.buttonOpacity / 100);
                            
                        -- Hide button after click?
                        if Venantes.db.profile.menuKeepOpen then
                            button:SetAttribute('newstate', '');
                        else
                            button:SetAttribute('newstate', '0');
                        end
                        
                        if relDirection == 'LEFT' then          
                            button:SetPoint('LEFT', relPoint, relDirection, -(button:GetWidth() - buttonOffset), relOffsetY); 
                        else 
                            button:SetPoint('LEFT', relPoint, relDirection, -buttonOffset, relOffsetY);
                        end
                        relOffsetY = 0;
                        relPoint = button;
                        if actionType == 'spell' or actionType == 'item' then
                            button:SetAttribute('type1', actionType);
                            button:SetAttribute(actionType..'1', actionName);
                            buttonTexture = _G[button:GetName()..'_Icon'];
                            
							if not buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\'..actionTexture) then
                                buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\WoWUnknownItem01');
                                self:DebugTexture(actionTexture);
                            else
							--buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\'..actionTexture) 
							--print ("T File path",buttonTexture:GetTextureFilePath())
							local str = buttonTexture:GetTextureFilePath()
							if strmatch(str, "^%-?[%d%.]+%d$") then 
							--print("String") 
							else
							--print("integer")
							local Bt_Texture = Venantes:Get_Texture_Path(VENANTES_SPELLS_TEXTURE,actionTexture)
							--print(actionTexture,Bt_Texture,actionTexture)
							if Bt_Texture then 
							buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\'..Bt_Texture) 
							end
							
							--buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\'..Texture) 
							--print(buttonTexture:GetTextureFilePath())
							end
							
							
							
							end
                        end
					HideUIPanel(button);
                    elseif button ~= nil then
                        print ("hide", button:GetName())
						HideUIPanel(button);
                    end
                end
            end
        end
    end
end

-- register button actions
function SphereButtons:ButtonRegisterActions(actionsTable) 
    if actionsTable ~= nil then
        self.buttons.actions = actionsTable;
    else
        self.buttons.actions = {};
    end
end

-- get button action count 
function SphereButtons:ButtonGetActionCount()
    if self.buttons.actions ~= nil then
        return table.getn(self.buttons.actions);
    else
        return 0;
    end
end

-- get button action infos
function SphereButtons:ButtonGetActionInfo(actionId) 
    if self.buttons.actions ~= nil and self.buttons.actions[actionId] ~= nil then
    
	--print(SphereCore:Get_ActionInfo(self.buttons.actions[actionId].type, self.buttons.actions[actionId].data))
    return SphereCore:Get_ActionInfo(self.buttons.actions[actionId].type, self.buttons.actions[actionId].data);
    
	end
    return;
end
-- permet d'afficher le temps restant du CD dans le bouton
function SphereButtons:ButtonSetCaption(buttonId, text) 
    local buttonCaption = _G[self.buttons.prefix..'Button'..buttonId..'_Caption'];
    if buttonCaption ~= nil then
        if text ~= nil then
            buttonCaption:SetText(text);
        else
            buttonCaption:SetText('');        
        end
    --print (buttonId, text, buttonCaption:GetText())
	end
end

-- set button icon
function SphereButtons:ButtonSetIcon(buttonId, texture)
    local buttonTexture = _G[self.buttons.prefix..'Button'..buttonId..'_Icon'];
    --print ("tex",buttonTexture,texture)
	if buttonTexture ~= nil then
        if texture == 'DEFAULT' then
            buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\WoWUnknownItem01');
      
		elseif not buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\'..texture) then            
            --buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\WoWUnknownItem01');
            buttonTexture:SetTexture(texture)
			self:DebugTexture(texture);
        else
		--buttonTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\'..texture)
		buttonTexture:SetTexture(texture)
		
		end
    --print("GT ",buttonTexture:GetName(),buttonTexture:GetTexture(),buttonTexture:GetTextureFilePath() )
	end
end


-- set button item action
function SphereButtons:ButtonSetItem(buttonId, mouseButton, itemName) 
    local button = _G[self.buttons.prefix..'Button'..buttonId];
    if button ~= nil then
        if mouseButton == 'LeftButton' then
            button:SetAttribute('type1', 'item');
            button:SetAttribute('item1', itemName);
        elseif mouseButton == 'RightButton' then
            button:SetAttribute('type2', 'item');
            button:SetAttribute('item2', itemName);
        elseif mouseButton == 'MiddleButton' then
            button:SetAttribute('type3', 'item');
            button:SetAttribute('item3', itemName);        
        end
    end
end

-- set button spell action
function SphereButtons:ButtonSetSpell(buttonId, mouseButton, spellName) 
    local button = _G[self.buttons.prefix..'Button'..buttonId];
    if button ~= nil then
        if mouseButton == 'LeftButton' then
            button:SetAttribute('type1', 'spell');
            button:SetAttribute('spell1', spellName);
        elseif mouseButton == 'RightButton' then
            button:SetAttribute('type2', 'spell');
            button:SetAttribute('spell2', spellName);
        elseif mouseButton == 'MiddleButton' then
            button:SetAttribute('type3', 'spell');
            button:SetAttribute('spell3', spellName);        
        end
    end
end

-- set button macro action
function SphereButtons:ButtonSetMacro(buttonId, mouseButton, macroText) 
    local button = _G[self.buttons.prefix..'Button'..buttonId];
    if button ~= nil then
        if mouseButton == 'LeftButton' then
            button:SetAttribute('type1', 'macro');
            button:SetAttribute('macrotext1', macroText);
        elseif mouseButton == 'RightButton' then
            button:SetAttribute('type2', 'macro');
            button:SetAttribute('macrotext2', macroText);
        elseif mouseButton == 'MiddleButton' then
            button:SetAttribute('type3', 'macro');
            button:SetAttribute('macrotext3', macroText);        
        end
    end
end

-- set sphere item action
function SphereButtons:SphereSetItem(mouseButton, itemName) 
    local sphere = _G[self.buttons.prefix..'Sphere'];
    if sphere ~= nil then
        if mouseButton == 'LeftButton' then
            sphere:SetAttribute('type1', 'item');
            sphere:SetAttribute('item1', itemName);
        elseif mouseButton == 'RightButton' then
            sphere:SetAttribute('type2', 'item');
            sphere:SetAttribute('item2', itemName);
        elseif mouseButton == 'MiddleButton' then
            sphere:SetAttribute('type3', 'item');
            sphere:SetAttribute('item3', itemName);        
        end
    end
end

-- set sphere spell action
function SphereButtons:SphereSetSpell(mouseButton, spellName) 
    local sphere = _G[self.buttons.prefix..'Sphere'];
    if sphere ~= nil then
        if mouseButton == 'LeftButton' then
            sphere:SetAttribute('type1', 'spell');
            sphere:SetAttribute('spell1', spellName);
        elseif mouseButton == 'RightButton' then
            sphere:SetAttribute('type2', 'spell');
            sphere:SetAttribute('spell2', spellName);
        elseif mouseButton == 'MiddleButton' then
            sphere:SetAttribute('type3', 'spell');
            sphere:SetAttribute('spell3', spellName);        
        end
    end
end

-- set button enabled/disabled
function SphereButtons:ButtonSetStatus(buttonId, enabled)
    local buttonTexture = _G[self.buttons.prefix..'Button'..buttonId..'_Icon'];
    if buttonTexture ~= nil then
        if enabled then
            buttonTexture:SetVertexColor(1.0, 1.0, 1.0);
        else
            buttonTexture:SetVertexColor(0.5, 0.3, 0.3);
        end
    end
end

-- set all button positions and size
function SphereButtons:ButtonSetPositions()
    self.buttons.skin = self:SphereGetSkinName(Venantes.db.profile.sphereSkin);
    local scale = Venantes.db.profile.sphereScale / 100;
    local sphere = _G[self.buttons.prefix..'Sphere'];
    sphere:SetScale(scale);
    sphere:SetAlpha(Venantes.db.profile.sphereOpacity / 100);

    _G[self.buttons.prefix..'Sphere_Border']:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\SphereBorder');
    _G[self.buttons.prefix..'Sphere_Icon']:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\SphereIcon');
    _G[self.buttons.prefix..'Sphere_Highlight']:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\SphereHighlight');
    
    _G[self.buttons.prefix..'Circle']:SetScale(scale);
    _G[self.buttons.prefix..'Circle']:SetAlpha(Venantes.db.profile.sphereOpacity / 100);--(Venantes.db.profile.sphereOpacity / 100);
    local currentPos = 0;
    for i=1, table.getn(self.buttons.widgets), 1 do
        local button = _G[self.buttons.prefix..'Button'..self.buttons.widgets[i]];
        if button ~= nil then
            if Venantes.db.profile['button'..self.buttons.widgets[i]..'Visible'] then
                self:ButtonSetPosition(self.buttons.widgets[i], currentPos);
                currentPos = currentPos + 1;
               -- print("Show ui pannel button",button)
				ShowUIPanel(button);
				
            else
                HideUIPanel(button);
            end
        end            
    end
end

-- set a button position and size
function SphereButtons:ButtonSetPosition(buttonName, buttonPos)
    local scale = Venantes.db.profile.buttonScale * Venantes.db.profile.sphereScale / 10000;
    local distanceOffset = 48;
    local distance = distanceOffset;
    
    if Venantes.db.profile.buttonScale < 100 then
        distance = distanceOffset / scale * (Venantes.db.profile.sphereScale / 100);    
    end
    
    local rotationOffset = -126; -- align the button vertical to the spehre
    if Venantes.db.profile.buttonOrderCCW then
        rotationOffset = 126;
    end
    
    local button = _G[self.buttons.prefix..'Button'..buttonName];
    if button ~= nil then
        _G[self.buttons.prefix..'Button'..buttonName..'_Border']:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\ButtonBorder');
        button:SetHighlightTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\'..self.buttons.skin..'\\ButtonHighlight');
        button:SetAlpha(Venantes.db.profile.buttonOpacity / 100);
        if Venantes.db.profile.buttonLocking then
            local buttonDegree = ((buttonPos * 36) + Venantes.db.profile.sphereRotation + rotationOffset);
            if not Venantes.db.profile.buttonOrderCCW then
                buttonDegree = 360 - buttonDegree;
            end
            if buttonDegree > 360 then
                buttonDegree = buttonDegree - 360;
            end
            if buttonDegree < 0 then
                buttonDegree = 360 + buttonDegree;
            end
            
            if self.buttons.positions == nil then
                self.buttons.positions = {}
            end
            self.buttons.positions[buttonName] = buttonDegree;
        
            local positionX = (distance * cos(buttonDegree));
            local positionY = (distance * sin(buttonDegree));    
        
            button:SetUserPlaced(false);    
            button:ClearAllPoints();
            button:SetPoint('CENTER', self.buttons.prefix..'Sphere', 'CENTER', positionX, positionY);
        else 
            button:SetUserPlaced(true); 
        end
        button:SetScale(scale);        
    end
end

-- drag and drop
function SphereButtons:ButtonSetDragable()
    if Venantes.db.profile.sphereLocking then
        -- disable sphere
        _G[self.buttons.prefix..'Sphere']:RegisterForDrag('');
    else
        -- enable sphere
        _G[self.buttons.prefix..'Sphere']:RegisterForDrag('LeftButton');
    end
    -- setup buttons
    for i=1, table.getn(self.buttons.widgets), 1 do
        local button = _G[self.buttons.prefix..'Button'..self.buttons.widgets[i]];
        if button ~= nil then
            if Venantes.db.profile.sphereLocking or Venantes.db.profile.buttonLocking then
                -- disable
                button:RegisterForDrag('');
            else
                -- enable dragging
                button:RegisterForDrag('LeftButton');
				--print(button:GetName(),"Drag Left But")
			end
        end
    end
end


function SphereButtons:OnDragStart(element)
    --print ("drag",element)
	if not InCombatLockdown() then
        element:StartMoving();
    end
end

function SphereButtons:OnDragStop(element)
    element:StopMovingOrSizing();
    if not InCombatLockdown() then
        if (not Venantes.db.profile.buttonLocking) and Venantes.db.profile.buttonsUseGrid then
            local gridSize = 10;        
            local point, relativeTo, relativePoint, xOfs, yOfs = element:GetPoint();
            local xOfsRounded = ((math.floor(xOfs / gridSize) + 0.5) * gridSize);
            local yOfsRounded = ((math.floor(yOfs / gridSize) + 0.5) * gridSize);        
            element:SetPoint(point, relativeTo, relativePoint, xOfsRounded, yOfsRounded);        
        end
        self:ButtonUpdateMenus();
    end
end

function SphereButtons:DebugTexture(textureName)
    if Venantes.db.profile.messagesMissingTexture then
        self:ShowMessage('Texture: '..textureName, 'CHAT');
    end
    if self.missingTextures == nil then
        self.missingTextures = {};
    end
    if self.missingTextures[textureName] == nil then
        self.missingTextures[textureName] = true;
    end
end
