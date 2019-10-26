local f = string.format

My.Translator:register("en", {
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

    player_mining_label = "Mine Asteroid",
    player_mining_error_invalid_target = "There are no asteroids in range of the laser beams.",
    player_mining_error_not_enough_power = function(minEnergy)
        return f("At least %d energy are needed to start mining.", minEnergy)
    end,
    player_mining_error_invalid_station = "The Beam Weapon System needs to be healthy, properly cooled and fully powered for mining.",

})