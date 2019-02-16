My.Translator:register("de", {
    generic_button_back = "zurück",
    generic_and = "und",
    generic_unknown_ship = "unbekanntes fliegendes Objekt",
    generic_unknown_station = "unbekannte Station",
    generic_unknown_object = "unbekanntes Objekt",

    generic_comms_ship_static = "Das Schiff antwortet nicht.",
    generic_comms_station_static = "Die Station antwortet nicht.",

    generic_mission_failed = function(missionTitle)
        return string.format("Mission \"%s\" gescheitert", missionTitle)
    end,
    generic_mission_successful = function(missionTitle)
        return string.format("Mission \"%s\" erfolgreich beendet", missionTitle)
    end,
})