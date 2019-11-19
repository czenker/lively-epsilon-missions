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

    drops_description_unknown = "unbekanntes Objekt",

    drops_description_full = function(shipCallSign, value, energy)
        return Util.random({
            f("Dieser Schiffscontainer stammt vom Schiff %s, das in diesem Minenfeld verunglückte.", shipCallSign),
            f("Der Container scheint vom Schiff %s hier verloren worden zu sein.", shipCallSign),
            f("Der Container stammt vom havarierten Schiff %s.", shipCallSign),
        }) .. " " .. Util.random({
            f("Er enthält %0.2fRP und %d Energie.", value, energy),
            f("In ihm befinden sich %0.2fRP und %d Energie.", value, energy),
            f("Die Scans zeigen, dass der Inhalt %0.2fRP und %d Energie sind.", value, energy),
        })
    end,

    drops_pickup = function(value, energy)
        return f("Sie haben %0.2fRP und %d Energie aufgesammelt.", value, energy)
    end,

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

})