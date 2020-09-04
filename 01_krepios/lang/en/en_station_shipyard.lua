local f = string.format

My.Translator:register("en", {

    shipyard_station_description = function(nebulaName)
        return "This station used to repair and construct space ships. But some parts of the smaller stations of the sector were also produced here. " ..
               "After it became unprofitable and was abandoned, some of the former engineers transformed this station into a tinker shop for drones and "  ..
               "small space craft.\n\n" ..
               "The station maintains an arena in the close nebula " .. nebulaName .. " and hosts regular show fights with drones."
    end,

    shipyard_workshop_name = function(tinkererPerson)
        return Names.possessive(tinkererPerson:getNickName()) .. " Workshop"
    end,

    shipyard_workshop_comms_hail = function(tinkerPerson)
        return Util.random({
            "Welcome. I am " .. tinkerPerson:getNickName() .. "."
        }) .. " " .. Util.random({
            "If you are looking for scrap or tinkered upgrades, you found the right place.",
            "Here you can find loads of junk that you won't find anywhere else.",
        })
    end,

    shipyard_workshop_comms_upgrade_available = function(tinkererPerson, upgradeName, stationName, upgradePrice)
        return Util.random({
            "Hey Friends.",
        }) .. " " .. Util.random({
            f("Thanks to your generous contribution I was able to finish \"%s\". And you might be happy to hear that it explodes only half as often as before.", upgradeName),
            f("Because you have supported me financially I can offer you \"%s\" as an Alpha Version.", upgradeName)
        }) .. " " .. Util.random({
            "It should be self-explanatory that I can not give any guaranteees.",
            "I am not liable for damage to people or objects cause by static discharge, malfunctions or spontaneous ignition.",
            "Please only report the most critical malfunctions. I can't take care of all of them.",
        }) .. " " .. f("Stop at %s and I will sell it to you for a special price of %0.2fRP.", stationName, upgradePrice) ..
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