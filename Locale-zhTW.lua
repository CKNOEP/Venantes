------------------------------------------------------------------------------------------------------
-- Venantes - Traditional Chinese translation
--
-- Translated by: 
--
-- Maintainer: Zirah on Blackhand (EU, Alliance)
--
-- Based on Ideas by:
--   Serenity and Cryolysis by Kaeldra of Aegwynn 
--   Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
--   Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
------------------------------------------------------------------------------------------------------


local L = LibStub("AceLocale-3.0"):NewLocale('Venantes',"zhTW")
if not L then return end

L:RegisterTranslations('zhTW', function() return {
  ['SLASH_COMMANDS'] = { '/venantes', '/venan' },
  ['TOGGLE_CONFIG'] = 'Toggle config panel',
  ['TOGGLE_MINIMAP'] = 'Toggle minimap icon',
  ['CLICK_TOGGLE_CONFIG'] = 'Click to toggle the config dialog!',
  ['ERROR_LOAD'] = 'Loading Error',
  ['NONE'] = 'None',
    
  -- labels
  ['AMMO'] = 'Ammo',
  ['UNIT_ON_TAXI'] = 'Taxi',
  
  --cooldown 
  ['COOLDOWN_REMAINING'] = 'Cooldown remaining',
  ['BUTTON_COOLDOWN_HOUR'] = 'h',
  ['BUTTON_COOLDOWN_MINUTES'] = 'm',
  ['TOOLTIP_COOLDOWN_HOUR'] = 'h',
  ['TOOLTIP_COOLDOWN_MINUTES'] = 'min',
  ['TOOLTIP_COOLDOWN_SECONDS'] = 's',
  
  -- user messages
  ['MSG_INCOMBAT'] = 'You\'re in combat',
  ['MSG_FULLMANA'] = 'You have full mana',
  ['MSG_FULLHEALTH'] = 'You have full health',
  
  --tooltips
  ['TOOLTIP_LEFTCLICK'] = 'Left Click',
  ['TOOLTIP_RIGHTCLICK'] = 'Right Click',
  ['TOOLTIP_MIDDLECLICK'] = 'Middle Click',
  ['TOOLTIP_DRINKFOOD'] = 'Drink/Food',
  ['TOOLTIP_POTION'] = 'Potions',
  
  ['TAB_SPHERE'] = 'Sphere',
  ['TAB_BUTTONS'] = 'Buttons',
  ['TAB_MESSAGES'] = 'Messages',
  ['TAB_INVENTORY'] = 'Inventory',
  ['TAB_DEBUG'] = 'Debug',
  -- tooltips
  ['MESSAGES_TOOLTIPS'] = 'Show tooltips',
  ['MESSAGES_TOOLTIPS_DEFAULTPOS'] = 'Show tooltips at default position',
  -- options messages tab
  ['MESSAGES_LANGUAGE'] = 'Message language',
  ['MESSAGES_ONSCREEN'] = 'Show Venantes messages on screen',
  ['MESSAGES_TEXTURE_DEBUG'] = 'Show missing texture messages',
  ['MESSAGES_RAID'] = 'Show only short raid messages',
  ['MESSAGES_RANDOM'] = 'Random messages',
  ['MESSAGES_RANDOM_HUNTERSMARK'] = 'Hunter\'s Mark',
  ['MESSAGES_RANDOM_TRANQSHOT'] = 'Tranquilizing Shots',
  ['MESSAGES_RANDOM_PETCALL'] = 'Call Pet',
  ['MESSAGES_RANDOM_PETREVIVE'] = 'Revive Pet',
  ['MESSAGES_RANDOM_MOUNT'] = 'Summon Mount',
  -- options button tab
  ['SHOW_BUTTONS'] = 'Show buttons',
  ['BUTTON_DRINK_FOOD'] = 'Drink and food',
  ['BUTTON_POTION'] = 'Heal and mana potion',
  ['BUTTON_USE_WEAKEST'] = 'Use weakest',
  ['BUTTON_MOUNT'] = 'Mount',
  ['BUTTON_PETMENU'] = 'Pet menu',
  ['BUTTON_ASPECTMENU'] = 'Aspect menu',
  ['BUTTON_TRACKINGMENU'] = 'Tracking menu',
  ['BUTTON_TRAPSMENU'] = 'Traps menu',
  ['BUTTON_ACTION_ONE'] = 'First Action Button',
  ['BUTTON_ACTION_TWO'] = 'Second Action Button',
  ['BUTTON_ACTION_THREE'] = 'Third Action Button',
  -- options graphics tab
  ['LOCK_SPHERE'] = 'Lock sphere',
  ['LOCK_BUTTONS'] = 'Lock buttons to sphere',
  ['SPHERE_SKIN'] = 'Sphere skin',
  ['SPHERE_ROTATION'] = 'Rotate buttons',
  ['SPHERE_SCALE'] = 'Scale sphere',
  ['BUTTON_SCALE'] = 'Scale buttons',
  ['SPHERE_CIRCLE'] = 'Sphere circle',
  ['SPHERE_OPACITY'] = 'Sphere transparency',
  ['BUTTON_OPACITY'] = 'Button transparency',
  ['BUTTON_ORDERCCW'] = 'Order buttons counter clockwise',
  ['SPHERE_TEXT'] = 'Sphere text',
  ['MENU_KEEPOPEN'] = 'Keep menus open',
  -- status info titles
  ['STATUS_MANA'] = 'Mana',
  ['STATUS_HEALTH'] = 'Health',
  ['STATUS_XP'] = 'Experience',
  ['STATUS_PET_MANA'] = 'Pet Mana',
  ['STATUS_PET_HEALTH'] = 'Pet Health',
  ['STATUS_PET_XP'] = 'Pet Experience',
  ['STATUS_PET_HAPPY'] = 'Pet happyness',
  ['STATUS_DRINK_FOOD'] = 'Drink/Food',
  ['STATUS_AMMO'] = 'Ammo',  
  -- slot names
  ['SLOT_Trinket0Slot'] = 'Trinket 1';
  ['SLOT_Trinket1Slot'] = 'Trinket 2';
  -- debug
  ['DEBUG_ITEMDROP'] = 'Drag an item to the box';
  ['DEBUG_TEXTURES'] = 'Missing textures';
} end)