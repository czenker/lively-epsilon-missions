My.Translator:register("en", {
    player_storage_display_label = "Storage Room",
    player_storage_display_title = "Storage Room Management",
    player_storage_display_label_used_storage = "used storage space",
    player_storage_display_empty_storage = "The storage room is empty.",

    player_mission_display_label = "Missions",
    player_mission_display_title_active_missions = "active missions",
    player_mission_display_no_active_missions = "You do not have any current missions.",

    player_upgrade_display_label = "Upgrades",
    player_upgrade_display_title = "Upgrades",
    player_upgrade_display_no_upgrades = "You do not have any upgrades installed.",

    player_power_presets_label = "Power Presets",
    player_power_presets_label_load = "Load",
    player_power_presets_label_load_item = "Preset",
    player_power_presets_label_store = "Store",
    player_power_presets_label_store_item = "Preset",
    player_power_presets_label_reset = "Reset",
    player_power_presets_label_info = "Information",
    player_power_presets_info_text = function(amount)
        return "This module allows storing up to " .. amount .. " presets for energy and coolant distribution and load \z
        them up at any time. Please note that only the current state is stored, not the targeted state."
    end,
})