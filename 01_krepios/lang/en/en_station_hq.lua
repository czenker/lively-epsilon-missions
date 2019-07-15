local t = My.Translator.translate
local f = string.format

My.Translator:register("en", {
    station_hq_description = "The only station in the outer asteroid belt that one could call \"civilized\" with one eye closed. Families of miners enjoy the relative wealth here provided by casinos, malls and countless bars.",

    station_hq_ship_description = function(stationCallSign, metalBandName)
        return Util.random({
            "An aging transporter for short distance hauling.",
            "This model of transport ship is outdated by a few decades.",
            "If the transporter is not inspected too closely, it could be called a space ship.",
        }) .. " " .. Util.random({
            "Most of the transport containers are covered with graffiti.",
            "Multiple graffiti artists immortalized themselves on the ship's hull.",
            "The mounting of some containers does not look reliable anymore.",
            "Scratches and smaller holes created by hits of smaller asteroids bear witness of the ship's age.",
            "A sticker on the tail asks to honk if you are also a fan of \"" .. metalBandName .. "\".",
            "The name plate of \"" .. stationCallSign .. "\" on the ship's body is barely decipherable.",
            "With the use of a laser a graphic was welded into the hull, that can only be described as \"Banana between two small oranges\".",
        })
    end,

    station_hq_ship_buyer_who_are_you = function(captainPerson, stationCallSign, productName)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("I'm flying for %s.", stationCallSign),
            f("I am on a job for %s.", stationCallSign),
            f("I am paid by %s.", stationCallSign),
            f("My client is %s.", stationCallSign),
        }) .. " " .. Util.random({
            f("I buy %s from the surrounding stations and deliver it to %s.", productName, stationCallSign),
            f("My job is to buy %s from other stations in this sector and return it to %s.", productName, stationCallSign),
            f("I buy %s from sellers around and deliver it back to the station.", productName),
        }) .. " " .. Util.random({
            "The job is usually very boring. There is mostly empty space during the flights. But as long as I am not raided by pirates I do not want to complain.",
            f("Most of the time I am occupied to fly from station to station to find the best price for %s.", productName),
            f("It is not always easy to find a low price for %s, but if a get a good deal I can keep the profit.", productName),
        })
    end,
})