local t = My.Translator.translate
local f = string.format

local flying_trader_who_are_you = function(captainPerson, job)
    return t("comms_generic_introduction", captainPerson) .. " " .. Util.random({
        "I am a flying trader traveling many sectors.",
        "As a flying trader, I am traveling through many sectors.",
        "I buy and sell goods of all kinds in the hope of making enough profit.",
    }) .. " " .. job .. " " .. Util.random({
        "Honestly, I'll be glad to leave the sector again. At the stations I am afraid that a drunken miner will take my ship apart in search of spare parts.",
        "When I'm out of this shit hole again, I'll be very happy. The ravages of time are clearly visible here.",
    })
end

My.Translator:register("en", {
    flying_trader_description = function(shipCallSign)
        return Util.random({
            "A large transporter designed for flights between different systems.",
            "A merchant ship that travels between several systems.",
            "From time to time such large merchant ships come to Krepios to trade."
        }) .. " " .. Util.random({
            "In contrast to the system's own ships, this transporter looks somewhat respectable.",
            "At first glance you can see that it doesn't originate from Krepios. It's too clean and mostly intact.",
            "At the moment " .. shipCallSign .. " is one of the most expensive transports in the system right now.",
        })
    end,

    flying_trader_buyer_who_are_you = function(captainPerson, stationCallSign, productNames)
        productNames = Util.mkString(productNames, ", ", " " .. t("generic_and") .. " ")
        return flying_trader_who_are_you(captainPerson, Util.random({
            f("I'm in this sector because I want to buy %s from %s.", productNames, stationCallSign),
            f("It came to my attention that you can buy %s cheaply from %s.", stationCallSign, productNames),
        }))
    end,
    flying_trader_seller_who_are_you = function(captainPerson, stationCallSign, productNames)
        productNames = Util.mkString(productNames, ", ", " " .. t("generic_and") .. " ")
        return flying_trader_who_are_you(captainPerson, Util.random({
            f("I hope to sell %s on %s for a nice profit.", productNames, stationCallSign),
            f("I am traveling through this sector to sell %s to %s.", productNames, stationCallSign),
            f("It came to my attention that %s buys %s and I can make a healthy profit.", stationCallSign, productNames),
        }))
    end,

    local_trader_description = function(stationCallSign, metalBandName)
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

    local_trader_buyer_who_are_you = function(captainPerson, stationCallSign, productName)
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