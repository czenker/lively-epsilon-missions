local t = My.Translator.translate
local f = string.format

My.Translator:register("en", {
    defense_squadron_description = function()
        return Util.random({
            "A makeshift ship.",
            "A ship built from badly fitting remains.",
            "Many parts of the ship seem improvised.",
            "This ship is about to fall apart.",
        }) .. " " .. Util.random({
            "The paint has flaked off in many places.",
            "The weld seams connecting the tail with the hull are still clearly visible.",
            "There is almost no original part on this ship.",
            "It has no operating license.",
        })
    end,
    defense_squadron_command_label = "We have orders",

    defense_squadron_command_not_leader = function(leaderPerson, leaderCallSign)
        return f(
            "I follow my squad leader %s and only act on %s commands.\n\n%s is captain on the ship named %s.",
            leaderPerson:getFormalName(),
            leaderPerson:hasTag("male") and "his" or "her",
            leaderPerson:hasTag("male") and "He" or "She",
            leaderCallSign
        )
    end,

    defense_squadron_command_leader = function(person)
        return f("You are talking to captain %s. How can I help you?", person:getFormalName())
    end,


    defense_squadron_command_move_label = "Fly to [...]",
    defense_squadron_command_move_hail = "Where should we fly to?",
    defense_squadron_command_move_hail_no_waypoint = "Can you set us a waypoint?",
    defense_squadron_command_move_waypoint_label = function(waypointId, sectorName)
        return f("WP%d in sector %s", waypointId, sectorName)
    end,
    defense_squadron_command_move_ok = "Roger. We're on our way to your waypoint.",
    defense_squadron_command_move_success = "We've reached our waypoint. What is our next order?",


    defense_squadron_command_defend_label = "Defend [...]",
    defense_squadron_command_defend_hail = "Which target should we defend?",
    defense_squadron_command_defend_ok = function(callSign)
        return "Roger. We are defending " .. callSign .."."
    end,
    defense_squadron_command_defend_nok = "This target does not exist.",


    defense_squadron_command_attack_label = "Attack [...]",
    defense_squadron_command_attack_hail = "Which target should we attack?",
    defense_squadron_command_attack_fleet_label = function(i)
        return "Fleet " .. i
    end,
    defense_squadron_command_attack_fleet_ok = function(i)
        return "Roger. We are attacking Fleet " .. i .. " with full force."
    end,
    defense_squadron_command_attack_fleet_nok = "We don't know where this fleet is.",
    defense_squadron_command_attack_ship_ok = function(shipCallSign)
        return "Roger. We are attacking " .. shipCallSign .. " with full force."
    end,
    defense_squadron_command_attack_ship_nok = "As far as we know, this ship no longer exists.",
    defense_squadron_command_attack_success = "We've destroyed our target.",


    defense_squadron_command_dock_label = "Dock [...]",
    defense_squadron_command_dock_hail = "What station should we dock to?",
    defense_squadron_command_dock_ok = function(callSign)
        return f("Roger. We're docking at %s to repair and replenish our weapons.", callSign)
    end,
    defense_squadron_command_dock_nok = "This station does not exist.",
    defense_squadron_command_dock_success = "We finished our repairs and replenished our weapons.",



    defense_squadron_command_strategy_label = "Discuss strategy",
    defense_squadron_command_strategy_hail = "How should we adjust our strategy?",

    defense_squadron_command_frequency_label = "Adjust laser frequency",
    defense_squadron_command_frequency_hail = "Roger. We can adjust the frequencies of our lasers.\n\nAt what frequency?",
    defense_squadron_command_frequency_detail_label = function(frequency)
        return f("%dTHz", frequency)
    end,
    defense_squadron_command_frequency_detail_ok = function(frequency)
        return f("Roger. We will adjust our Lasers to %dTHz.", frequency)
    end,

    defense_squadron_command_enable_warp_label = "Use your warp drive",
    defense_squadron_command_enable_warp_ok = "Roger. We will activate our warp drive",


    defense_squadron_command_disable_warp_label = "Use your impulse drive",
    defense_squadron_command_disable_warp_ok = "Roger. We will deactivate our warp drive and fly with our impulse drive only.",

    defense_squadron_report = "status report",
    defense_squadron_report_hull = "Hull",
    defense_squadron_report_shield = "Shield",
    defense_squadron_report_total_fleet = "Fleet size",
    defense_squadron_report_total_hull = "total hull",
    defense_squadron_report_total_shield = "total shield",
    defense_squadron_report = "status report",

})