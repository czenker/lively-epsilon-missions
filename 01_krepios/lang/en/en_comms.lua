local f = string.format
local t = My.Translator.translate

My.Translator:register("en", {
    comms_generic_hail = function(person)
        return Util.random({
            "Hello.",
            "Hi.",
            "Good day.",
            "Greetings.",
        }) .. " " .. t("comms_generic_introduction", person)
    end,
    comms_generic_introduction = function(person)
        return f(Util.random({
            "My name is %s.",
            "You are speaking to %s.",
            "%s is my name.",
        }), person:getFormalName())
    end,
    comms_generic_hail_station = function(stationCallSign)
        return Util.random({
            f("You are talking to station %s.", stationCallSign),
            f("You are connected to station %s.", stationCallSign),
        })
    end,
    comms_generic_friendly_inquiry = function()
        return Util.random({
            "How can I help?",
            "How can I be of service?",
            "What do you need from me?",
            "How do I earn the honor to talk to you?",
        })
    end,
    comms_generic_neutral_inquiry = function()
        return Util.random({
            "What do you want from me?",
            "Why do you want talk to me?",
            "Why do you bother me?",
        })
    end,
    comms_generic_enemy_inquiry = function()
        return Util.random({
            "Why do I have to endure your ugly face?",
            "What do I have to do for you to bother someone else?",
        })
    end,

    comms_generic_hail_friendly_ship = function(captainPerson)
        return t("comms_generic_hail", captainPerson) .. "\n\n" .. t("comms_generic_friendly_inquiry")
    end,
    comms_generic_hail_neutral_ship = function(captainPerson)
        return t("comms_generic_hail", captainPerson) .. "\n\n" .. t("comms_generic_neutral_inquiry")
    end,
    comms_generic_hail_enemy_ship = function(captainPerson)
        return t("comms_generic_enemy_inquiry")
    end,

    comms_generic_hail_friendly_station = function(stationCallSign)
        return t("comms_generic_hail_station", stationCallSign) .. "\n\n" .. t("comms_generic_friendly_inquiry")
    end,
    comms_generic_hail_neutral_station = function(stationCallSign)
        return t("comms_generic_hail_station", stationCallSign) .. "\n\n" .. t("comms_generic_neutral_inquiry")
    end,
    comms_generic_hail_enemy_station = function(stationCallSign)
        return t("comms_generic_enemy_inquiry")
    end,

    comms_generic_hail_friendly_station_docked = function(stationCallSign)
        return Util.random({
            f("Welcome to station %s.", stationCallSign),
            f("Welcome on station %s.", stationCallSign),
            f("We are happy to offer you a warm welcome on %s.", stationCallSign),
        })
    end,
    comms_generic_hail_neutral_station_docked = function(stationCallSign)
        return Util.random({
            f("Welcome on station %s.", stationCallSign),
            f("Welcome on %s.", stationCallSign),
        })
    end,

    comms_generic_flight_hail = function()
        return Util.random({
            "Oh my god.",
            "Aaargh!!!",
            "We are all going to die!!",
            "I don't wanna die.",
            "I am too young to die!",
        }) .. " " .. Util.random({
            "Who are the attackers? What do the want here?",
            "We are all lost! We don't stand a chance against them.",
        })
    end,

    comms_generic_flight_who_are_you = function()
        return Util.random({
            "What I am doing here? My God, do not tell me that you haven't noticed we are being attacked.",
            "You think you're funny?",
        }) .. " " .. Util.random({
            "Like everyone else in this sector, I'm trying to save my ass.",
            "No matter how hopeless the situation is, I'm trying to get to safety. And that's what you should also do.",
            "I'll fly as far away from the fights as possible.",
        })
    end,
})