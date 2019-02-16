local t = My.Translator.translate
local f = string.format

My.Translator:register("de", {
    station_hq_description = "Die einzige Station im äußeren Meteoritenbereich, den man mit einem zugedrückten Auge als \"zivilisiert\" bezeichnen kann. Familien von Bergarbeitern geniesen hier den relativen Luxus, den Casions, Einkaufszentren und unzählige Bars bieten.",

    station_hq_ship_description = function(stationCallSign, captainPerson, metalBandName)
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

    station_hq_ship_buyer_who_are_you = function(captainPerson, stationCallSign, productName)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("Ich bin im Auftrag von %s unterweges.", stationCallSign),
            f("Ich fliege mit meinem Frachtschiff im Auftrag von %s.", stationCallSign),
            f("Ich werde von %s bezahlt.", stationCallSign),
            f("Mein Auftraggeber ist %s.", stationCallSign),
        }) .. " " .. Util.random({
            f("Ich kaufe %s von den umliegenden Stationen und liefere sie nach %s.", productName, stationCallSign),
            f("Mein Auftrag ist %s von anderen Stationen im Sektor zu kaufen und sie zurück zu liefern.", productName),
            f("Für die Station kaufe ich %s von umliegenden Stationen auf und liefere sie.", productName),
        }) .. " " .. Util.random({
            "Der Job ist meistens sehr langweilig, weil man viel durchs leere All fliegt. Aber wenn ich dafür nicht von Piraten überfallen werde, will ich mich nicht beschweren.",
            f("Die meiste Zeit bin ich damit beschäftigt von Station zu Station zu fliegen um den besten Preis für %s zu finden.", productName),
            f("Es ist nicht immer einfach %s güstig zu kaufen, aber wenn ich einen guten Deal mache kann ich den Gewinn selbst behalten.", productName),
        })
    end,
})