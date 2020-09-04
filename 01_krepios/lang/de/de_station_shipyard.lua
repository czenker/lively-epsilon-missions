local f = string.format

My.Translator:register("de", {

    shipyard_station_description = function(nebulaName)
        return "Früher wurden auf dieser Station Schiffe repariert und konstruiert. Auch einige kleinere Stationen des Sektors wurden hier teilweise gefertigt." ..
        "Nachdem sie aufgrund ihrer Unwirtschaftlichkeit aufgegeben wurde, verwandelten einige Ingenieure und Konstrukteure diese Station in einen Bastelladen " ..
        "für Drohnen and Kleinschiffe.\n\n" ..
        "Im nahe gelegenen Nebel " .. nebulaName .. " unterhält die Station eine Arena, in der regelmäßig Schaukämpfe von Dronen abgehalten werden."
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

    shipyard_workshop_comms_upgrade_available = function(tinkererPerson, upgradeName, stationName, upgradePrice)
        return Util.random({
            "Hallo Freunde.",
        }) .. " " .. Util.random({
            f("Dank eurer großzügigen Finanzierung konnte ich \"%s\" soweit fertigstellen, dass es weniger oft explodiert.", upgradeName),
            f("Da ihr mich finanziell unterstützt habt, biete ich euch \"%s\" als Alpha Version an.", upgradeName)
        }) .. " " .. Util.random({
            "Euch sollte aber klar sein, dass ich keinerlei Garantie übernehmen kann.",
            "Für Schäden, die an Personen oder Gegenständen durch statische Entladung, Fehlfunktionen oder spontane Entzündungen entstehen, übernehme ich keine Haftung.",
            "Bitte meldet mir nur die kritischsten Fehler, die ihr findet. Ich habe keine Zeit, mich um alle zu kümmern.",
        }) .. " " .. f("Kommt auf %s vorbei, und ich verkaufe es euch zu einem Freundschaftspreis von %0.2fRP.", stationName, upgradePrice) ..
        "\n\n- " .. tinkererPerson:getNickName()
    end,

    shipyard_workshop_comms_current_research_none = "But unfortunately I have no more ideas for helpful new inventions.",

    shipyard_workshop_comms_invest = "Invest in development",
    shipyard_workshop_comms_invest_hail_progress_0 = function(upgradeName)
        return f("I just started research on a project I call \"%s\".", upgradeName)
    end,
    shipyard_workshop_comms_invest_hail_progress_1 = function(upgradeName)
        return f("I've already put some effort into constructing \"%s\".", upgradeName)
    end,
    shipyard_workshop_comms_invest_hail_progress_2 = function(upgradeName)
        return f("I can show you a prototype of \"%s\" I'm currently working on.", upgradeName)
    end,
    shipyard_workshop_comms_invest_hail_progress_3 = function(upgradeName)
        return f("I have almost finished my work on \"%s\".", upgradeName)
    end,
    shipyard_workshop_comms_invest_hail_funding_0 = "But no one seems to be interested in it.",
    shipyard_workshop_comms_invest_hail_funding_1 = "I have a little funding, but some more would ensure fast development.",
    shipyard_workshop_comms_invest_hail_funding_2 = "I am very well funded and progress goes on continuously.",
    shipyard_workshop_comms_invest_hail_funding_3 = "I'm not really looking for investors at the moment, but if you want to throw money at me, I won't stop you.",

    shipyard_workshop_comms_invest_hail = function()
        return Util.random({
            "If you wish to invest I could speed up my work and give you a little discount once it is finished.",
            "Are you one of the investors? I will give you a discount on it and I could speed up my work.",
        })
    end,
    shipyard_workshop_comms_invest_description = function()
        return Util.random({
            "Here is what it does:",
            "When it is finished it can do the following:",
            "This is what it is good for:",
            "Here is why I think it would be useful:",
        })
    end,
    shipyard_workshop_comms_invest_poor = "We don't have the funds currently either.",
    shipyard_workshop_comms_invest_amount = function(amount)
        return f("Invest %0.2fRP", amount)
    end,

    shipyard_workshop_comms_invest_thanks = "Wow. Thank you for your interest in almost safe inventions. I've also put you on my comms list, so will be informed once my latest inventions are out.",

    shipyard_workshop_comms_change = "Change development",
    shipyard_workshop_comms_change_hail = "Well, you can get everything for a price. If you pay enough, I could put my other investors off and pursue something else.\n\nI have some other blueprints that you might be interested in:",
    shipyard_workshop_comms_change_response = function(upgradeName)
        return "Tell me about " .. upgradeName
    end,
    shipyard_workshop_comms_change_price = function(price)
        return f("I could change my development priority to it for a small fee of %0.2fRP.", price)
    end,
    shipyard_workshop_comms_change_confirm = function(price)
        return f("Change for %0.2fRP", price)
    end,
    shipyard_workshop_comms_change_ok = function(upgradeName)
        return "Alright I will prioritize work on " .. upgradeName .. "."
    end,
})