local f = string.format

My.Translator:register("de", {

    research_station_description = function(stationCallSign, nebulaName)
        return Util.random({
            "Eine kleine Forschungsstation in ".. nebulaName .. ".",
        }) .. " " .. Util.random({
            "Die Datenbank enthält keine Einträge über signifikante Entdeckungen, die hier entwickelt wurden.",
            "Für die Wissenschaftswelt ist diese Station unbedeutend.",
        })
    end,
})