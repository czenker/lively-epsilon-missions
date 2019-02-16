local f = string.format
local t = My.Translator.translate

My.Translator:register("de", {
    comms_generic_hail = function(person)
        return Util.random({
            "Hallo.",
            "Servus.",
            "Guten Tag.",
            "Seien Sie gegrüßt.",
        }) .. " " .. t("comms_generic_introduction", person)
    end,
    comms_generic_introduction = function(person)
        return f(Util.random({
            "Mein Name ist %s.",
            "Sie sprechen mit %s.",
            "%s ist mein Name.",
        }), person:getFormalName())
    end,
    comms_generic_hail_station = function(stationCallSign)
        return Util.random({
            f("Sie sprechen mit Station %s.", stationCallSign),
            f("Sie sind mit der Station %s verbunden.", stationCallSign),
        })
    end,
    comms_generic_friendly_inquiry = function()
        return Util.random({
            "Wie kann ich helfen?",
            "Womit kann ich dienen?",
            "Wie kann ich behilflich sein?",
            "Was benötigt ihr von mir?",
            "Was verschafft mir die Ehre für dieses Gespräch?",
        })
    end,
    comms_generic_neutral_inquiry = function()
        return Util.random({
            "Was wollt ihr von mir?",
            "Warum wollt ihr mit mir sprechen?",
            "Warum stört ihr mich?",
        })
    end,
    comms_generic_enemy_inquiry = function()
        return Util.random({
            "Weshalb muss ich euer grausames Gesicht ertragen?",
            "Was muss ich tun, damit ihr jemand anderen behelligt?",
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
            f("Herzlich willkommen auf der Station %s.", stationCallSign),
            f("Herzlich willkommen auf %s.", stationCallSign),
            f("Wir freuen uns Sie auf %s willkommen heißen zu dürfen.", stationCallSign),
        })
    end,
    comms_generic_hail_neutral_station_docked = function(stationCallSign)
        return Util.random({
            f("Willkommen auf der Station %s.", stationCallSign),
            f("Willkommen auf %s.", stationCallSign),
        })
    end,

    comms_generic_flight_hail = function()
        return Util.random({
            "Oh mein Gott.",
            "Waaaaaahhhhh!!!",
            "Wir werden alle sterben!!",
            "Ich will noch nicht Sterben.",
            "Ich bin zu jung zum Sterben.",
        }) .. " " .. Util.random({
            "Wer sind die Feinde, die uns angreifen? Was wollen die hier?",
            "Wir sind verloren! Gegen die haben wir keine Möglichkeit zu gewinnen.",
        })
    end,

    comms_generic_flight_who_are_you = function()
        return Util.random({
            "Was ich hier tue? Mein Gott, erzählt mir nicht, dass ihr nicht gemerkt habt, dass wir angegriffen werden.",
            "Haltet ihr euch für lustig?",
        }) .. " " .. Util.random({
            "Wie jeder andere hier im Sektor versuche ich meinen Arsch zu retten.",
            "Egal wie aussichtslos die Situation ist - ich versuche mich in Sicherheit zu bringen. Und das solltet ihr auch tun.",
            "Ich fliege so weit wie möglich weg von den Kämpfen.",
        })
    end,
})