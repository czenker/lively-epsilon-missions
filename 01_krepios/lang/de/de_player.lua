local f = string.format

My.Translator:register("de", {
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

    player_mining_label = "Asteroid abbauen",
    player_mining_error_invalid_target = "Es gibt keinen Asteroiden in Laserreichweite.",
    player_mining_error_not_enough_power = function(minEnergy)
        return f("Es werden mindestens %d Energie benötigt, um mit Abbau eines Asteroiden zu beginnen.", minEnergy)
    end,
    player_mining_error_invalid_station = "Das Beam Weapon System muss repariert, ausreichend gekühlt und vollständig mit Energie versorgt sein, damit ein Asteroid abgebaut werden kann.",
})