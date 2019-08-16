local f = string.format
local t = My.Translator.translate

local lateForJobDescription = function(role, task, clientPerson, stationCallSign, payment)
    return t("comms_generic_hail", clientPerson) .. " " .. Util.random({
        "Ich arbeite als " .. role .. " bei der Saiku Mining Corporation und wurde von",
        "Als " .. role .. " bei der Saiku Mining Corporation wurde ich von",
        "In meinem Beruf als " .. role .. " bei der Saiku Mining Corporation wurde ich von",
        "Ich bin als " .. role .. " bei der Saiku Mining Corporation angestellt. Heute Morgen wurde ich von",
        "Ich bin " .. role .. " bei der Saiku Mining Corporation. Gestern Abend wurde ich von",
    }) .. " " .. stationCallSign .. " " .. Util.random({
        "angefordert, um",
        "beauftragt",
    }) .. " " .. task .. ". " ..  Util.random({
        "Leider habe ich mein Shuttle zur Station verpasst und nun muss ich mich nach Alternativen umschauen.",
        "Aufgrund eines Zwischenfalls in der Familie ist mein Pilot heute verhindert.",
        "Heute habe ich verschlafen. Eigentlich passiert mir das sonst nie, aber jetzt bin ich in einer Zwickmühle.",
    }) .. "\n\n" .. Util.random({
        f("Ich bin bereit %0.2fRP zu zahlen, wenn Sie mich zur Arbeit bringen.", payment),
        f("Zur Arbeit gebracht zu werden wäre mir %0.2fRP wert.", payment),
    })
end

My.Translator:register("de", {
    side_mission_transport_human = function(stationCallSign)
        return Util.random({
            f("Personentransport nach %s", stationCallSign),
            f("Bringe Person nach %s", stationCallSign),
        })
    end,
    side_mission_transport_human_description = function(clientPerson, stationCallSign, payment)
        return t("comms_generic_hail", clientPerson) .. " " .. Util.random({
            "Ich bin auf der Suche nach einer Mitfluggelegenheit nach ".. stationCallSign .. ".",
            "Fliegen Sie nach ".. stationCallSign .. "?",
            "Können Sie mich zur Station ".. stationCallSign .. " mitnehmen?",
            "Sie kommen nicht zufälligerweise an der Station ".. stationCallSign .. " vorbei, oder?",
        }) .. "\n\n" .. Util.random({
            f("Eine Bezahlung wäre natürlich auch drin. %0.2fRP würde ich springen lassen.", payment),
            f("Für ihr Umstände würde ich %0.2fRP bezahlen.", payment),
            f("Ihre Hilfe ist mir %0.2fRP wert.", payment),
            f("Ich habe %0.2fRP - die würde ich ihnen im Gegenzug bezahlen.", payment),
        })
    end,
    side_mission_transport_human_description_technician = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Cheftechniker",
            Util.random({
                "bei der Rekalibrierung der Bohrköpfe zu helfen",
                "das Abwärmeproblem in der Bohrmechanik zu lösen",
                "den Spritverbrauch der Bohrschiffe zu überprüfen",
                "die Steuerelektronik der autonomen Drohnen zu optimieren",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_chemist = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Chemiker",
            Util.random({
                "die Qualität des Erzes zu untersuchen",
                "chemische Untersuchungen an Asteroiden vorzunehmen",
                "Gestein auf Verunreinigungen hin zu untersuchen",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_ceo = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Executive Officer",
            Util.random({
                "die Rentabilität der Station einzuschätzen",
                "Verbesserungen in den Arbeitsabläufen vorzunehmen",
                "über Neuinvestitionen zu verhandeln",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_physician = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Arzt",
            Util.random({
                "eine merkwürdige Influenza zu untersuchen",
                "die Minenarbeiter von gesunder Ernährung zu überzeugen",
                "Hilfe für Alkoholiker anzubieten",
                "verletzte Arbeiter zu versorgen",
                "Unregelmäßigkeiten beim Krankheitsstand zu untersuchen",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_scientist = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Wissenschaftler",
            Util.random({
                "Einschlüsse in Eiskristallen zu untersuchen",
                "bei Experimenten zu unterstützen",
                "den Pleochroismus xenomorpher kristalliner Makromoleküle zu untersuchen",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,

    side_mission_transport_human_time_limit = function(timeLimit)
        return Util.random({
            f("Ich muss in %0.1f Minuten dort sein.", timeLimit),
            f("Ich muss innerhalb von %0.1f Minuten dort ankommen.", timeLimit),
        }) .. " Bitte beeilen Sie sich!"
    end,
    side_mission_transport_human_accept = "Vielen Dank, dass Sie mich mitnehmen werden. Ich hatte schon befürchtet, dass ich hier ewig festsitzen muss.",
    side_mission_transport_human_accept_hint = function(stationCallSign, clientPerson)
        return f("Docken Sie an %s, um %s abzuholen", stationCallSign, clientPerson:getFormalName())
    end,
    side_mission_transport_human_load_log = function(clientPerson)
        return clientPerson:getFormalName() .. " ist an Board gekommen"
    end,
    side_mission_transport_human_load_hint = function(stationCallSign, clientPerson)
        return f("Bringen Sie %s nach %s", clientPerson:getFormalName(), stationCallSign)
    end,
    side_mission_transport_human_success = function(stationCallSign, payment)
        return f("Vielen Dank, dass Sie mich nach %s gebracht haben. Die ausgemachte Bezahlung von %0.2fRP habe ich Ihnen selbstverständlich soeben überwiesen.", stationCallSign, payment)
    end,

})