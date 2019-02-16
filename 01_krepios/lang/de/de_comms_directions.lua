local f = string.format

My.Translator:register("de", {
    comms_directions_label = "Richtungsangaben",
    comms_directions_main = function()
        return Util.random({
            "Wo soll es denn hingehen?",
            "Womit kann ich helfen?",
        })
    end,
    comms_directions_detail = function(stationCallSign, stationSectorName)
        return Util.random({
            f("Das letzte Mal, dass ich da war befand sich die Station %s im Sektor %s.", stationCallSign, stationSectorName),
            f("Die Station %s befindet sich im Sektor %s.", stationCallSign, stationSectorName),
            f("Ich glaube, %s liegt im Sektor %s.", stationCallSign, stationSectorName),
            f("Ich habe gehört, dass die Station %s im Sektor %s zu finden ist.", stationCallSign, stationSectorName),
        })
    end,
    comms_directions_detail_friendly = function(distance, heading)
        return Util.random({
            f("Etwa %du in Richtung %d von meiner Position aus.", distance, heading),
            f("Von meiner Position aus ist das in etwa %du in Richtung %d.", distance, heading),
        })
    end,
    comms_directions_detail_close = "Die Station befindet sich in meiner unmittelaren Nähe.",
    comms_directions_detail_error = "Ich habe keine Ahnung, wo das ist.",
})