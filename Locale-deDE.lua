------------------------------------------------------------------------------------------------------
-- Venantes - German translations
--
-- Maintainer : Zirah on Blackhand (EU, Alliance)
--
-- Maintainer: Zirah on Blackhand (EU, Alliance)
--
-- Based on Ideas by:
--   Serenity and Cryolysis by Kaeldra of Aegwynn 
--   Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
--   Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
------------------------------------------------------------------------------------------------------


local L = LibStub("AceLocale-3.0"):NewLocale('Venantes',"deDE")
if not L then return end

L:RegisterTranslations('deDE', function() return {
  ['SLASH_COMMANDS'] = { '/venantes', '/venan' },
  ['TOGGLE_CONFIG'] = 'Konfigurationsdialog anzeigen/verbergen',
  ['TOGGLE_MINIMAP'] = 'Minimap Icon ein-/ausblenden',
  ['CLICK_TOGGLE_CONFIG'] = 'Anklicken um den Konfigurationsdialog anzuzeigen/zu verbergen!',
  ['ERROR_LOAD'] = 'Ladefehler',
  ['NONE'] = 'Nichts',
    
  -- labels
  ['AMMO'] = 'Munition',
  ['UNIT_ON_TAXI'] = 'Taxi',
  
  -- cooldowns
  ['COOLDOWN_REMAINING'] = 'Abklingzeit verbleibend',
  ['BUTTON_COOLDOWN_HOUR'] = 'h',
  ['BUTTON_COOLDOWN_MINUTES'] = 'm',
  ['TOOLTIP_COOLDOWN_HOUR'] = 'h',
  ['TOOLTIP_COOLDOWN_MINUTES'] = 'min',
  ['TOOLTIP_COOLDOWN_SECONDS'] = 's',
  
  -- user messages
  ['MSG_INCOMBAT'] = 'Im Kampf nicht möglich',
  ['MSG_FULLMANA'] = 'Du hast volles Mana',
  ['MSG_FULLHEALTH'] = 'Du hast volles Leben',
  
  -- tooltips
  ['TOOLTIP_LEFTCLICK'] = 'Linksklick',
  ['TOOLTIP_RIGHTCLICK'] = 'Rechtsklick',
  ['TOOLTIP_MIDDLECLICK'] = 'Mittelklick',
  ['TOOLTIP_DRINKFOOD'] = 'Trinken/Essen',
  ['TOOLTIP_POTION'] = 'Tränke',
  
  -- option tabs
  ['TAB_SPHERE'] = 'Sphäre',
  ['TAB_BUTTONS'] = 'Knöpfe',
  ['TAB_MESSAGES'] = 'Nachrichten',
  ['TAB_INVENTORY'] = 'Inventar',
  ['TAB_DEBUG'] = 'Fehlersuche',
  -- tooltips
  ['MESSAGES_TOOLTIPS'] = 'Tooltips anzeigen',  
  ['MESSAGES_TOOLTIPS_DEFAULTPOS'] = 'Tooltips an der Standardposition anzeigen',
  -- options messages tab
  ['MESSAGES_LANGUAGE'] = 'Nachrichtensprache',
  ['MESSAGES_ONSCREEN'] = 'Venantes-Nachrichten auf dem Bildschirm anzeigen',
  ['MESSAGES_TEXTURE_DEBUG'] = 'Fehlende Texturen melden',
  ['MESSAGES_RAID'] = 'Nur kurze Raidnachrichten anzeigen',
  ['MESSAGES_RANDOM'] = 'Zufällige Nachrichten',
  ['MESSAGES_RANDOM_HUNTERSMARK'] = 'Mal des Jägers',
  ['MESSAGES_RANDOM_TRANQSHOT'] = 'Einlullender Schuß',
  ['MESSAGES_RANDOM_PETCALL'] = 'Begleiter rufen',
  ['MESSAGES_RANDOM_PETREVIVE'] = 'Begleiter wiederbeleben',
  ['MESSAGES_RANDOM_MOUNT'] = 'Reittier rufen',
  -- options button tab
  ['SHOW_BUTTONS'] = 'Knöpfe anzeigen',
  ['BUTTON_DRINK_FOOD'] = 'Essen und Trinken',
  ['BUTTON_POTION'] = 'Heil-/Manatrank',
  ['BUTTON_USE_WEAKEST'] = 'Schwächste verwenden',
  ['BUTTON_MOUNT'] = 'Reittier',
  ['BUTTON_PETMENU'] = 'Begleiter-Menü',
  ['BUTTON_ASPECTMENU'] = 'Aspekt-Menü',
  ['BUTTON_TRACKINGMENU'] = 'Spurensuche-Menü',
  ['BUTTON_TRAPSMENU'] = 'Fallen-Menü',
  ['BUTTON_ACTION_ONE'] = 'Erster Aktionsknopf',
  ['BUTTON_ACTION_TWO'] = 'Zweiter Aktionsknopf',
  ['BUTTON_ACTION_THREE'] = 'Dritter Aktionsknopf',
  -- options graphics tab
  ['LOCK_SPHERE'] = 'Sphäre sperren',
  ['LOCK_BUTTONS'] = 'Knöpfe an Sphäre ausrichten',
  ['SPHERE_SKIN'] = 'Sphärenoptik',
  ['SPHERE_ROTATION'] = 'Knöpfe rotieren',
  ['SPHERE_SCALE'] = 'Sphäre skalieren',
  ['BUTTON_SCALE'] = 'Knöpfe skalieren',
  ['SPHERE_CIRCLE'] = 'Kreisanzeige',
  ['SPHERE_OPACITY'] = 'Transparenz (Sphäre)',
  ['BUTTON_OPACITY'] = 'Transparenz (Knöpfe)',
  ['BUTTON_ORDERCCW'] = 'Knöpfe entgegen Uhrzeigersinn anordnen',
  ['SPHERE_TEXT'] = 'Sphärentexte',
  ['MENU_KEEPOPEN'] = 'Menüs geöffnet lassen',
  -- status info titles
  ['STATUS_MANA'] = 'Mana',
  ['STATUS_HEALTH'] = 'Leben',
  ['STATUS_XP'] = 'Erfahrung',
  ['STATUS_PET_MANA'] = 'Begleiter Mana',
  ['STATUS_PET_HEALTH'] = 'Begleiter Leben',
  ['STATUS_PET_XP'] = 'Begleiter Erfahrung',
  ['STATUS_PET_HAPPY'] = 'Begleiter Stimmung',
  ['STATUS_DRINK_FOOD'] = 'Trinken/Essen',
  ['STATUS_AMMO'] = 'Munition',
  -- slot names
  ['SLOT_Trinket0Slot'] = 'Trinket 1';
  ['SLOT_Trinket1Slot'] = 'Trinket 2';
  -- debug
  ['DEBUG_ITEMDROP'] = 'Ziehe einen Gegenstand in die Box';
  ['DEBUG_TEXTURES'] = 'Fehlende Texturen';
} end)