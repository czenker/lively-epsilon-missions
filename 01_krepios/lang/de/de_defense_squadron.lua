local t = My.Translator.translate
local f = string.format

My.Translator:register("de", {
    defense_squadron_description = function()
        return Util.random({
            "Ein notdürftig zusammen gestelltes Schiff.",
            "Ein Schiff, das aus vielen Resten zusammen gebaut wurde.",
            "Viele Teile des Schiffs wirken improvisiert.",
            "Dieses Schiff ist kurz davor auseinander zu fallen.",
        }) .. " " .. Util.random({
            "Der Lack ist an vielen Stellen abgeblättert.",
            "Die Schweißnähte, die das Heck mit der Hülle verbinden sind noch gut sichtbar.",
            "An diesem Schiff befindet sich so gut wie kein Originalteil.",
            "Es hat keine Betriebszulassung.",
        })
    end,
    defense_squadron_command_label = "Wir haben Befehle",

    defense_squadron_command_not_leader = function(leaderPerson, leaderCallSign)
        return f(
            "Ich folge %s und handele nur nach %s Befehl.\n\n%s ist Kapitän auf dem Schiff %s.",
            leaderPerson:hasTag("male") and "meinem Staffelführer " .. leaderPerson:getFormalName() or "meiner Staffelführerin " .. leaderPerson:getFormalName(),
            leaderPerson:hasTag("male") and "seinem" or "ihrem",
            leaderPerson:hasTag("male") and "Er" or "Sie",
            leaderCallSign
        )
    end,

    defense_squadron_command_leader = function(person)
        return f("Sie sprechen mit Kapitän %s. Wie kann ich Ihnen helfen?", person:getFormalName())
    end,


    defense_squadron_command_move_label = "Fliegt nach [...]",
    defense_squadron_command_move_hail = "Wohin sollen wir fliegen?",
    defense_squadron_command_move_hail_no_waypoint = "Können Sie uns einen Wegpunkt setzen?",
    defense_squadron_command_move_waypoint_label = function(waypointId, sectorName)
        return f("WP%d in Sektor %s", waypointId, sectorName)
    end,
    defense_squadron_command_move_ok = "Gut. Wir sind unterwegs zu ihrem Wegpunkt.",
    defense_squadron_command_move_success = "Wir haben unseren Wegpunkt erreicht. Was ist unser nächster Befehl?",


    defense_squadron_command_defend_label = "Verteidigt [...]",
    defense_squadron_command_defend_hail = "Welches Ziel sollen wir verteidigen?",
    defense_squadron_command_defend_ok = function(callSign)
        return "Gut. Wir beschützen " .. callSign .."."
    end,
    defense_squadron_command_defend_nok = "Das Ziel existiert nicht.",


    defense_squadron_command_attack_label = "Greift [...] an",
    defense_squadron_command_attack_hail = "Welches Ziel sollen wir angreifen?",
    defense_squadron_command_attack_fleet_label = function(i)
        return "Flotte " .. i
    end,
    defense_squadron_command_attack_fleet_ok = function(i)
        return "Gut. Wir greifen die Flotte " .. i .. " mit voller Härte an."
    end,
    defense_squadron_command_attack_fleet_nok = "Wir wissen nicht, wo sich diese Flotte befindet.",
    defense_squadron_command_attack_ship_ok = function(shipCallSign)
        return "Gut. Wir greifen das Schiff " .. shipCallSign .. " mit voller Härte an."
    end,
    defense_squadron_command_attack_ship_nok = "Dieses Schiff existiert unseres Wissens nach nicht mehr.",
    defense_squadron_command_attack_success = "Wir haben unser Ziel zerstört.",


    defense_squadron_command_dock_label = "Dockt an [...]",
    defense_squadron_command_dock_hail = "An welche Station sollen wir docken?",
    defense_squadron_command_dock_ok = function(callSign)
        return f("Gut. Wir docken an die Station %s, um zu reparieren und unsere Bewaffnung aufzufüllen.", callSign)
    end,
    defense_squadron_command_dock_nok = "Diese Station existiert nicht.",
    defense_squadron_command_dock_success = "Wir haben die Reparaturen abgeschlossen und unsere Waffen aufgefüllt.",



    defense_squadron_command_strategy_label = "Strategie besprechen",
    defense_squadron_command_strategy_hail = "Wie sollen wir unsere Strategie anpassen?",

    defense_squadron_command_frequency_label = "Laserfrequenz anpassen",
    defense_squadron_command_frequency_hail = "Gut. Wir können die Frequenzen unserer Laser anpassen.\n\nAuf welche Frequenz?",
    defense_squadron_command_frequency_detail_label = function(frequency)
        return f("%dTHz", frequency)
    end,
    defense_squadron_command_frequency_detail_ok = function(frequency)
        return f("Gut. Wir werden unsere Laser auf %dTHz justieren.", frequency)
    end,

    defense_squadron_command_enable_warp_label = "Fliegt mit Warpantrieb",
    defense_squadron_command_enable_warp_ok = "Wir werden unseren Warpantrieb wieder aktivieren.",


    defense_squadron_command_disable_warp_label = "Fliegt mit Impulsantrieb",
    defense_squadron_command_disable_warp_ok = "Wir werden unseren Warpantrieb deaktivieren und mit Impulsantrieb fliegen.",

    defense_squadron_report = "Statusbericht",
    defense_squadron_report_hull = "Hülle",
    defense_squadron_report_shield = "Schild",
    defense_squadron_report_total_fleet = "Flottengröße",
    defense_squadron_report_total_hull = "Hülle gesamt",
    defense_squadron_report_total_shield = "Schilde gesamt",
    defense_squadron_report = "Statusbericht",

})