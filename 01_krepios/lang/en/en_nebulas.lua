local f = string.format

local description = function(nebulaName, size, sectorName)
    local desc
    if size <= 4 then desc = "small nebula"
    elseif size >= 6 then desc = "big nebula"
    else desc = "nebula"
    end

    return f("%s is a %s in sector %s.", nebulaName, desc, sectorName)
end

My.Translator:register("en", {
    nebulas_description = function(nebulaName, size, sectorName)
        return description(nebulaName, size, sectorName) .. " " .. Util.random({
            "It is said to be one of the beautiful in the area.",
            "Travel guides recommend a flight here because the play of colors is incomparable.",
            "Occasionally small travel groups or transporters get lost here.",
            "They say whoever travels here will return a happy person. Whether this also applies to aliens, is unknown.",
            "It is probably the least interesting nebula in the region.",
            "There is nothing more to say about it.",
            "And that is about everything there is to know about it.",
        })
    end,
    nebulas_description_battlefield = function(nebulaName, size, sectorName)
        return description(nebulaName, size, sectorName) .. " " .. Util.random({
            "It is recommended to avoid the nebula, because there are regular reports of fighting.",
            "Unarmed ships are recommended to enter only with armed company.",
            "It was used as a retreat for pirates in the past. It can not be ruled out that there is danger in this nebula.",
            "It is recommended to approach it with care and not enter the nebula unprepared.",
            "Many traders and smaller armed vessels disappeared without a trace here in the last years.",
        })
    end,
    nebulas_description_research = function(nebulaName, size, sectorName, researchStationName)
        return description(nebulaName, size, sectorName) .. " " .. Util.random({
            f("There is rarely any space ship here that does not visit the station %s.", researchStationName),
            f("It is not worth visiting it if you don't want to fly to %s station.", researchStationName),
            f("If you believe the travel guides, it is not recommended visiting this nebula, because it is inhabited by the \"eggheads of %s\".", researchStationName),
        })
    end,
})