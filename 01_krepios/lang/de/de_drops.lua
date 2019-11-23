local f = string.format

My.Translator:register("de", {

    drops_name = function()
        return Util.random({
            "Container",
            "Schiffscontainer",
            "Kanister",
            "Kiste",
            "Transportbehälter",
        })
    end,

    drops_generic_description_full = "Inhalt:",

    drops_description_full = function(shipCallSign)
        return Util.random({
            f("Dieser Schiffscontainer stammt vom Schiff %s, das in diesem Minenfeld verunglückte.", shipCallSign),
            f("Der Container scheint vom Schiff %s hier verloren worden zu sein.", shipCallSign),
            f("Der Container stammt vom havarierten Schiff %s.", shipCallSign),
        }) .. " " .. Util.random({
            "Er enthält:",
            "In ihm befindet sich:",
            "Die Scans zeigen als Inhalt:",
        })
    end,

    drops_pickup = "Sie haben folgendes aufgenommen:",

    drops_ship_description = function(shipCallSign)
        return Util.random({
            f("Das Wrack des Schiffs %s.", shipCallSign),
            f("Die Überreste eines Schiffs mit Namen \"%s\".", shipCallSign),
            f("Das sind die Überreste des Schiffs %s.", shipCallSign),
        }) .. " " .. Util.random({
            "Eine Kolission mit einer Mine hat es zerstört.",
            "Die Crew hatte Probleme mit der Navigation, was zur Zerstörung des Schiffs in einem Minenfeld führte.",
            "Wie es in einem Minenfeld endete bleibt ungeklärt.",
        })
    end,

    drops_content_energy = "Energie",
    drops_content_reputation = "RP",

})