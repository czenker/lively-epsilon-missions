local f = string.format

My.Translator:register("en", {

    shipyard_workshop_comms_current_research_none = "Aber leider sind mir die Ideen für gute, neue Erfindungen ausgegangen.",
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
    shipyard_workshop_comms_invest_poor = "We don't have the funds currently either.",
    shipyard_workshop_comms_invest_amount = function(amount)
        return f("Invest %0.2fRP", amount)
    end,

    shipyard_workshop_comms_invest_thanks = "Wow. Thank you for your interest in almost safe inventions. I've also put you on my comms list, so will be informed once my latest inventions are out.",

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