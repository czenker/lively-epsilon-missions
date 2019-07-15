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
})