local f = string.format

My.Translator:register("en", {
    comms_directions_label = "directions",
    comms_directions_main = function()
        return Util.random({
            "Where do you want to go?",
            "What can I help you with?",
        })
    end,
    comms_directions_detail = function(stationCallSign, stationSectorName)
        return Util.random({
            f("The last time I was there, %s was in sector %s.", stationCallSign, stationSectorName),
            f("Station %s is in sector %s.", stationCallSign, stationSectorName),
            f("I think %s is in sector %s.", stationCallSign, stationSectorName),
            f("I heard %s is a station in sector %s.", stationCallSign, stationSectorName),
        })
    end,
    comms_directions_detail_friendly = function(distance, heading)
        return Util.random({
            f("It's about %du heading %d from my position.", distance, heading),
            f("Heading from my position it's about %du heading %d.", distance, heading),
        })
    end,
    comms_directions_detail_close = "The station is in my immediate vicinity.",
    comms_directions_detail_error = "I have no idea where that is.",
})