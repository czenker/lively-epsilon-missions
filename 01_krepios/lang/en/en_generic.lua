My.Translator:register("en", {
    generic_button_back = "back",
    generic_and = "and",
    generic_unknown_ship = "unknown flying object",
    generic_unknown_station = "unknown station",
    generic_unknown_object = "unknown object",

    generic_comms_ship_static = "The ship does not reply.",
    generic_comms_station_static = "The station does not reply.",

    generic_mission_time_limit = function(timeLimit)
        return string.format("time left: %0.1f minutes", timeLimit)
    end,

    generic_mission_failed = function(missionTitle)
        return string.format("Mission \"%s\" failed", missionTitle)
    end,
    generic_mission_successful = function(missionTitle)
        return string.format("Mission \"%s\" successful", missionTitle)
    end,
})