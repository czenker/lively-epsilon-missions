local t = My.Translator.translate
local f = string.format

local flying_trader_who_are_you = function(captainPerson, job)
    return t("comms_generic_introduction", captainPerson) .. " " .. Util.random({
        "Ich bin als fliegender Händler in vielen Sektoren unterwegs.",
        "Ich bin als freier Händler in unterschiedlichen Sektoren unterwegs.",
        "Ich kaufe und verkaufe Waren aller Art in der Hoffnung genügend Profit zu machen.",
    }) .. " " .. job .. " " .. Util.random({
        "Ehrlich gesagt bin ich froh, wenn ich den Sektor wieder verlassen kann. An den Stationen habe ich Angst, dass ein besoffener Miner mir mein Schiff auf der Suche nach Ersatzteilen auseinander nimmt.",
        "Wenn ich aus dem Drecksloch wieder raus bin werde ich mich sehr freuen. Hier nagt der Zahn der Zeit sichtbar.",
    })
end

My.Translator:register("de", {
    flying_trader_description = function(shipCallSign, captainPerson)
        return Util.random({
            "Ein großer Transporter, der für Flüge zwischen verschiedenen Systemen konstruiert wurde.",
            "Ein Handelsschiff, das zwischen mehreren Systemen verkehrt.",
            "Hin und wieder kommen solche großen Handelsschiffe nach Krepios um Handel zu betreiben."
        }) .. " " .. Util.random({
            "Im Gegensatz zu den systemeigenen Schiffen sieht dieser Transporter einigermaßen ansehnlich aus.",
            "Auf den ersten Blick sieht man ihm an, dass es nicht aus Krepios kommt. Dafür ist es zu sauber und gut in Schuss gehalten.",
            "Im Augenblick dürfte " .. shipCallSign .. " einer der teuersten Transporter im System sein.",
        })
    end,

    flying_trader_buyer_who_are_you = function(captainPerson, stationCallSign, productNames)
        productNames = Util.mkString(productNames, ", ", " " .. t("generic_and") .. " ")
        return flying_trader_who_are_you(captainPerson, Util.random({
            f("In diesem Sektor bin ich unterwegs, weil ich %s von der Station %s kaufen möchte.", productNames, stationCallSign),
            f("Mir ist zu Ohren gekommen, dass man auf %s günstig %s kaufen kann.", stationCallSign, productNames),
        }))
    end,
    flying_trader_seller_who_are_you = function(captainPerson, stationCallSign, productNames)
        productNames = Util.mkString(productNames, ", ", " " .. t("generic_and") .. " ")
        return flying_trader_who_are_you(captainPerson, Util.random({
            f("Ich hoffe auf %s einen guten Preis für %s zu bekommen.", stationCallSign, productNames),
            f("In diesem Sektor bin ich unterwegs, weil ich %s auf der Station %s verkaufen möchte.", productNames, stationCallSign),
            f("Mir ist zu Ohren gekommen, dass man auf %s ordentlich Gewinn macht, wenn man %s verkauft.", stationCallSign, productNames),
        }))
    end,
})