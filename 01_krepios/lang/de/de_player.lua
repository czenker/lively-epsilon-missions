My.Translator:register("de", {
    player_storage_display_label = "Lagerraum",
    player_storage_display_title = "Lagerraumverwaltung",
    player_storage_display_label_used_storage = "verwendeter Lagerplatz",
    player_storage_display_empty_storage = "Der Lagerraum ist aktuell leer.",

    player_mission_display_label = "Missionen",
    player_mission_display_title_active_missions = "Aktive Missionen",
    player_mission_display_no_active_missions = "Sie haben keine aktuellen Missionen.",

    player_upgrade_display_label = "Upgrades",
    player_upgrade_display_title = "Upgrades",
    player_upgrade_display_no_upgrades = "Sie haben keine Upgrades installiert.",

    player_power_presets_label = "Voreinstellungen",
    player_power_presets_label_load = "Laden",
    player_power_presets_label_load_item = "Einstellung",
    player_power_presets_label_store = "Speichern",
    player_power_presets_label_store_item = "Einstellung",
    player_power_presets_label_reset = "Zurücksetzen",
    player_power_presets_label_info = "Informationen",
    player_power_presets_info_text = function(amount)
        return "Dieses Modul erlaubt Ihnen Voreinstellungen für Energie- und Kühlmitteleinstellungen in bis zu " .. amount ..
        " Plätzen zu speichern. Bitte beachten Sie, dass nur der aktuelle Zustand und nicht der eingestellte Zielzustend \z
        gespeichert wird."
    end,
})