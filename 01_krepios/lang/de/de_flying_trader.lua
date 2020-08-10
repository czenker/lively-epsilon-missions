local t = My.Translator.translate
local f = string.format

local flying_trader_who_are_you = function(captainPerson, job)
    return t("comms_generic_introduction", captainPerson) .. " " .. Util.random({
        "Ich bin als fliegender Händler in vielen Sektoren unterwegs.",
        "Ich bin als freier Händler in unterschiedlichen Sektoren unterwegs.",
        "Ich kaufe und verkaufe Waren aller Art in der Hoffnung genügend Profit zu machen.",
    }) .. " " .. job .. " " .. Util.random({
        "Ehrlich gesagt bin ich froh, wenn ich den Sektor wieder verlassen kann. An den Stationen habe ich Angst, dass ein besoffener Miner mir mein Schiff auf der Suche nach Ersatzteilen auseinander nimmt.",
        "Wenn ich aus dem Drecksloch wieder raus bin, werde ich mich sehr freuen. Hier nagt der Zahn der Zeit sichtbar.",
    })
end

My.Translator:register("de", {
    flying_trader_description = function(shipCallSign)
        return Util.random({
            "Ein großer Transporter, der für Flüge zwischen verschiedenen Systemen konstruiert wurde.",
            "Ein Handelsschiff, das zwischen mehreren Systemen verkehrt.",
            "Hin und wieder kommen solche großen Handelsschiffe nach Krepios, um Handel zu betreiben."
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
    
    local_trader_description = function(stationCallSign, metalBandName)
        return Util.random({
            "Ein in die Jahre gekommenener Transporter für Kurzstrecken.",
            "Das Model dieses Transporters ist schon seit mehreren Jahren veraltet.",
            "Mit einem zugedrückten Auge ist dieser Transporter für kurze Strecken gerade noch so als Raumschiff zu bezeichnen.",
        }) .. " " .. Util.random({
            "Die meisten Transportcontainer sind mit Graffiti übersäht.",
            "Mehrere Graffitikünstler haben sich auf der Schiffshülle verewigt.",
            "Die Aufhängung von einigen Containern scheint nicht mehr sehr stabil zu sein.",
            "Kratzer und kleinere Asteroideneinschläge in den Fenstern zeugen vom Alter des Schiffs.",
            "Ein Sticker am Heck ruft dazu auf zu hupen, wenn man auch Fan von \"" .. metalBandName .. "\" ist.",
            "Die Typenbezeichnung von \"" .. stationCallSign .. "\" am Rumpf ist nur noch schlecht lesbar.",
            "Mit einem Laser wurde eine Grafik in die Hülle geschweißt, die man nur als \"Banane zwischen zwei kleinen Orangen\" beschreiben kann."
        })
    end,

    local_trader_buyer_who_are_you = function(captainPerson, stationCallSign, productName)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("Ich bin im Auftrag von %s unterwegs.", stationCallSign),
            f("Ich fliege mit meinem Frachtschiff im Auftrag von %s.", stationCallSign),
            f("Ich werde von %s bezahlt.", stationCallSign),
            f("Mein Auftraggeber ist %s.", stationCallSign),
        }) .. " " .. Util.random({
            f("Ich kaufe %s von den umliegenden Stationen und liefere sie nach %s.", productName, stationCallSign),
            f("Mein Auftrag ist %s von anderen Stationen im Sektor zu kaufen und sie zurückzuliefern.", productName),
            f("Für die Station kaufe ich %s von umliegenden Stationen auf und liefere sie.", productName),
        }) .. " " .. Util.random({
            "Der Job ist meistens sehr langweilig, weil man viel durchs leere All fliegt. Aber wenn ich dafür nicht von Piraten überfallen werde, will ich mich nicht beschweren.",
            f("Die meiste Zeit bin ich damit beschäftigt von Station zu Station zu fliegen, um den besten Preis für %s zu finden.", productName),
            f("Es ist nicht immer einfach %s günstig zu kaufen, aber wenn ich einen guten Deal mache, kann ich den Gewinn selbst behalten.", productName),
        })
    end,
})