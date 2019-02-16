local f = string.format

My.Translator:register("de", {
    side_mission_capture = function(criminalPerson)
        return "Kopfgeld " .. criminalPerson:getFormalName()
    end,
    side_mission_capture_description = function(criminalPerson, companionsNr, sectorName, payment)
        local HeShe, heShe
        if Person:hasTags(criminalPerson) and criminalPerson:hasTag("male") then
            HeShe = "Er"
            heShe = "er"
        else
            HeShe = "Sie"
            heShe = "sie"
        end

        local companionDescription
        if companionsNr == 0 then
            companionDescription = HeShe .. " " .. f("wurde vor Kurzem in Sektor %s gesichtet.", sectorName)
        elseif companionsNr == 1 then
            companionDescription = f("Zuletzt wurde " .. heShe .. " in Begleitung in Sektor %s gesehen.", sectorName)
        else
            companionDescription = HeShe .. " " .. f("wurde zuletzt in Begleitung von Freunden in Sektor %s gesichtet.", sectorName)
        end

        return f("Wir bitten um ihre Mithilfe bei der Ergreifung von %s.", criminalPerson:getFormalName()) .. " " .. heShe .. " wird wegen " .. Util.random({
            "Diebstahl von Firmeneigentum",
            "Entwendung von Firmenbesitz",
            "Teilnahme an einem nicht genehmigten Streik",
            "Erpressung von Vorgesetzten",
            "Beleidigung eines direkten Vorgesetzten",
            "Mitgliedschaft in einer Gewerkschaft",
            "Missachtung von Befehlen Vorgesetzter",
            "Missachtung von Dienstanweisungen",
            "gefährlicher Missachtung von Sicherheitsbestimmungen",
            "Missachtung der Pausenzeiten",
            "Unerlaubten Aufenthalt in einem Sicherheitsbereich",
        }) .. " von uns gesucht. " .. companionDescription .. " " .. f("Für die Ergreifung und Überführung in unsere Obhut zahlen wir %0.2fRP.", payment)
    end,
    side_mission_capture_accept = "Sie erweisen der Corporation einen wertvollen Dienst in dem Sie uns helfen, Ordnung in diesen Saustall zu bringen und ein abschreckendes Exempel zu statuieren.",
    side_mission_capture_pod_description = function(criminalPerson)
        return "Die Rettungskapsel von " .. criminalPerson:getFormalName()
    end,
    side_mission_capture_ship_description = function(captainPerson)
        return "Schiff von " .. captainPerson:getFormalName() .. ". Gesucht von der SMC."
    end,
    side_mission_capture_companion_description = function(captainPerson, criminalPerson)
        local relation, HeShe
        if captainPerson:hasTag("male") then
            HeShe = "Er"
            relation = Util.random({
                "ein Kollege",
                "ein Freund aus alten Tagen",
                "ein Schulfreund",
                "ein Cousin",
                "ein Mitbewohner",
                "ein Bekannter",
            })
        else
            HeShe = "Sie"
            relation = Util.random({
                "eine Kollegin",
                "eine Freundin aus alten Tagen",
                "eine Schulfreundin",
                "eine Cousine",
                "eine Mitbewohnerin",
                "eine Bekannte",
            })
        end

        return f(
            "Dieses Schiff wird von %s geflogen. %s ist %s von %s.",
            captainPerson:getFormalName(),
            HeShe,
            relation,
            criminalPerson:getFormalName()
        )
    end,
    side_mission_capture_too_close = "Ey Alter, du bist viel zu nah am Zielgebiet.", -- @TODO
    side_mission_capture_start_hint = function(criminalPerson, sectorName)
        return f("Finden Sie %s in Sektor %s", criminalPerson:getFormalName(), sectorName)
    end,
    side_mission_capture_approach_comms = function(criminalPerson, companionsNr)
        local description = f("Sie sollten %s jetzt auf ihrem Schirm sehen. Sie müssen %s Schiff zerstören und %s Rettungskapsel bergen.",
                criminalPerson:hasTag("male") and Util.random({
                    "den Verbrecher",
                    "den Kriminellen",
                }) or Util.random({
                    "die Verbrecherin",
                    "die Kriminelle",
                }),
                criminalPerson:hasTag("male") and "sein" or "ihr",
                criminalPerson:hasTag("male") and "seine" or "ihre"
        )
        if companionsNr > 0 then
            description = description .. " " .. f(
                    "%s ist in Begleitung, die %s bis in den Tod verteidigen wird. Diese Kollaborateure interessieren uns nicht und es steht ihnen frei, sie aus dem Äther zu blasen.",
                    criminalPerson:getFormalName(),
                    criminalPerson:hasTag("male") and "ihn" or "sie"
            )
        end

        return description
    end,
    side_mission_capture_approach_hint = function(shipCallSign, criminalPerson)
        return f("Zerstören Sie %s um %s's Rettungskapsel aufsammeln zu können", shipCallSign, criminalPerson:getFormalName())
    end,
    side_mission_capture_bearer_destruction_comms = "Jetzt gibt es Ärger.",
    side_mission_capture_bearer_destruction_hint = function(criminalPerson, sectorName)
        return f("Sammeln Sie die Rettungskapsel von %s in Sektor %s ein", criminalPerson:getFormalName(), sectorName)
    end,

    side_mission_capture_item_destruction_comms = function(criminalPerson)
        return f("Die Rettungskapsel von %s wurde zerstört. Wir machen Ihnen keinen Vorwurf, aber ich denke Sie verstehen, dass wir jede Verwicklung in den Zwischenfall abstreiten werden. Eine Bezahlung können wir Ihnen darum auch nicht anbieten.\n\nWir betrachten Auftrag hiermit als beendet.", criminalPerson:getFormalName())
    end,
    side_mission_capture_pickup_hint = function(stationCallSign)
        return f("Docken Sie an der Station %s", stationCallSign)
    end,
    side_mission_capture_success_comms = function(criminalPerson, payment)
        return "Vielen Dank für die Hilfe bei der Ergreifung " .. (criminalPerson:hasTag("male") and Util.random({
            "des Verbrechers",
            "des Kriminellen",
        }) or Util.random({
            "der Verbrecherin",
            "der Kriminellen",
        })) .. " " .. criminalPerson:getFormalName() .. ". Allzu schnell wird " .. (criminalPerson:hasTag("male") and "er" or "sie") .. " die Luft der Freiheit nicht mehr atmen können. " .. f("Sie erhalten wie versprochen %0.2fRP für ihre Hilfe.", payment)
    end,
})