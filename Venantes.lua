------------------------------------------------------------------------------------------------------
-- Venantes 3 TBC classic
--
-- Dev : lancestre , after Zirah on Blackhand (EU, Alliance)
-- Maintainer: LädyGaga and Yinmaris on Sulfuron (EU, Alliance)
-- Based on Ideas by:
--   Serenity and Cryolysis by Kaeldra of Aegwynn 
--   Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
--   Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
------------------------------------------------------------------------------------------------------
local _ = ...
local addonName = ...

Venantes = LibStub("AceAddon-3.0"):NewAddon(
"Venantes",
"AceEvent-3.0",
"AceConsole-3.0",
"AceHook-3.0"
)


local L = LibStub("AceLocale-3.0"):GetLocale('Venantes');

local SphereCore = LibStub:GetLibrary("SphereCore-3.0");
local SphereButtons = LibStub:GetLibrary("SphereButtons-2.0");
local SphereInventory = LibStub:GetLibrary("SphereInventory-2.0");

-- configuration
function VenantesConfig_Toggle()
    if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage(L['MSG_INCOMBAT']);
        return;
    end
    -- load configuration dialog
	--local loaded, message = LoadAddOn('VenantesOptions');
	--if (loaded) then
		--PlaySound(850);
		PlaySound(SOUNDKIT.IG_MINIMAP_OPEN)
		if (not VenantesOptions.initialized) then
			VenantesOptions:Initialize();
			VenantesOptions.initialized = true;
			ShowUIPanel(VenantesOptionsFrame);
		elseif (VenantesOptionsFrame:IsVisible()) then
			HideUIPanel(VenantesOptionsFrame);
		else
            VenantesOptions:UpdateData();
			ShowUIPanel(VenantesOptionsFrame);
		end
	--else
		--PlaySound('TellMessage');
        --if message ~= nil then
            --DEFAULT_CHAT_FRAME:AddMessage(L['LOAD_ERROR']..': '..message);
        --else
            --DEFAULT_CHAT_FRAME:AddMessage(L['LOAD_ERROR']);        
        --end
	--end
end
VENANTES_SPELLS_TEXTURE = {
	[132320]="Ability_Stealth",
	[132328]="Ability_tracking",
	[136217]="Spell_shadow_summonfelhunter",
	[134153]="Inv_misc_head_dragon_01",
	[135861]="Spell_frost_summonwaterelemental",
	[132275]="Ability_racial_avatar",	
	[135942]="Spell_Holy_PrayerOfHealing",
	[136142]="Spell_Shadow_DarkSummoning",
	[135834]="Spell_Frost_ChainsOfIce",
	[132211]="Ability_Hunter_SnakeTrap",
	[135826]="Spell_Fire_SelfDestruct",
	[135840]="Spell_Frost_FreezingBreath",
	[135813]="Spell_Fire_FlameShock",
	[136076]="Spell_Nature_RavenForm",
	[132159]="Ability_Hunter_AspectOfTheMonkey",
	[132160]="Ability_Hunter_AspectoftheViper",
	[132242]="Ability_Mount_JungleTiger",
	[132267]="Ability_Mount_WhiteTiger",
	[132252]="Ability_Mount_PinkTiger",
	[136074]="Spell_Nature_ProtectionformNature",
	[132127]="Ability_Druid_FerociousBite",
	[132111]="Ability_Devour",
	[132176]="Ability_Hunter_KillCommand",
	[132179]="Ability_Hunter_MendPet",
	[132150]="Ability_EyeOfTheOwl",
	[132161]="Ability_Hunter_BeastCall",
	[132163]="Ability_Hunter_BeastSoothe",
	[136095]="Spell_Nature_SpiritWolf",
	[132165]="Ability_Hunter_BeastTraining",
	[132164]="Ability_Hunter_BeastTaming",
	[132270]="Ability_Physical_Taunt",
	[132162]="Ability_Hunter_BeastCall02",
}


function Venantes:Get_Texture_Path(array, texture)
    --print (array , texture)
	for k, v in pairs(array) do
        if type(v) == "table" then
           
            --PrintArray(v)           
        else
            if k == tonumber(texture) then
			
			return v
			--else nothing
			end
			
		end
    end
end



VENANTES_SPELLS = {        
['HUNTER_SHOT_MULTI'] = 		{spell_name = 'Multi-Shot',				id_spell = 27021 },
['HUNTER_SCATTER_SHOT'] = 		{spell_name = 'Scatter Shot', 			id_spell = 19503 },
['HUNTER_ASPECT_PACK'] = 		{spell_name = 'Aspect of the Pack', 	id_spell = 13159 },
['RACIAL_FIND_TREASURE'] = 		{spell_name = 'Find Treasure', 			id_spell = 2481 },
['HUNTER_DISENGAGE'] = 			{spell_name = 'Disengage', 				id_spell = 27015 },
['TRADE_FIND_MINERALS'] = 		{spell_name = 'Find Minerals', 			id_spell = 2580 },
['HUNTER_PET_DISMISS'] = 		{spell_name = 'Dismiss Pet', 			id_spell = 2641 },
['HUNTER_SHOT_DISTRACTING'] = 	{spell_name = 'Distracting Shot', 		id_spell = 27020 },
['HUNTER_RAPID_FIRE'] = 		{spell_name = 'Rapid Fire', 			id_spell = 3045 },
['HUNTER_PET_MEND'] = 			{spell_name = 'Mend Pet', 				id_spell = 27046 },
['TRADE_FIND_HERBS'] = 			{spell_name = 'Find Herbs', 			id_spell = 2383 },
['HUNTER_RAPTOR STRIKE'] = 		{spell_name = 'Raptor Strike', 			id_spell = 27014 },
['HUNTER_ASPECT_VIPER'] = 		{spell_name = 'Aspect of the Viper', 	id_spell = 34074 },
['HUNTER_PET_FEED'] = 			{spell_name = 'Feed Pet', 				id_spell = 6991 },
['HUNTER_TRACK_BEASTS'] = 		{spell_name = 'Track Beasts', 			id_spell = 1494 },
['HUNTER_TRACK_GIANTS'] = 		{spell_name = 'Track Giants', 			id_spell = 19882 },
['HUNTER_PET_TRAINING'] = 		{spell_name = 'Beast Training', 		id_spell = 5149 },
['HUNTER_ASPECT_WILD'] = 		{spell_name = 'Aspect of the Wild', 	id_spell = 27045 },
['HUNTER_BESTIAL_WRATH'] = 		{spell_name = 'Bestial Wrath', 			id_spell = 19574 },
['HUNTER_HUNTERS_MARK'] = 		{spell_name = 'Hunter\s Mark', 			id_spell = 14325 },
['HUNTER_AIMED_SHOT'] = 		{spell_name = 'Aimed Shot', 			id_spell = 19434 },
['HUNTER_TRAP_EXPLOSIVE'] = 	{spell_name = 'Explosive Trap', 		id_spell = 27025 },
['HUNTER_SHOT_TRANQ'] = 		{spell_name = 'Tranquilizing Shot', 	id_spell = 19801 },
['HUNTER_DETERRENCE'] = 		{spell_name = 'Deterrence', 			id_spell = 19263 },
['HUNTER_TRAP_FROST'] = 		{spell_name = 'Frost Trap', 			id_spell = 13809 },
['HUNTER_INTIMIDATION'] = 		{spell_name = 'Intimidation', 			id_spell = 19577 },
['HUNTER_PET_CALL'] = 			{spell_name = 'Call Pet', 				id_spell = 883 },
['HUNTER_TRUESHOT_AURA'] = 		{spell_name = 'Trueshot Aura', 			id_spell = 19506 },
['HUNTER_TRACK_HUMANOIDS'] = 	{spell_name = 'Track Humanoids', 		id_spell = 19883 },
['HUNTER_SCARE_BEAST'] = 		{spell_name = 'Scare Beast', 			id_spell = 14327 },
['HUNTER_FEIGN_DEATH'] = 		{spell_name = 'Feign Death', 			id_spell = 5384 },
['HUNTER_STING_WYVERN'] = 		{spell_name = 'Wyvern Sting', 			id_spell = 19386 },
['HUNTER_TRACK_DEMONS'] = 		{spell_name = 'Track Demons', 			id_spell = 19878 },
['HUNTER_ASPECT_CHEETAH'] = 	{spell_name = 'Aspect of the Cheetah', 	id_spell = 5118 },
['HUNTER_COUNTERATTACK'] = 		{spell_name = 'Counterattack', 			id_spell = 19306 },
['HUNTER_STING_VIPER'] = 		{spell_name = 'Viper Sting', 			id_spell = 27018 },
['HUNTER_MONGOOSE BITE'] = 		{spell_name = 'Mongoose Bite',			id_spell = 36916 },
['HUNTER_STING_SCORPID'] = 		{spell_name = 'Scorpid Sting', 			id_spell = 3043 },
['HUNTER_STING_SERPENT'] = 		{spell_name = 'Serpent Sting',			id_spell = 27016 },
['HUNTER_WING_CLIP'] =		 	{spell_name = 'Wing Clip', 				id_spell = 14268 },
['HUNTER_FLARE'] = 				{spell_name = 'Flare', 					id_spell = 1543 },
['HUNTER_PET_CONTROL'] = 		{spell_name = 'Eyes of the Beast',		id_spell = 1002 },
['HUNTER_PET_KILLCOMMAND'] = 	{spell_name = 'Kill Command', 			id_spell = 34026 },
['HUNTER_TRACK_ELEMENTALS'] = 	{spell_name = 'Track Elementals',		id_spell = 19880 },
['HUNTER_ASPECT_HAWK'] = 		{spell_name = 'Aspect of the Hawk',		id_spell = 27044 },
['HUNTER_PET_REVIVE'] = 		{spell_name = 'Revive Pet', 			id_spell = 982 },
['HUNTER_SHOT_ARCANE'] = 		{spell_name = 'Arcane Shot', 			id_spell = 27019 },
['HUNTER_ASPECT_MONKEY'] = 		{spell_name = 'Aspect of the Monkey', 	id_spell = 13163 },
['HUNTER_VOLLEY'] = 			{spell_name = 'Volley', 				id_spell = 27022 },
['HUNTER_EAGLE_EYE'] = 			{spell_name = 'Eagle Eye', 				id_spell = 6197 },
['HUNTER_TRACK_DRAGONKIN'] = 	{spell_name = 'Track Dragonkin',		id_spell = 19879 },
['HUNTER_PET_TAME'] = 			{spell_name = 'Tame Beast', 			id_spell = 1515 },
['HUNTER_ASPECT_BEAST'] = 		{spell_name = 'Aspect of the Beast',	id_spell = 13161 },
['HUNTER_TRAP_SNAKE'] = 		{spell_name = 'Snake Trap', 			id_spell = 34600 },
['HUNTER_TRAP_IMMOLATION'] = 	{spell_name = 'Immolation Trap', 		id_spell = 27023 },
['HUNTER_BEAST_LORE'] = 		{spell_name = 'Beast Lore',				id_spell = 1462 },
['HUNTER_TRACK_UNDEAD'] =		{spell_name = 'Track Undead', 			id_spell = 19884 },
['HUNTER_TRACK_HIDDEN'] =		{spell_name = 'Track Hidden', 			id_spell = 19885 },
['HUNTER_TRAP_FREEZING'] =		{spell_name = 'Freezing Trap', 			id_spell = 14311 },
['HUNTER_SHOT_CONCUSSIVE'] = 	{spell_name = 'Concussive Shot', 		id_spell = 5116 }
}

-- startup/close functions
    
    defaults = {
	  profile = {
	    sphereLocking = false, 
        sphereSkin = 1, -- 1 = Solid, 2 = Flat
        sphereRotation = 0, -- button rotation in degrees
        sphereOpacity = 90, -- sphere alpha opacity in percent
        sphereScale = 100, -- scale in percent
        sphereStatusCircle = 0, -- show on sphere circle
        sphereStatusText = 0, -- show on sphere text
        sphereActionLeft = 0, -- left click one sphere
        sphereActionRight = 0, -- right click on sphere
        menuKeepOpen = false,  -- menu behaviour 
        menuCloseTimeout = 2, -- remember spells
        rememberAspectMenu = 	{
								[0] = '',
								[1] = '',
								},
        rememberTrackingMenu = {
								[0] = '',
								[1] = '',
								},
        rememberTrapsMenu = {
								[0] = '',
								[1] = '',
							},
        -- button
        buttonOrderCCW = false, -- button order direction (false = clockwise, true = counter clockwise)
        buttonOpacity = 100, -- sphere alpha opacity in percent
        buttonScale = 100, -- scale buttons
        buttonLocking = true, -- lock buttons to sphere
        buttonTooltips = true, -- tooltips on buttons and sphere?
        buttonDefaultTooltips = false, -- use default tooltip position
        buttonsUseGrid = true, --use a grid of 10px to align buttons -- buttons visible or not
        buttonDrinkVisible = true,
        buttonPotionVisible = true,
        buttonMountVisible = true,
		buttonAspectMenuVisible = true,
		buttonTrackingMenuVisible = true,
        buttonTrapsMenuVisible = true,
        buttonActionOneVisible = true,
        buttonActionTwoVisible = true,
        buttonActionThreeVisible = true, -- potion and drink/food button options
        buttonPotionWeakest = false,
        buttonDrinkWeakest = false,      -- action button clicks
        buttonActionOneLeft = 0,
        buttonActionOneRight = 0,
        buttonActionTwoLeft = 0,
        buttonActionTwoRight = 0,
        buttonActionThreeLeft = 0,
        buttonActionThreeRight = 0,
		buttonPetMenuVisible = true,       -- messages
        messagesLanguage = 0,
        messagesOnScreen = true,
        messagesMissingTexture = true,
        messagesRaidMode = false,
        messagesRandom = false,
        messagesRandomHuntersMark = true,
        messagesRandomTranqShot = true,
        messagesRandomPetCall = true,
        messagesRandomPetRevive = true,
        messagesRandomMount = true,
        },
	}


function Venantes:OnInitialize()
   
    self.db = LibStub("AceDB-3.0"):New("VenantesDB", defaults,true)
	ProfileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)-- fill in the profile section
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Profiles", profileOptions)
	
     
	SphereButtons:SphereRegisterSkins({'Solid', 'Flat', 'Sprocket', 'The Blues'});
   
   
    self.options = { 
        type = 'group',
        args = {
            menu = {
                type = 'execute',
                name = 'Menu',
                desc = L["TOGGLE_CONFIG"],
                func = VenantesConfig_Toggle,
            },
            minimap = {
                type = 'execute',
                name = 'Minimap',
                desc = L['TOGGLE_MINIMAP'],
                func = Venantes_MinimapToggle,               
            },
        },
    },
    self:RegisterChatCommand(L['SLASH_COMMANDS'], self.options);

    SphereCore:InitPlayerInfos()
	
    -- Called when the addon is loaded
    SphereButtons:ButtonSetup('Venantes', {'Potion', 'Drink', 'ActionOne', 'ActionTwo', 'ActionThree', 'AspectMenu', 'Mount', 'TrackingMenu', 'PetMenu', 'TrapsMenu'});
    SphereCore:RegisterSpells(VENANTES_SPELLS);
    SphereButtons:ButtonRegisterActions({    
        { type = 'slot', data = 'Trinket0Slot' }, --First trinket slot
        { type = 'slot', data = 'Trinket1Slot' }, --Second trinket slot     
        { type = 'spell', data = 'HUNTER_FEIGN_DEATH' },
        { type = 'spell', data = 'HUNTER_HUNTERS_MARK' },
        { type = 'spell', data = 'HUNTER_SCARE_BEAST' },
        { type = 'spell', data = 'HUNTER_RAPID_FIRE' },
        { type = 'spell', data = 'HUNTER_DETERRENCE' },
        { type = 'spell', data = 'HUNTER_FLARE' },
        { type = 'spell', data = 'HUNTER_VOLLEY' },      
        { type = 'spell', data = 'HUNTER_BEAST_LORE' },
        { type = 'spell', data = 'HUNTER_PET_CONTROL' }, 
        { type = 'spell', data = 'HUNTER_EAGLE_EYE' },
        { type = 'spell', data = 'HUNTER_TRAP_FREEZING' },
        { type = 'spell', data = 'HUNTER_TRAP_SNAKE' },     
        { type = 'spell', data = 'HUNTER_TRAP_EXPLOSIVE' },
        { type = 'spell', data = 'HUNTER_TRAP_FROST' },    
        { type = 'spell', data = 'HUNTER_TRAP_IMMOLATION' },
        { type = 'spell', data = 'HUNTER_BESTIAL_WRATH' },
        { type = 'spell', data = 'HUNTER_INTIMIDATION' },
        { type = 'spell', data = 'HUNTER_TRUESHOT_AURA' },  
    })
    SphereButtons:SphereRegisterStatus(
        {'MANA', 'HEALTH', 'XP', 'PET_MANA', 'PET_HEALTH', 'PET_XP', 'PET_HAPPY'},
        {'AMMO', 'MANA', 'HEALTH', 'PET_MANA', 'PET_HEALTH', 'DRINK_FOOD'}
    );

    SphereButtons:ButtonRegisterMenu('TrackingMenu', {   
        { type = 'spell', data = 'TRADE_FIND_HERBS' },    
        { type = 'spell', data = 'TRADE_FIND_MINERALS' },    
        { type = 'spell', data = 'HUNTER_TRACK_BEASTS' },    
        { type = 'spell', data = 'HUNTER_TRACK_DEMONS' },    
        { type = 'spell', data = 'HUNTER_TRACK_DRAGONKIN' },    
        { type = 'spell', data = 'HUNTER_TRACK_ELEMENTALS' },    
        { type = 'spell', data = 'HUNTER_TRACK_GIANTS' },    
        { type = 'spell', data = 'HUNTER_TRACK_HIDDEN' },    
        { type = 'spell', data = 'HUNTER_TRACK_HUMANOIDS' },    
        { type = 'spell', data = 'HUNTER_TRACK_UNDEAD' },    
        { type = 'spell', data = 'RACIAL_FIND_TREASURE' },
    })
    SphereButtons:ButtonRegisterMenu('AspectMenu', {
        { type = 'spell', data = 'HUNTER_ASPECT_HAWK' },    
        { type = 'spell', data = 'HUNTER_ASPECT_MONKEY' },  
        { type = 'spell', data = 'HUNTER_ASPECT_VIPER'}, 
        { type = 'spell', data = 'HUNTER_ASPECT_CHEETAH' },      
        { type = 'spell', data = 'HUNTER_ASPECT_PACK' },    
        { type = 'spell', data = 'HUNTER_ASPECT_BEAST' },   
        { type = 'spell', data = 'HUNTER_ASPECT_WILD'},
    })
    SphereButtons:ButtonRegisterMenu('PetMenu', {
        { type = 'spell', data = 'HUNTER_BESTIAL_WRATH' },
        { type = 'spell', data = 'HUNTER_INTIMIDATION' },   
        { type = 'spell', data = 'HUNTER_PET_KILLCOMMAND' },         
        { type = 'spell', data = 'HUNTER_PET_MEND' },   
        { type = 'spell', data = 'HUNTER_PET_CONTROL' }, 
        { type = 'spell', data = 'HUNTER_PET_CALL' },   
        { type = 'spell', data = 'HUNTER_PET_REVIVE' },  
        { type = 'spell', data = 'HUNTER_PET_DISMISS' },  
        { type = 'spell', data = 'HUNTER_PET_FEED' },    
        { type = 'spell', data = 'HUNTER_PET_TAME' },   
        { type = 'spell', data = 'HUNTER_BEAST_LORE' },   
        { type = 'spell', data = 'HUNTER_PET_TRAINING' },  
    })
    SphereButtons:ButtonRegisterMenu('TrapsMenu', {
        { type = 'spell', data = 'HUNTER_TRAP_FREEZING' },
        { type = 'spell', data = 'HUNTER_TRAP_SNAKE' },     
        { type = 'spell', data = 'HUNTER_TRAP_EXPLOSIVE' },
        { type = 'spell', data = 'HUNTER_TRAP_FROST' },    
        { type = 'spell', data = 'HUNTER_TRAP_IMMOLATION' },
    })
    SphereCore:RegisterSpeechLanguage('enUS', VENANTES_RANDOM_MESSAGES_enUS);
    SphereCore:RegisterSpeechLanguage('deDE', VENANTES_RANDOM_MESSAGES_deDE);
    SphereCore:RegisterSpeechLanguage('frFR', VENANTES_RANDOM_MESSAGES_frFR);
    SphereCore:RegisterSpeechLanguage('zhTW', VENANTES_RANDOM_MESSAGES_zhTW);
    
    --ToDo find alternativ for timer (metro is abandoned)
	--Timer is broken 
	
	--Old code -- 
	--metro:Register("VenantesTimer", self.OnTimerTick, 1, self);
end

function Venantes:OnEnable()
    -- starting up
    self:RegisterEvent('PLAYER_ENTERING_WORLD');
    -- new zone
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA');
        
    -- monitor some status infos
    self:RegisterEvent('UNIT_HEALTH');
    self:RegisterEvent('UNIT_MANA');
    --self:RegisterEvent('UNIT_POWER');
    
    -- some basic info has changed
    self:RegisterEvent("UNIT_PET");
    self:RegisterEvent('SPELLS_CHANGED');
    self:RegisterEvent('BAG_UPDATE');
    self:RegisterEvent('UNIT_INVENTORY_CHANGED');
    
    -- capture spellcasts (messages, recasts)
    self:RegisterEvent('UNIT_SPELLCAST_SENT');
    self:RegisterEvent('UNIT_SPELLCAST_FAILED'); 
    self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED'); 
    self:RegisterEvent('UNIT_SPELLCAST_STOP');
    self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');     
    
    -- leaving combat - do pending updates
    self:RegisterEvent('PLAYER_LEAVE_COMBAT');
    
    -- start the update timer
    --metro:Start("VenantesTimer");
end


-- event callbacks
function Venantes:PLAYER_ENTERING_WORLD()
	--print(self,event)
    SphereCore:InitPlayerInfos();
    SphereCore:MountZoneInformation();
    SphereCore:UpdateSpellTable();
    SphereInventory:InventoryScan();
    SphereCore:UpdateAmmoItem();
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:SPELLS_CHANGED()
    SphereCore:UpdateSpellTable();
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:UNIT_PET()
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:BAG_UPDATE()
   -- print("BAG_UPDATE",BAG_UPDATE)
	SphereInventory:InventoryScan();
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:UNIT_INVENTORY_CHANGED(unit)
 --print("event",UNIT_INVENTORY_CHANGED)
    if unit == 'player' then
    
    self:UpdateAmmoItem();
    end
end

function Venantes:ZONE_CHANGED_NEW_AREA()
    SphereCore:MountZoneInformation();
    self:UpdateActions();
end

function Venantes:UNIT_SPELLCAST_SENT(unitId, spell, rank,SpellID)
    SphereButtons:ButtonUpdateCooldown(unitId, spell, rank ,SpellID)
	if unitId == 'player' then
        self:OnSpellCastStart(spell, rank, target);
        if self.lastSpell == nil then
            self.lastSpell = {}
        end
        self.lastSpell.spell = spell;
        self.lastSpell.rank = rank;
        self.lastSpell.target = target;
    end
	
end

function Venantes:UNIT_SPELLCAST_STOP(unitId)
    if unitId == 'player' then
        self.lastSpell = nil;
        if self.lastSpell ~= nil and self.lastSpell.spell ~= nil then
            self:OnSpellCast(self.lastSpell.spell, self.lastSpell.rank, self.lastSpell.target);
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
    end
end

function Venantes:UNIT_SPELLCAST_FAILED(unitId, spell, rank)
    --print (unitId,spell, rank, target)
	if unitId == 'player' then
        self.lastSpell = nil;
        if self.lastSpell ~= nil and self.lastSpell.spell ~= nil then
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
    end
end

function Venantes:UNIT_SPELLCAST_INTERRUPTED(unitId)
    if unitId == 'player' then
        if self.lastSpell ~= nil and self.lastSpell.spell ~= nil then
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
    end
end

function Venantes:UNIT_SPELLCAST_SUCCEEDED(unitId, spell, rank,SpellID)
    --print('success',unitId, spell, rank,SpellID)
	SphereButtons:ButtonUpdateCooldown(unitId, spell, rank ,SpellID)
	if unitId == 'player' then
        if self.lastSpell ~= nil then
            if self.lastSpell ~= nil and self.lastSpell.spell ~= nil and spell == self.lastSpell.spell then
                self:OnSpellCast(spell, rank, self.lastSpell.target);
            end
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
     
	end



end

-- status update events
function Venantes:UNIT_HEALTH()
    self:UpdateStatus();
end
function Venantes:UNIT_MANA()
    self:UpdateStatus();
end
function Venantes:UNIT_FOCUS()
    self:UpdateStatus();
end

-- pending updates
function Venantes:PLAYER_LEAVE_COMBAT()
    if self.bagUpdatePending then
        SphereInventory:InventoryScan();    
    end
    if self.updatePending then
        self:UpdateActions();    
    end
    self:UpdateStatus();
end

-- tooltip functions
function Venantes:ShowTooltip(element, buttonId, anchor)
    --print(element, buttonId, anchor)
	if not self.db.profile.buttonTooltips then
        return
    end
  
    if self.db.profile.buttonDefaultTooltips then
        GameTooltip_SetDefaultAnchor(GameTooltip, element);    
    else
        GameTooltip:SetOwner(element, anchor);
    end
  
    if buttonId == 'MAIN' then    
		GameTooltip:AddLine('Venantes Reborn TBC ');
        local ammoCount, ammoName = SphereCore:GetAmmoCount(L['AMMO']);
        if ammoName ~= nil then
            GameTooltip:AddDoubleLine(ammoName..' : ', ammoCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = SphereInventory:InventoryGetItemData('DRINK');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..' : ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = SphereInventory:InventoryGetItemData('FOOD');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..' : ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = SphereInventory:InventoryGetItemData('POTION_MP');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..' : ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = SphereInventory:InventoryGetItemData('POTION_HP');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..' : ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end        
        local _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.sphereActionLeft);
        local _, actionRightName, _, actionRightTooltip, actionRightCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.sphereActionRight);  
        if actionLeftName then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
            if actionLeftTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionLeftName, actionLeftTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionLeftName, 0.8, 0.8, 0.1);
            end
            if actionLeftCooldown and actionLeftCooldown > 0 then
                local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionLeftCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
        if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
		GameTooltip:AddLine(L['TOOLTIP_MIDDLECLICK'], 1.0, 1.0, 1.0);
		GameTooltip:AddLine("Configure Venantes", 0.8, 0.8, 0.1);
	
	elseif buttonId == 'DRINK' then
		GameTooltip:AddLine(L['TOOLTIP_DRINKFOOD']);
        self:TooltipAddItemData(GameTooltip, 'LeftButton', 'DRINK');
        self:TooltipAddItemData(GameTooltip, 'RightButton', 'FOOD');
    elseif buttonId == 'POTION' then
		GameTooltip:AddLine(L['TOOLTIP_POTION']);
        self:TooltipAddItemData(GameTooltip, 'LeftButton', 'POTION_HP');
        self:TooltipAddItemData(GameTooltip, 'RightButton', 'POTION_MP');
    elseif buttonId == 'MOUNT' then    
        if UnitOnTaxi('player') then
            GameTooltip:AddLine(L['UNIT_ON_TAXI'], 1.0, 1.0, 1.0);
        end
        local _, _, itemName = SphereInventory:InventoryGetMountData();
        if itemName ~= nil then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
            GameTooltip:AddLine(itemName, 0.8, 0.8, 0.1);
        end
        local _, itemName, _, _, cooldown = SphereInventory:InventoryGetItemData('HEARTHSTONE');
        if itemName ~= nil then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            GameTooltip:AddLine(itemName..' ('..GetBindLocation()..')', 0.8, 0.8, 0.1);
            if cooldown and cooldown > 0 then
                local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(cooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
    elseif buttonId == 'ACTION_ONE' or buttonId == 'ACTION_TWO' or buttonId == 'ACTION_THREE' then
        local actionLeftName, actionLeftTooltip, actionLeftCooldown;
        local actionRightName, actionRightTooltip, actionRightCooldown;
        if buttonId == 'ACTION_ONE' then
            _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.buttonActionOneLeft);
            _, actionRightName, _, actionRightTooltip, actionRightCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.buttonActionOneRight);
        elseif buttonId == 'ACTION_TWO' then
            _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.buttonActionTwoLeft);
            _, actionRightName, _, actionRightTooltip, actionRightCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.buttonActionTwoRight);
        elseif buttonId == 'ACTION_THREE' then
            _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.buttonActionThreeLeft);
            _, actionRightName, _, actionRightTooltip, actionRightCooldown = SphereButtons:ButtonGetActionInfo(self.db.profile.buttonActionThreeRight);   
        end
        if actionLeftName then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
            if actionLeftTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionLeftName, actionLeftTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionLeftName, 0.8, 0.8, 0.1);
            end
            if actionLeftCooldown and actionLeftCooldown > 0 then
                local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionLeftCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
        if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
    elseif buttonId == 'ATTRIBUTES' then -- button des sous menus
        local buttonType = element:GetAttribute('type1'); --buttonType = spell
		
		if buttonType ~= nil then
            local buttonAction = element:GetAttribute(buttonType..'1');
            --print (buttonAction,  'OK')
			if buttonType == 'spell' then
                -- spell name to venantes spell id
                if SphereCore.spellTableRevIndex ~= nil and SphereCore.spellTableRevIndex[buttonAction] ~= nil then
                    -- venantes spell id to spell data
                    local spellData = SphereCore.spellTable[SphereCore.spellTableRevIndex[buttonAction]];
                    --print (spellData.index)
					-- check data and set tooltip
                    if spellData ~= nil and spellData.index ~= nil and spellData.index > 0 then
                        
						GameTooltip:SetSpellBookItem(spellData.index, BOOKTYPE_SPELL);
                    end
                end
            
			end
        end
    elseif buttonId == 'PETMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        local actionRightId = 'HUNTER_PET_MEND';
        if UnitIsDeadOrGhost('pet') then
            actionRightId = 'HUNTER_PET_REVIVE';
        elseif not HasPetUI() then
            actionRightId = 'HUNTER_PET_CALL';        
        end
        local _, actionRightName, _, actionRightTooltip, actionRightCooldown = SphereCore:Get_ActionInfo('spell', actionRightId);
        if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
            local _, actionMiddleName, _, actionMiddleTooltip, actionMiddleCooldown = SphereCore:Get_ActionInfo('spell', 'HUNTER_PET_CONTROL');
            if actionMiddleName then
                GameTooltip:AddLine(L['TOOLTIP_MIDDLECLICK'], 1.0, 1.0, 1.0);
                if actionMiddleTooltip ~= nil then
                    GameTooltip:AddDoubleLine(actionMiddleName, actionMiddleTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
                else
                    GameTooltip:AddLine(actionMiddleName, 0.8, 0.8, 0.1);
                end
                if actionMiddleCooldown and actionMiddleCooldown > 0 then
                    local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionMiddleCooldown);
                    GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
                end                
            end   
        end
    elseif  buttonId == 'ASPECTMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        self:TooltipAddMenuSpellData(tooltip, 'AspectMenu');
    elseif  buttonId == 'TRACKINGMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        self:TooltipAddMenuSpellData(tooltip, 'TrackingMenu');
    elseif  buttonId == 'TRAPSMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        self:TooltipAddMenuSpellData(tooltip, 'TrapsMenu');
    end
  
	-- and done, show it!
	GameTooltip:Show();
end

function Venantes:TooltipAddItemData(tooltip, button, itemGroup)
    local itemCount, itemName, _, _, cooldown = SphereInventory:InventoryGetItemData(itemGroup);
    if itemName ~= nil then
        if button == 'LeftButton' then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
        elseif button == 'RightButton' then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
        end
        GameTooltip:AddDoubleLine(itemName..': ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        if cooldown and cooldown > 0 then
            local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(cooldown);
            GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
        end
    end
end

function Venantes:TooltipAddMenuSpellData(tooltip, menuId)
    local optionName = 'remember'..menuId;
    if self.db.profile[optionName] ~= nil then

        local _, actionRightName, _, actionRightTooltip, actionRightCooldown = SphereCore:Get_ActionInfo('spell', self.db.profile[optionName][1]);
      
	   if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
            local _, actionMiddleName, _, actionMiddleTooltip, actionMiddleCooldown = SphereCore:Get_ActionInfo('spell', self.db.profile[optionName][0]);
            if actionMiddleName then
                GameTooltip:AddLine(L['TOOLTIP_MIDDLECLICK'], 1.0, 1.0, 1.0);
                if actionMiddleTooltip ~= nil then
                    GameTooltip:AddDoubleLine(actionMiddleName, actionMiddleTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
                else
                    GameTooltip:AddLine(actionMiddleName, 0.8, 0.8, 0.1);
                end
                if actionMiddleCooldown and actionMiddleCooldown > 0 then
                    local cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionMiddleCooldown);
                    GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
                end                
            end   
        end
    end
end

function Venantes:UpdateStatus()
    if (not InCombatLockdown()) and self.updatePending then
        self:UpdateActions();
    end

    local circleInfo, textInfo = SphereButtons:SphereGetStatusInfo(self.db.profile.sphereStatusCircle, self.db.profile.sphereStatusText);
    -- update circle
    if self.db.profile.sphereStatusCircle == nil or self.db.profile.sphereStatusCircle == 0 then
        SphereButtons:SphereSetStatusValues(0, nil);        
    elseif circleInfo ~= nil then
        local statusCircle = 0;
        local hasPet = HasPetUI();
        if circleInfo == 'MANA' then
            statusCircle = math.floor((UnitPower("player",SPELL_POWER_MANA) * 16 / UnitPowerMax("player",SPELL_POWER_MANA)) + 0.5);
        elseif circleInfo == 'HEALTH' then
            statusCircle = math.floor((UnitHealth('player') * 16 / UnitHealthMax('player')) + 0.5);
        elseif circleInfo == 'XP' then
            statusCircle = math.floor((UnitXP('player') * 16 / UnitXPMax('player')) + 0.5);
        elseif hasPet and circleInfo == 'PET_MANA' then
            statusCircle = math.floor((UnitPower("pet",SPELL_POWER_ENERGY) * 16 / UnitPowerMax("pet",SPELL_POWER_ENERGY)) + 0.5);
        elseif hasPet and circleInfo == 'PET_HEALTH' then
            statusCircle = math.floor((UnitHealth('pet') * 16 / UnitHealthMax('pet')) + 0.5);
        elseif hasPet and circleInfo == 'PET_XP' then
            local currXP, nextXP = GetPetExperience();
            statusCircle = math.floor((currXP * 16 / nextXP) + 0.5);
        elseif hasPet and circleInfo == 'PET_HAPPY' then
            local happyLevel = GetPetHappiness();
            if happyLevel == 3 then
                statusCircle = 16;                
            elseif happyLevel == 2 then
                statusCircle = 7;
            elseif happyLevel == 1 then
                statusCircle = 3;
            end
        end        
        SphereButtons:SphereSetStatusValues(statusCircle, nil);
    end
    -- update sphere text
    if self.db.profile.sphereStatusText == nil or self.db.profile.sphereStatusText == 0 then
        SphereButtons:SphereSetStatusValues(nil, '');        
    elseif textInfo ~= nil then
        local statusText = '';
        local hasPet = HasPetUI();
        if textInfo == 'AMMO' then
            local ammoCount = SphereCore:GetAmmoCount(L['AMMO']);
            if ammoCount < 200 then
                statusText = '|c00FF0000'..ammoCount..'|r';
            elseif ammoCount < 600 then
                statusText = '|c00FFCC00'..ammoCount..'|r';
            else
                statusText = ammoCount;            
            end
        elseif textInfo == 'MANA' then
            statusText = (math.floor((UnitPower("player",SPELL_POWER_MANA) * 100 / UnitPowerMax("player",SPELL_POWER_MANA)) + 0.5))..'%\n'..UnitPower("player",SPELL_POWER_MANA)
        elseif textInfo == 'HEALTH' then
            statusText = (math.floor((UnitHealth('player') * 100 / UnitHealthMax('player')) + 0.5))..'%\n'..UnitHealth('player');       
        elseif hasPet and textInfo == 'PET_MANA' then
            statusText = (math.floor((UnitPower("pet",SPELL_POWER_ENERGY) * 100 / UnitPowerMax("pet",SPELL_POWER_ENERGY)) + 0.5))..'%\n'..UnitPowerMax("pet",SPELL_POWER_ENERGY);        
        elseif hasPet and textInfo == 'PET_HEALTH' then
            statusText = (math.floor((UnitHealth('pet') * 100 / UnitHealthMax('pet')) + 0.5))..'%\n'..UnitHealth('pet');     
        elseif textInfo == 'DRINK_FOOD' then
            local itemDrinkCount = SphereInventory:InventoryGetItemData('DRINK');
            local itemFoodCount = SphereInventory:InventoryGetItemData('FOOD'); 
            if itemDrinkCount ~= nil then
                statusText = itemDrinkCount..'/';
            else
                statusText = '0/';
            end
            if itemFoodCount ~= nil then
                statusText = statusText..itemFoodCount;
            else
                statusText = statusText..'0';
            end
        end
        SphereButtons:SphereSetStatusValues(nil, statusText);
    end
    -- update potion cooldown
    local _, _, _, _, cooldownHP = SphereInventory:InventoryGetItemData('POTION_HP');
    local _, _, _, _, cooldownMP = SphereInventory:InventoryGetItemData('POTION_MP');
    local cooldownString = nil;
    local cooldownUnit = nil;
    if cooldownHP ~= nil and cooldownHP > 0 then
        cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(cooldownHP);
    elseif cooldownMP ~= nil and cooldownMP > 0 then
        cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(cooldownMP);
    end
    if cooldownString then
        SphereButtons:ButtonSetCaption('Potion', SphereButtons:GetButtonCooldownStr(cooldownString, cooldownUnit));
        SphereButtons:ButtonSetStatus('Potion', false);        
    else
        SphereButtons:ButtonSetCaption('Potion', nil);
        SphereButtons:ButtonSetStatus('Potion', true);
    end
    
    local currentMana = UnitPower("player", SPELL_POWER_MANA);
    
    -- action buttons
    self:UpdateActionButtonStatus('ActionOne', currentMana);
    self:UpdateActionButtonStatus('ActionTwo', currentMana);
    self:UpdateActionButtonStatus('ActionThree', currentMana);
        
    local actionName = nil;
    local actionCooldown = nil;
    local actionMana = nil;
    if self.buttons ~= nil and self.buttons.menus ~= nil and self.buttons.menus['TrapsMenu'] ~= nil then
        for i=1, table.getn(self.buttons.menus['TrapsMenu']), 1 do
            if actionName == nil then
                _, actionName, _, _, actionCooldown, actionMana = SphereCore:Get_ActionInfo(self.buttons.menus['TrapsMenu'][i].type, self.buttons.menus['TrapsMenu'][i].data);   
            
			end
        end
    end
    if actionName ~= nil then
     
		if actionCooldown ~= nil and actionCooldown > 0 then
            cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionCooldown);
           -- print ("CD", cooldownString, cooldownUnit)
			if cooldownString then
                SphereButtons:ButtonSetCaption('TrapsMenu', self:GetButtonCooldownStr(cooldownString, cooldownUnit));
                SphereButtons:ButtonSetStatus('TrapsMenu', false); 
            else
                SphereButtons:ButtonSetCaption('TrapsMenu', ''); 
                SphereButtons:ButtonSetStatus('TrapsMenu', true); 
            end 
        else
            SphereButtons:ButtonSetCaption('TrapsMenu', ''); 
            SphereButtons:ButtonSetStatus('TrapsMenu', true);         
        end
    else
        SphereButtons:ButtonSetStatus('TrapsMenu', true);     
    end
    
    -- mount button highlighting
    if UnitOnTaxi('player') then
        SphereButtons:ButtonSetStatus('Mount', false);
    else
        SphereButtons:ButtonSetStatus('Mount', true);
        if IsMounted() then
            VenantesButtonMount:LockHighlight();
        else
            VenantesButtonMount:UnlockHighlight(); 
        end
    end
    
    -- update button status (mana depending spells, cooldowns)
    SphereButtons:ButtonUpdateMenuStatus();
end

function Venantes:UpdateActionButtonStatus(buttonId, currentMana)
    local _, actionName, _, _, actionCooldown, actionMana = SphereButtons:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Left']);
    
	if actionName == nil then
        _, actionName, _, _, actionCooldown, actionMana = SphereButtons:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Right']);        
    end
    local buttonEnabled = true;
    if actionName ~= nil then
        if  actionCooldown ~= nil and actionCooldown > 0 then
            cooldownString, cooldownUnit = SphereCore:GetFormattedCooldownTime(actionCooldown);
            if cooldownString then
                SphereButtons:ButtonSetCaption(buttonId, self:GetButtonCooldownStr(cooldownString, cooldownUnit));
                buttonEnabled = false;
            else
                SphereButtons:ButtonSetCaption(buttonId, '');        
            end
        else 
            SphereButtons:ButtonSetCaption(buttonId, '');
        end
        if actionMana ~= nil and actionMana > 0 and actionMana > currentMana then
            buttonEnabled = false;        
        end
    else
        buttonEnabled = false;
    end
    if buttonEnabled then 
        SphereButtons:ButtonSetStatus(buttonId, true);     
    else
        --SphereButtons:ButtonSetStatus(buttonId, false);      
    end
end

function Venantes:UpdateActions()
    if InCombatLockdown() then
        self.updatePending = true;
        return;
    end
    if self.updatePending then
        self:UpdateTemporaryOptions();
    end
    
    -- sphere    
    actionType, actionName = SphereButtons:ButtonGetActionInfo(self.db.profile.sphereActionLeft);     
    if actionType ~= nil and actionName then
        if actionType == 'spell' then
            SphereButtons:SphereSetSpell('LeftButton', actionName);
        else
            SphereButtons:SphereSetItem('LeftButton',actionName);
        end
    else 
        SphereButtons:SphereSetSpell('LeftButton', '');
		
	end
    actionType, actionName = SphereButtons:ButtonGetActionInfo(self.db.profile.sphereActionRight);    
    if actionType ~= nil and actionName then
        if actionType == 'spell' then
            SphereButtons:SphereSetSpell('RightButton', actionName);
        else
            SphereButtons:SphereSetItem('RightButton', actionName);
        end
    else 
        SphereButtons:SphereSetSpell('RightButton', '');
    end 
    -- Set Middle Button
		SphereButtons:SphereSetSpell('MiddleButton', 'ToogleConfig');
		
		
    -- drink button
    self:UpdateItemButton('Drink', 'DRINK', 'FOOD', 'Spell_Misc_Drink');    
    -- potions button
    self:UpdateItemButton('Potion', 'POTION_HP', 'POTION_MP', 'INV_Potion_90');
    
    -- mount button
    local itemMountName, itemMountTexture = SphereInventory:InventoryGetMountData();
    local _, itemHearthStoneName, itemHearthStoneTexture = SphereInventory:InventoryGetItemData('HEARTHSTONE');
    if itemMountName ~= nil then        
        SphereButtons:ButtonSetStatus('Mount', true);
        SphereButtons:ButtonSetIcon('Mount', itemMountTexture);
        SphereButtons:ButtonSetMacro('Mount', 'LeftButton', '/dismount\n/use '..itemMountName);
        if itemHearthStoneName ~= nil then
            SphereButtons:ButtonSetItem('Mount', 'RightButton', itemHearthStoneName);
        else 
            SphereButtons:ButtonSetItem('Mount', 'RightButton', '');        
        end
    else     
        SphereButtons:ButtonSetMacro('Mount', 'LeftButton', '/dismount');
        if itemHearthStoneName ~= nil then
            SphereButtons:ButtonSetIcon('Mount', itemHearthStoneTexture);
            SphereButtons:ButtonSetItem('Mount', 'RightButton', itemHearthStoneName);
        else 
            SphereButtons:ButtonSetIcon('Mount', 'INV_Misc_Rune_01');
            SphereButtons:ButtonSetItem('Mount', 'RightButton', '');        
        end
    end
    
    -- action button one
    self:UpdateActionButton('ActionOne');
    self:UpdateActionButton('ActionTwo');
    -- action button three 
	self:UpdateActionButton('ActionThree');
    
 
    
	SphereButtons:ButtonUpdateMenus();
	
    -- set remembered spells and show icon for right click
    self:UpdateMenuButtonSpells('TrackingMenu', 'Ability_Tracking');
    self:UpdateMenuButtonSpells('AspectMenu', 'Spell_Nature_RavenForm');
    self:UpdateMenuButtonSpells('TrapsMenu', 'Spell_Frost_ChainsOfIce');
    
    -- check for pet - set button depending on pet
    SphereButtons:ButtonSetIcon('PetMenu', 'Ability_Hunter_BeastTaming'); 

	if SphereCore.spellTable ~= nil and SphereCore.spellTable['HUNTER_PET_MEND'] ~= nil then
        SphereButtons:ButtonSetMacro('PetMenu', 'RightButton', '/cast [target=pet,dead] '..SphereCore.spellTable['HUNTER_PET_REVIVE'].name..'; [nopet] '..SphereCore.spellTable['HUNTER_PET_CALL'].name..'; '..SphereCore.spellTable['HUNTER_PET_MEND'].name); 
    end
   

   if SphereCore.spellTable ~= nil and SphereCore.spellTable['HUNTER_PET_CONTROL'] ~= nil then
         
		SphereButtons:ButtonSetSpell('PetMenu', 'MiddleButton', SphereCore.spellTable['HUNTER_PET_CONTROL'].name); 
    end 
    local petTexture = GetPetIcon();
    if petTexture ~= nil then
        local  _, _, petTextureFile = string.find(petTexture,'([^\\]+)$');
        if petTextureFile ~= nil then
            SphereButtons:ButtonSetIcon('PetMenu', petTextureFile); 
--            SphereButtons:ButtonSetIcon('PetMenu', 132194); 			
		--print("peticon",132194,petTextureFile)
	   end
    end
    
    self.updatePending = false;
end

function Venantes:UpdateMenuButtonSpells(menuId, defaultTexture)
   -- print(menuId, defaultTexture)
	local optionName = 'remember'..menuId;
    if self.db.profile[optionName] ~= nil then
        --print(menuId, defaultTexture)
		local actionTypeRight, actionNameRight, actionTextureRight = SphereCore:Get_ActionInfo('spell', self.db.profile[optionName][1]);
        --print (menuId, actionTypeRight, actionNameRight, actionTextureRight)
		if actionTypeRight ~= nil and actionTypeRight == 'spell' and actionNameRight ~= nil then
            SphereButtons:ButtonSetSpell(menuId, 'RightButton', actionNameRight);
            if self.db.profile[optionName][1] ~= self.db.profile[optionName][0] then
                local actionTypeMiddle, actionNameMiddle = SphereCore:Get_ActionInfo('spell', self.db.profile[optionName][0]);
                if actionTypeMiddle ~= nil and actionTypeMiddle == 'spell' and actionNameMiddle ~= nil then
                    SphereButtons:ButtonSetSpell(menuId, 'MiddleButton', actionNameMiddle);
                else 
                    SphereButtons:ButtonSetSpell(menuId, 'MiddleButton', '');        
                end
            else
                SphereButtons:ButtonSetSpell(menuId, 'MiddleButton', '');           
            end
        else 
            SphereButtons:ButtonSetSpell(menuId, 'RightButton', ''); 
            SphereButtons:ButtonSetSpell(menuId, 'MiddleButton', '');           
        end
        if actionTextureRight then
            --SphereButtons:ButtonSetIcon(menuId, actionTextureRight);
        local buttonMenuTexture = _G[self.buttons.prefix..'Button'..menuId..'_Icon'];
--		buttonMenuTexture:SetTexture('Interface\\AddOns\\'..self.buttons.prefix..'\\UI\\Icons\\'..defaultTexture)
		buttonMenuTexture:SetTexture('Interface\\AddOns\\'..addonName..'\\UI\\Icons\\'..'Spell_Frost_ChainsOfIce')		
		
		else 
           -- SphereButtons:ButtonSetIcon(C, defaultTexture);        
		local buttonMenuTexture = _G[addonName..'Button'..menuId..'_Icon'];
		buttonMenuTexture:SetTexture('Interface\\AddOns\\'..addonName..'\\UI\\Icons\\'..defaultTexture)		
        
		end
    end
end

function Venantes:UpdateItemButton(buttonId, groupIdLeft, groupIdRight, defaultTexture)
   
	local _, itemLeftName, itemLeftTexture  = SphereInventory:InventoryGetItemData(groupIdLeft);
    local _, itemRightName, itemRightTexture  = SphereInventory:InventoryGetItemData(groupIdRight);
    -- print("b_ID ",buttonId, groupIdLeft,itemLeftName,itemLeftTexture, groupIdRight,itemRightName, itemRightTexture, defaultTexture)
	
	
	if itemLeftName ~= nil then
        SphereButtons:ButtonSetStatus(buttonId, true);
        SphereButtons:ButtonSetIcon(buttonId, itemLeftTexture);
        SphereButtons:ButtonSetItem(buttonId, 'LeftButton', itemLeftName);
        if itemRightName ~= nil then
            SphereButtons:ButtonSetItem(buttonId, 'RightButton', itemRightName);
        else
            SphereButtons:ButtonSetItem(buttonId, 'RightButton', '');        
        end
    else
        SphereButtons:ButtonSetItem(buttonId, 'LeftButton', '');
        if itemRightName ~= nil then
            SphereButtons:ButtonSetStatus(buttonId, true);
            SphereButtons:ButtonSetIcon(buttonId, itemRightTexture);
            SphereButtons:ButtonSetItem(buttonId, 'RightButton', itemRightName);
        else
            SphereButtons:ButtonSetStatus(buttonId, false);
			SphereButtons:ButtonSetIcon(buttonId, defaultTexture);
			SphereButtons:ButtonSetItem(buttonId, 'RightButton', '');   
        end
    end
end

function Venantes:UpdateActionButton(buttonId)
    local actionLeftType, actionLeftName, actionLeftTexture = SphereButtons:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Left']);
    local actionRightType, actionRightName, actionRightTexture = SphereButtons:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Right']);
    if actionLeftType ~= nil and actionLeftName ~= nil then
        if actionLeftType == 'spell' then
            SphereButtons:ButtonSetSpell(buttonId, 'LeftButton', actionLeftName);
        else 
            SphereButtons:ButtonSetItem(buttonId, 'LeftButton', actionLeftName);        
        end
    else
        SphereButtons:ButtonSetSpell(buttonId, 'LeftButton', '');    
    end
    if actionRightType ~= nil and actionRightName then
        if actionRightType == 'spell' then
            SphereButtons:ButtonSetSpell(buttonId, 'RightButton', actionRightName);
        else 
            SphereButtons:ButtonSetItem(buttonId, 'RightButton', actionRightName);        
        end
    else
        SphereButtons:ButtonSetSpell(buttonId, 'RightButton', '');    
    end
    if actionLeftTexture ~= nil then
        SphereButtons:ButtonSetIcon(buttonId, actionLeftTexture);
    elseif actionRightTexture ~= nil then
        SphereButtons:ButtonSetIcon(buttonId, actionRightTexture);
    else 
        SphereButtons:ButtonSetIcon(buttonId, 'DEFAULT');    
    end
end


function Venantes:OnSpellCastStart(spell, rank, target)
--??
end

function Venantes:OnSpellCast(spell, rank, target)
    --print ('cast',spell, rank, target)
	if spell ~= nil and self.spellTableRevIndex ~= nil then
        if target == nil then
            target = '';
        end
        local spellId = self.spellTableRevIndex[spell];
        -- remember traps, tracking, aspects
        if spellId == 'HUNTER_TRAP_FREEZING' or spellId == 'HUNTER_TRAP_FROST' or spellId == 'HUNTER_TRAP_IMMOLATION' or spellId == 'HUNTER_TRAP_EXPLOSIVE' 
            or spellId == 'HUNTER_TRAP_SNAKE' then
            -- remember last trap
            SphereButtons:ButtonRememberSpell('TrapsMenu', spellId);            
        elseif spellId == 'HUNTER_ASPECT_HAWK' or spellId == 'HUNTER_ASPECT_MONKEY' or spellId == 'HUNTER_ASPECT_CHEETAH' or spellId == 'HUNTER_ASPECT_PACK' 
            or spellId == 'HUNTER_ASPECT_BEAST' or spellId == 'HUNTER_ASPECT_WILD' or spellId == 'HUNTER_ASPECT_VIPER' then
            -- remember last tracking
            SphereButtons:ButtonRememberSpell('AspectMenu', spellId);            
        elseif spellId == 'HUNTER_TRACK_BEASTS' or spellId == 'HUNTER_TRACK_DEMONS' or spellId == 'HUNTER_TRACK_DRAGONKIN' or spellId == 'HUNTER_TRACK_ELEMENTALS' 
            or spellId == 'HUNTER_TRACK_GIANTS' or spellId == 'HUNTER_TRACK_HIDDEN' or spellId == 'HUNTER_TRACK_HUMANOIDS' or spellId == 'HUNTER_TRACK_HUMANOIDS'
            or spellId == 'HUNTER_TRACK_UNDEAD' 
            or spellId == 'TRADE_FIND_HERBS' or spellId == 'TRADE_FIND_MINERALS' or spellId == 'RACIAL_FIND_TREASURE' then
            -- remember last tracking
            SphereButtons:ButtonRememberSpell('TrackingMenu', spellId);
        else
            local inGroup = GetNumPartyMembers() > 0;
            if self.db.profile.messagesRaidMode then
                if inGroup then
                    if spellId ~= nil and spellId == 'HUNTER_HUNTERS_MARK' then
                        self:DoSpeech('GROUP_WARNING', 'RAID', 'HUNTERS_MARK', target);
                    elseif spellId ~= nil and  spellId == 'HUNTER_SHOT_TRANQ' then
                        self:DoSpeech('GROUP_WARNING', 'RAID', 'TRANQ_SHOT', target);            
                    end
                end
            elseif self.db.profile.messagesRandom then
                if inGroup and spellId ~= nil and  spellId == 'HUNTER_HUNTERS_MARK' and self.db.profile.messagesRandomHuntersMark then
                    self:DoSpeech('GROUP_WARNING', 'HUNTERS_MARK', nil, target);
                elseif inGroup and spellId ~= nil and  spellId == 'HUNTER_SHOT_TRANQ' and self.db.profile.messagesRandomTranqShot then
                    self:DoSpeech('GROUP_WARNING', 'TRANQ_SHOT', nil, target);
                elseif spellId ~= nil and  spellId == 'HUNTER_PET_CALL' and self.db.profile.messagesRandomPetCall then
                    self:DoSpeech('SAY', 'PET_CALL', nil, target);
                elseif spellId ~= nil and  spellId == 'HUNTER_PET_REVIVE' and self.db.profile.messagesRandomPetRevive then
                    self:DoSpeech('SAY', 'PET_REVIVE', nil, target);        
                elseif self.db.profile.messagesRandomMount then
                    local itemMountName, _, itemMountTitle = SphereInventory:InventoryGetMountData();
                    if itemMountName ~= nil and itemMountTitle ~= nil and itemMountTitle == spell then
                        self:DoSpeech('SAY', 'MOUNT', nil, nil, itemMountTitle);
                    end
                end
            end
        end
    end
end

function Venantes:ButtonRememberSpell(menuId, spellId)
    local optionName = 'remember'..menuId;
    if self.temporary == nil then
        self.temporary = {};
    end
    if self.temporary[optionName] == nil then
        self.temporary[optionName] = { 
            [0] = nil, 
            [1] = nil 
        }
    end
    if InCombatLockdown() or self.updatePending then
        if self.db.profile[optionName] then
            if self.db.profile[optionName][0] and self.temporary[optionName][0] == nil then
                self.temporary[optionName][0] = self.db.profile[optionName][0];
            end
            if self.db.profile[optionName][1] and self.temporary[optionName][1] == nil then
                self.temporary[optionName][1] = self.db.profile[optionName][1];
            end
        end
        if self.temporary[optionName][1] ~= spellId then
            if self.temporary[optionName][1] ~= nil then
                self.temporary[optionName][0] = self.temporary[optionName][1];
            else
                self.temporary[optionName][0] = spellId;
            end
            self.temporary[optionName][1] = spellId;        
        end
        self.updatePending = true;
    elseif self.db.profile[optionName] then
        self.temporary[optionName][0] = nil;
        self.temporary[optionName][1] = nil;
        if self.db.profile[optionName][1] and self.db.profile[optionName][1] ~= spellId then
            if self.db.profile[optionName][1] ~= '' then
                self.db.profile[optionName][0] = self.db.profile[optionName][1];
            else
                self.db.profile[optionName][0] = spellId;
            end
            self.db.profile[optionName][1] = spellId;
            self:UpdateActions();
            GameTooltip:Hide();
        end
    end
end

function Venantes:UpdateTemporaryOptions()
    if (not InCombatLockdown()) and self.updatePending then
        if self.temporary == nil then
            self.temporary = {};
            return;
        end        
        for optionName, optionValue in pairs(self.temporary) do
            if type(optionValue) == 'table' then
                for subOptionName, subOptionValue in pairs(optionValue) do
                    if subOptionValue ~= nil then
                        self.db.profile[optionName][subOptionName] = subOptionValue;
                        self.temporary[optionName][subOptionName] = nil;
                    end
                end
            elseif optionValue ~= nil then
                self.db.profile[optionName] = optionValue;
                self.temporary[optionName] = nil;
            end
        end
    end
end

function Venantes:GetButtonCooldownStr(cooldownString, cooldownUnit) 
    if cooldownUnit == 'h' then
        return '|c00FFCC00'..cooldownString..L['BUTTON_COOLDOWN_HOUR']..'|r';
    elseif cooldownUnit == 'm' then
        return '|c00FFCC00'..cooldownString..L['BUTTON_COOLDOWN_MINUTES']..'|r';
    else
        return '|c00FFCC00'..cooldownString..'|r';
    end
end

function Venantes:GetTooltipCooldownStr(cooldownString, cooldownUnit) 
    if cooldownUnit == 'h' then
        return L['COOLDOWN_REMAINING']..': '..cooldownString..L['TOOLTIP_COOLDOWN_HOUR'];
    elseif cooldownUnit == 'm' then
        return L['COOLDOWN_REMAINING']..': '..cooldownString..L['TOOLTIP_COOLDOWN_MINUTES'];
    else
        return L['COOLDOWN_REMAINING']..': '..cooldownString..L['TOOLTIP_COOLDOWN_SECONDS'];
    end
end
function Venantes:OnDragStart(element)
   --print ("drag start",element:GetName())
	if not InCombatLockdown() then
        element:StartMoving();
    end
end
function Venantes:OnDragStop(element)
      -- print ("drag stop",element:GetName())
	element:StopMovingOrSizing();
    if not InCombatLockdown() then
        if (not Venantes.db.profile.buttonLocking) and Venantes.db.profile.buttonsUseGrid then
            local gridSize = 10;        
            local point, relativeTo, relativePoint, xOfs, yOfs = element:GetPoint();
            local xOfsRounded = ((math.floor(xOfs / gridSize) + 0.5) * gridSize);
            local yOfsRounded = ((math.floor(yOfs / gridSize) + 0.5) * gridSize);        
            element:SetPoint(point, relativeTo, relativePoint, xOfsRounded, yOfsRounded);        
        end
        SphereButtons:ButtonUpdateMenus();
    end
end