local f = string.format

My.Translator:register("de", {

    shipyard_station_description = function(nebulaName)
        return "Früher wurden auf dieser Station Schiffe repariert und konstruiert. Auch einige kleinere Stationen des Sektors wurden hier teilweise gefertigt." ..
        "Nachdem sie aufgrund ihrer Unwirtschaftlichkeit aufgegeben wurde, verwandelten einige Ingenieure und Konstrukteure diese Station in einen Bastelladen " ..
        "für Drohnen and Kleinschiffe.\n\n" ..
        "Im nahe gelegenen Nebel " .. nebulaName .. " unterhält die Station eine Arena, in der regelmäßig Schaukämpfe von Drohnen abgehalten werden."
    end,

    shipyard_workshop_name = function(tinkererPerson)
        return Names.possessive(tinkererPerson:getNickName()) .. " Werkstatt"
    end,

    shipyard_workshop_comms_hail = function(tinkerPerson)
        return Util.random({
            "Willkommen. Ich bin " .. tinkerPerson:getNickName() .. "."
        }) .. " " .. Util.random({
            "Wenn ihr auf der Suche nach gebastelten Upgrades seid, dann seid ihr bei mir genau richtig.",
            "Bei mir findet ihr allerlei Ramsch, den ihr nirgends sonst findet.",
        })
    end,

    shipyard_workshop_comms_current_research = function(upgradeName)
        return f("Ich forsche an einem Upgrade, dass ich \"%s\" nenne.", upgradeName)
    end,

    shipyard_workshop_comms_current_research_none = "Aber leider sind mir die Ideen für gute, neue Erfindungen ausgegangen.",

})