------------------------------------------------------------------------------------------------------
-- Venantes - French translation
--
-- Translated by: Dagonet (EU, Alliance), Bastien Ribot
--
-- Maintainer: Zirah on Blackhand (EU, Alliance)
--
-- Based on Ideas by:
--Serenity and Cryolysis by Kaeldra of Aegwynn 
--Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
--Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
------------------------------------------------------------------------------------------------------

--local L = AceLibrary('AceLocale-3.0'):new('Venantes')
local L = LibStub("AceLocale-3.0"):NewLocale('Venantes',"frFR")
if not L then return end


L['SLASH_COMMANDS'] = '/venantes'
L["TOGGLE_CONFIG"] = "Panneau de configuration"
L['TOGGLE_MINIMAP'] = 'Toggle minimap icon'
L['CLICK_TOGGLE_CONFIG'] = 'Click to toggle the config dialog!'
L['ERROR_LOAD'] = 'Erreur de chargement'
L['NONE'] = 'None'
 
  -- labels
L['AMMO'] = 'Munitions'
L['UNIT_ON_TAXI'] = 'Taxi'
  
  --cooldown 
L['COOLDOWN_REMAINING'] = 'Cooldown restant'
L['BUTTON_COOLDOWN_HOUR'] = 'h'
L['BUTTON_COOLDOWN_MINUTES'] = 'm'
L['TOOLTIP_COOLDOWN_HOUR'] = 'h'
L['TOOLTIP_COOLDOWN_MINUTES'] = 'min'
L['TOOLTIP_COOLDOWN_SECONDS'] = 's'
  
  -- user messages
L['MSG_INCOMBAT'] = 'Vous etes en combat'
L['MSG_FULLMANA'] = 'Vous etes full mana'
L['MSG_FULLHEALTH'] = 'Vous etes full vie'
  
  --tooltips
L['TOOLTIP_LEFTCLICK'] = 'Click Gauche'
L['TOOLTIP_RIGHTCLICK'] = 'Click Droit'
L['TOOLTIP_DRINKFOOD'] = 'Boisson/Nourriture'
L['TOOLTIP_POTION'] = 'Potions'
  
L['TAB_SPHERE'] = 'Sphere'
L['TAB_BUTTONS'] = 'Bouttons'
L['TAB_MESSAGES'] = 'Messages'
L['TAB_INVENTORY'] = 'Inventaire'
L['TAB_DEBUG'] = 'Debug'
  -- options messages tab
L['MESSAGES_LANGUAGE'] = 'langue'
L['MESSAGES_ONSCREEN'] = 'Afficher les messages sur l\'ecran'
L['MESSAGES_TEXTURE_DEBUG'] = 'montrer les textures manquantes'
L['MESSAGES_TOOLTIPS'] = 'Voir la bulle d aide'
L['MESSAGES_RAID'] = 'Voir uniquement les messages raid'
L['MESSAGES_RANDOM'] = 'messages Aleatoires'
L['MESSAGES_RANDOM_HUNTERSMARK'] = 'Marque du chasseur'
L['MESSAGES_RANDOM_TRANQSHOT'] = 'Tir tranquilisant'
L['MESSAGES_RANDOM_PETCALL'] = 'Appel du Familier'
L['MESSAGES_RANDOM_PETREVIVE'] = 'Ressusciter le Familier'
L['MESSAGES_RANDOM_MOUNT'] = 'Monture'
  -- options button tab
L['SHOW_BUTTONS'] = 'Voir les buttons'
L['BUTTON_DRINK_FOOD'] = 'Boissons et nourriture'
L['BUTTON_POTION'] = 'Vie et Mana'
L['BUTTON_USE_WEAKEST'] = 'Use weakest'
L['BUTTON_MOUNT'] = 'Monture'
L['BUTTON_PETMENU'] = 'Menu du Familier'
L['BUTTON_ASPECTMENU'] = 'Menu des Aspects'
L['BUTTON_TRACKINGMENU'] = 'Menu pistage'
L['BUTTON_TRAPSMENU'] = 'Menu pieges'
L['BUTTON_ACTION_ONE'] = '1 er Bouton'
L['BUTTON_ACTION_TWO'] = '2 ieme Bouton'
L['BUTTON_ACTION_THREE'] = '3 ieme Bouton'
  -- options graphics tab
L['LOCK_SPHERE'] = 'BLoque la position de la sphere'
L['LOCK_BUTTONS'] = 'BLoque la position des boutons'
L['SPHERE_SKIN'] = 'Sphere skin'
L['SPHERE_ROTATION'] = 'Tourne les boutons'
L['SPHERE_SCALE'] = 'Taille de la sphere'
L['BUTTON_SCALE'] = 'Taille des boutons'
L['SPHERE_CIRCLE'] = 'Sphere circle'
L['SPHERE_OPACITY'] = 'Sphere transparence'
L['BUTTON_OPACITY'] = 'Boutons transparence'
L['BUTTON_ORDERCCW'] = 'Order buttons counter clockwise'
L['SPHERE_TEXT'] = 'texte sur la sphere'
L['MENU_KEEPOPEN'] = 'Keep menus open'
  -- status info titles
L['STATUS_MANA'] = 'Mana'
L['STATUS_HEALTH'] = 'Vie'
L['STATUS_XP'] = 'Experience'
L['STATUS_PET_MANA'] = 'Mana du pet'
L['STATUS_PET_HEALTH'] = 'Vie du Pet'
L['STATUS_PET_XP'] = 'Experience du pet'
L['STATUS_PET_HAPPY'] = 'Pet happyness'
L['STATUS_DRINK_FOOD'] = 'Boissons/Nourriture'
L['STATUS_AMMO'] = 'Munitions'
  -- slot names
L['SLOT_Trinket0Slot'] = 'Trinket 1';
L['SLOT_Trinket1Slot'] = 'Trinket 2';
  -- debug
L['DEBUG_ITEMDROP'] = 'Drag an item to the box';
L['DEBUG_TEXTURES'] = 'Missing textures';
