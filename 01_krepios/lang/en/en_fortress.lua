local f = string.format

My.Translator:register("en", {

    fortress_station_initial_description = "This station once served as a space port for the construction of space ships and smaller stations. It ceased operations more than 10 years ago.",
    fortress_station_manned_description = "This former space port now serves as a center for defending the sector against unknown attackers.",
    fortress_hail_initial_docked = "The inside is shrouded in darkness. At first glance it is clear that the station has been abandoned for years. The hull seems to be intact, even though there is a lot of flaking paint and some rust spots inside.",

    fortress_hail_manned = function(commanderPerson)
        return commanderPerson:getFormalName() .. " is waiting for you in the briefing room. Please come to the station as soon as possible."
    end,
    fortress_hail_manned_docked = function(playerCallSign)
        return "Finally, you made it, " .. playerCallSign .. ". The commander is already waiting for you in the meeting room.\n\nGo down the hall and turn right at the intersection.  And don't bump your head against the pipes hanging from the ceiling. We haven't gotten the lights back under control everywhere yet."
    end,

    fortress_hail_defense_enemies_close = "There is an enemy fleet on our radar.",
    fortress_hail_defense_attacked = function(isPlayerClose)
        if isPlayerClose then
            return "Damn it - the ships are here, attacking the station. Let's hope we see the next day."
        else
            return "We're being attacked by enemy ships. Help us or we are lost."
        end
    end,
    fortress_hail_defense_docked = function(fortressCallSign, isRepairing)
        local msg = "Welcome to " .. fortressCallSign .. "."
        if isRepairing then
            msg = msg .. " Our technicians are already taking care of your ship."
        end
        msg = msg .. "\n\nWhat else can we help you with?"
        return msg
    end,
    fortress_hail_defense = "The calm before the storm is the worst.",

    fortress_hail_victory = function(playerCallSign)
        return "Wow, " .. playerCallSign .. ". You saved us.\n\nThe commander opened a case of booze in the bar. Why don't you come by and have a drink?"
    end,



    fortress_improvement_hint = "Our technicians are out of work right now. What should they do next?",
    fortress_improvement_progress = function(improvementName)
        return "Our technical teams are currently working on the following: " .. improvementName .. "."
    end,
    fortress_improvement_label = "Give technicians a task",
    fortress_improvement_what_next = "What should we do next?",
    fortress_improvement_confirmation = "We'll get to work right away.",



    fortress_improvement_homing_name = function(amount)
        return f("Produce %d homing missiles", amount)
    end,
    fortress_improvement_homing_confirmation = "We'll try to find unused missiles at the station.",
    fortress_improvement_homing_completion = "Our engineers found some homing missiles and brought them to the storage area.",

    fortress_improvement_hvli_name = function(amount)
        return f("Produce %d HVLI missiles", amount)
    end,
    fortress_improvement_hvli_confirmation = "Our technicians are getting to work. Hopefully we will still find some old HVLIs in the hangars.",
    fortress_improvement_hvli_completion = "We found some working HVLIs and brought them to the storage area.",

    fortress_improvement_mine_name = function(amount)
        return f("Produce %d mines", amount)
    end,
    fortress_improvement_mine_confirmation = "Our technicians have already found explosives. They will now work hard to build mines from it.",
    fortress_improvement_mine_completion = "We've made mines as requested.",

    fortress_improvement_emp_name = function(amount)
        return f("Produce %d EMP missiles", amount)
    end,
    fortress_improvement_emp_confirmation = "We have energy problems, but we will try to build EMPs.",
    fortress_improvement_emp_completion = "The ordered EMPs were manufactured and added to the storage.",

    fortress_improvement_nuke_name = "Produce a nuke",
    fortress_improvement_nuke_confirmation = "If we want to oppose the enemy, we cannot rely on conventional weapons. Our engineers do their best to produce a nuke.",
    fortress_improvement_nuke_completion = "Our engineers crafted a nuke.",

    fortress_improvement_scanProbe_name = function(amount)
        return f("Produce %d Scan Probes", amount)
    end,
    fortress_improvement_scanProbe_confirmation = "Knowledge is power on the battlefield. With scan probes we have an edge on intelligence and can monitor enemies from a distance.",
    fortress_improvement_scanProbe_completion = "We have created the Scan Probes as requested.",

    fortress_improvement_nanobot_name = function(amount)
        return f("Produce %d Nanobots", amount)
    end,
    fortress_improvement_nanobot_confirmation = "Nanobots could prolong your survival against our foes. And survival is all we are hoping for.",
    fortress_improvement_nanobot_completion = "We have created a batch of nanobots for your ship.",

    fortress_improvement_repair_name = "get the repair dock going",
    fortress_improvement_repair_confirmation = "Our technicians will try to get the repair dock working again.",
    fortress_improvement_repair_completion = "The repair dock was set into operation. We are now able to repair the hull of your ship should the circumstances require.",

    fortress_improvement_shield_name = "restore shields",
    fortress_improvement_shield_confirmation = "OK, let's see if we can get the shields back on at this station. Keep your fingers crossed.",
    fortress_improvement_shield_completion = "We've reactivated the station's shields. They are still far away from their maximum performance, but at least we are not completely defenseless anymore.",

    fortress_improvement_shield2_name = "improve shields",
    fortress_improvement_shield2_confirmation = "We'll try to get more power on the shields. This could be turn out to be quite tricky.",
    fortress_improvement_shield2_completion = "We were able to reinforce the station's shields with a few tricks.",

    fortress_improvement_artillery_name = "Prepare artillery frigate for deployment",
    fortress_improvement_artillery_confirmation = "We will prepare the artillery frigate and two fighter ships for the pilots.",
    fortress_improvement_artillery_completion = "We've deployed an artillery frigate and two fighter ships operational. You can now control them.",

    fortress_improvement_gunships_name = "prepare gunship squad for deployment",
    fortress_improvement_gunships_confirmation = "We'll prepare the gunships for the pilots.",
    fortress_improvement_gunships_completion = "We've made the gunships ready for action. You can now control them.",



    fortress_upgrade_available = function(fortressCallSign, upgradeName, upgradePrice)
        return  Util.random({
            "We have the upgrade  " .. upgradeName .. "  in stock now.",
            "We can offer to install the upgrade  " .. upgradeName .. "  on your ship.",
            "Are you interested in an upgrade?  " .. upgradeName .. "?",
            "Does  " .. upgradeName .. "  sound like an upgrade you would be interested in?",
            "Good news: Come to " .. fortressCallSign .. " for the upgrade  " .. upgradeName .. ".",
        }) .. "\n\n" ..
        Util.random({
            "One of our technicians was able to recover it from an old ship.",
            "It was supposedly forgotten on the station.",
            "A weird pacifist genius with a brown leather jacket was able to repair it with some wire and a ball pen. Nobody knows how he did it, but it seems to work again.",
            "Originally this part was not made for combat, but we do not have a choice, do we?",
            "We found that part in a storage area a small " .. Util.random({"boy", "girl"}) .. " found while playing.",
            "We found a workshop behind an electric door. Unbelievable how much spare parts we found there.",
            "Space junk is not always plainly junk. Sometimes you get something useful out of it.",
        }) .. " " ..
        Util.random({
            f("We can install the upgrade for %.2fRP.", upgradePrice),
            f("Come to " .. fortressCallSign .. " and I can this upgrade for %.2fRP.", upgradePrice),
            f("Give me %.2fRP and I can install this with minimal work.", upgradePrice),
            f("If you got %.2fRP, the upgrade will be yours.", upgradePrice),
        })
    end,


    fortress_intel_label = "enemy report",
    fortress_intel_menu_no_known_fleets = "We are not aware of any enemy fleets.",
    fortress_intel_menu_no_valid_fleets = "All enemy fleets have been destroyed.",
    fortress_intel_menu_number_of_fleets = function(number)
        if number == 1 then
            return "There is one more enemy fleet that needs to be destroyed."
        else
            return number .. " enemy fleets are a threat to this sector."
        end
    end,
    fortress_intel_distance_close = function(closestFleetId)
        return f("We are currently attacked by fleet %d taking damage.", closestFleetId)
    end,
    fortress_intel_distance = function(distanceInU, closestFleetId)
        return f("The closest enemy fleet is fleet %d. Their current location is about %du from our position.", closestFleetId, distanceInU)
    end,
    fortress_intel_detail_button = function(number)
        return "fleet " .. number
    end,
    fortress_intel_detail_type_unknown = "unknown",
    fortress_intel_detail_info = function(sectorName, distanceInU)
        return f("The fleet is in sector %s about %du from our station.", sectorName, distanceInU)
    end,
    fortress_intel_detail_info_detailed = function(sectorName, distanceInU, durationInMin)
        return f("The fleet is in sector %s about %du from our station and is able to reach us in about %d minutes.", sectorName, distanceInU, durationInMin)
    end,
    fortress_intel_detail_weapons_detail = "According to our calculations the fleet should have stocked these missiles",
    fortress_intel_detail_weapons = "Our estimations on the fleet's missiles are",
    fortress_intel_detail_weapons_full = "fully stocked",
    fortress_intel_detail_weapons_high = "almost full",
    fortress_intel_detail_weapons_half = "about filled halfway",
    fortress_intel_detail_weapons_low = "almost empty",
    fortress_intel_detail_weapons_empty = "empty",
    fortress_intel_detail_number_of_ships = function(number)
        if number == 1 then
            return "The fleet consists of one ship."
        else
            return f("The fleet consists of %d ships.", number)
        end
    end,
    fortress_intel_detail_scan_hint = "We have no further information on the fleet. If you manage to scan more ships of the fleet, we can give more detailed information.",



})