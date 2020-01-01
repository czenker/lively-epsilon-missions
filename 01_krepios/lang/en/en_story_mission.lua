local f = string.format

My.Translator:register("en", {
    story_welcome_1 = function(commanderPerson, colonelPerson)
        return "This is Commander " .. commanderPerson:getFormalName() .. ". \z
        Are you the little greenhorns Colonel " .. colonelPerson:getFormalName() .. " \z
        sent to look after me?"
    end,
    story_welcome_1_response_good = "Yes Sir. We are reporting for duty.",
    story_welcome_1_response_bad = "Hey, we ain't greenhorns!",

    story_welcome_2_good = "Hah. The way you talk, I guess you passed the nerd course at the academy with flying colors. \z
        You better give it up soon. Nobody is interested in your blathering here.",
    story_welcome_2_bad = function(colonelPerson)
        return "For goodness' sake. Of course, you are no greenhorns but crybabies. Better run back to Colonel " ..
        colonelPerson:getFormalName() .. " if got problems with the tone here."
    end,
    story_welcome_2 = function(colonelPerson)
        return "But to get to the point: I do not give a shit whether you're here or not. I don't need you. I did not \z
        request your assistance. Colonel " .. colonelPerson:getFormalName() .. " thought it would be a good idea to send \z
        you here because we are so far out. As if we could not handle it alone."
    end,
    story_welcome_2_response_good = "Maybe we could come in handy after all",
    story_welcome_2_response_bad = function(colonelPerson)
        return "Colonel " .. colonelPerson:getFormalName() .. " probably thought something of it"
    end,

    story_welcome_3_good = "Useful like a brat whining all day? Yes, probably.",
    story_welcome_3_bad = "[sarcastic] Of course, this muckety-muck thought of something. Assessing our situation from \z
        1000u is really a walk in the park.",
    story_welcome_3 = "This old clunker you are flying will not keep you happy for long if you don't whip it into shape. \z
        A few RPs should work wonders. Maybe then I have some use for you.",
    story_welcome_3_response_good = "How can we earn RP?",
    story_welcome_3_response_bad = "Can we lend some RP from you?",

    story_welcome_4_good = "Many are looking for a job here. Most people are miners, but there are a few other tasks, too.",
    story_welcome_4_bad = "We are no charity, missy! People will slit your throat if it can buy them a drink. \z
        You need to work for your RP.",
    story_welcome_4 = "You better check the surrounding mining stations in the asteroid belt. Usually you can find missions \z
        there. And while you are going there load some energy cells and mining machinery - they always got use for those.",
    story_welcome_4_response_good = "OK, we are on our way",
    story_welcome_4_response_bad = "We have one more question",

    story_welcome_5_good = "Yeah. Smart idea.",
    story_welcome_5_bad = "You certainly are a bunch of annoying creeps.",
    story_welcome_5 = "I got an important appointment with my three friends Johnny, Jack and Jimmy at the bar.\n\n\z
        Fuck off! And if you got any trouble... don't ask me.",



    story_mission_visit = function(callSign)
        return "Visit " .. callSign
    end,
    story_mission_visit_success = function(callSign)
        return f("Station %s has been added to your quick dial.", callSign)
    end,



    story_after_first_mission = function(commanderPerson)
        return "So you found out how to earn RP in this sector. Does it mean you want to build a home here or what?\n\n  - " .. commanderPerson:getFormalName()
    end,


    story_drives_available_mission = function(stationCallSign)
        return "Buy a Warp or Jump Drive on " .. stationCallSign
    end,
    story_drives_available = function(colonelPerson, commanderPerson, hqCallSign)
        return "Glad you made it to the Krepios system.\n\n\z
        Try not to despair of " .. commanderPerson:getFormalName() .. ". He is not known for his friendliness towards \z
        visitors and always critical of them. But if you make yourselves useful he might start trusting you.\n\n\z
        I talked to the local upgrade trader on " .. hqCallSign .. " to give you an easier start. \z
        He can install a Jump Drive or Warp Drive for you and settles the bill with me. But you have to decide which \z
        of the two you want. Your ship is not built to have both installed.\n\n\z
        - Colonel " .. colonelPerson:getFormalName()
    end,



    story_laser_refit_award_comms = function(commanderPerson)
        return "It seems you are starting to get along in the sector. \z
        It is common in this sector that miners modify their laser with a software that - lets put it this way - \z
        can not be bought on the free market. \z
        An unknown coder, who calls himself \"H4><><0R\", wrote a script that can be used to have lasers operate outside \z
        their specification to make them more powerful.\n\n\z
        I have sent you the script. Your weapons officer can make use of it and recalibrate your lasers according \z
        to the situation. Maybe it will save your asses in one of the fighting missions sometime.\n\n\z
        And just in case anyone asks: You do not have it from me. Understood?\n\n\z
        - Commander " .. commanderPerson:getFormalName()
    end,



    story_power_presets_award_comms = function(commanderPerson)
        return "Hey greenhorns. \z
        I got something new for you. One of our technicians \"found\" a software upgrade on one of the outer world freighters \z
        and asked me to send it to you. Seems there is at least one person on this station who is not indifferent to you. \n\n\z
        The upgrade should somehow help your engineering officer. I did not listen to her technical gibberish, but she \z
        said it has a manual attached.\n\n\z
        - Commander " .. commanderPerson:getFormalName()
    end,



    story_attack_warning = function(colonelPerson)
        return "Our secret service warned us of mysterious signatures in your sector. Unfortunately we have no idea \z
        what causes them at the moment. Better keep your eyes and sensors open - something is going on here.\n\n\z
        - Colonel " .. colonelPerson:getFormalName()
    end,



    story_attack_detected_1 = function(commanderPerson, playerCallSign)
        return "Commander " .. commanderPerson:getFormalName() .. " calling for " .. playerCallSign .. ".\n\n\z
        We are in deep shit. We got multiple unidentified squadrons in our sector and are heading towards our stations. \z
        I have never seen ships like those, and they do not respond to our radio messages. Their ships are heavily \z
        armed and our scans show that their weapons are unlocked and actively targeting ships in their vicinity."
    end,
    story_attack_detected_1_response = "Unidentified squadrons?",
    story_attack_detected_2 = "Don't ask me. I got no idea where these frigging things come from and I don't want \z
        to know. All I want is to save my own ass and with it as many souls as possible. The more souls we get out \z
        of this sector alive the better chances we have to form a passable defense against this fleet.",
    story_attack_detected_2_response = "What is our role in this?",
    story_attack_detected_3 = function(distance)
        return "Haven't you scumbags been to the military academy! Help us kicking their buts. \n\n\z
        There is an old command post " .. distance .. "u from here. If we are lucky and not everything is rusty there we \z
        might have a chance to get the defenses up again and plan our retaliation there."
    end,
    story_attack_detected_3_response = "OK. We are going to meet you at the command post",
    story_attack_detected_4 = function(fortressCallSign, fortressSector)
        return "Good thing you're helping us.\n\nWe meet on " .. fortressCallSign .. " in sector " ..
        fortressSector .. " for the briefing. Don't bum around and do not even think of facing the enemy with \z
        your trashcan. When you came here your ship was even crappier, but do not forget: You are still flying \z
        a pimped up transport ship, no dreadnought."
    end,
    story_attack_detected_4_response = "No solo attempts. Understood.",
    story_attack_detected_5 = "Don't take too much time.\n\nBut if you could scan some enemy ships from a distance, \z
    it would help us significantly in our defense.",

    story_mission_defend_fortress = function(fortressCallSign)
        return "Defend station " .. fortressCallSign
    end,



    story_mission_plan_defense = function(commanderPerson, fortressCallSign)
        return "Talk to " .. commanderPerson:getFormalName() .. " on " .. fortressCallSign
    end,
    story_mission_plan_defense_hint = function(fortressSectorName)
        return "The station is located in sector " .. fortressSectorName .. "."
    end,
    story_mission_plan_defense_hint2 = function(commanderPerson, fortressSectorName)
        return commanderPerson:getFormalName() .. " is waiting for you on the station in sector " .. fortressSectorName
    end,



    story_mission_plan_defense_arrival = function(commanderPerson, fortressCallSign)
        return commanderPerson:getFormalName() .. " has arrived at station " .. fortressCallSign .. "."
    end,



    story_mission_financial_support_comms = function(colonelPerson, amount)
        return Util.random({
            f("Here, take %0.2fRP as support to fight the unknown enemies.", amount),
            f("Hopefully these %0.2fRP help you in the fight against the unknown enemy.", amount),
            f("I have sent you %0.2fRP to upgrade your ship.", amount),
            f("I send you %0.2fRP from our war funds.", amount),
            f("Unluckily we do not have a worm hole to send you support. But I hope these %0.2fRP help you.", amount),
        }) .. " " .. Util.random({
            "Try to spend them wisely.",
            "Show them to not mess with the Human Navy.",
            "Defend the sector of this enemy.",
            "Buy a reasonable upgrade with this money.",
        }) .. "\n\n- Colonel " .. colonelPerson:getFormalName()
    end,
    story_mission_financial_support_hint = function(amount)
        return f("%0.2fRP received", amount)
    end,



    story_mission_scan_enemies = "Scan enemy ships",
    story_mission_scan_enemies_hint = function(shipNumberRemaining)
        if shipNumberRemaining == 1 then
            return "one more ship"
        else
            return shipNumberRemaining .. " more ships"
        end
    end,



    story_defense_briefing_label = function(commanderPerson)
        return "Talk to " .. commanderPerson:getFormalName()
    end,
    story_defense_briefing_not_docked = function(commanderPerson, fortressCallSign)
        return "Commander " .. commanderPerson:getFormalName() .. " is waiting for you in the conference office on " ..
        fortressCallSign .. ".\n\nPlease arrive there to assess the current situation. Unfortunately the systems for \z
        encrypted messaging are not operational yet."
    end,
    story_defense_briefing_1 = function(playerCallSign)
        return "Aaah, the crew of " .. playerCallSign .. ".\n\nYou finally made it. Let's start then. \n\n\z
        As you see, the station is not yet fully operational again. We still got issues with the reactors and the shields, \z
        but at least life support and our scanners are back online."
    end,
    story_defense_briefing_1_response = "OK",
    story_defense_briefing_2 = function(colonelPerson)
        return "We still do not know who we are dealing with, but it is obvious they want to eliminate us. If we want to \z
        survive we got to destroy their fleets.\n\nBy now I am glad that Colonel " .. colonelPerson:getFormalName() ..
        " sent you to Krepios. We would not stand a chance without your strategic knowledge."
    end,
    story_defense_briefing_2_response = "Those are unfamiliar friendly words of you.",
    story_defense_briefing_2 = function()
        return "As you know, our fighting force on Krepios is rather weak, but we still have some experience fighter pilots \z
        from the Terran Wars who might support you. But we can only man one squadron. You have to decide which one it will be: \n\n\z
        1. An artillery frigate with a small fighting force. It uses Homing Missiles to attack and is accompanied by \z
        fighters.\n\z
        2. A squadron of gunboats. These ships are relying on their lasers in a fight.\n\n\z
        Which ships should we man??"
    end,
    story_defense_briefing_2_response_artillery = "Man the artillery frigate and the fighters!",
    story_defense_briefing_2_response_gunship = "Man the gunboats!",

    story_defense_briefing_3_artillery = "OK, the pilots are on their way to the hangar and prepare the artillery frigate for takeoff.",
    story_defense_briefing_3_gunships = "OK, the pilots are on their way to the hangar and prepare the gunboats for takeoff.",
    story_defense_briefing_3 = function(playerCallSign)
        return "And one last thing: We have some technicians on the station.\n\nThey will try to dismantle upgrades \z
        from the arriving ships for your use. We call when we find something that could be installed on " ..
        playerCallSign .. ".\n\n\z
        They can also install certain improvements on the station and produce missiles. You just need to tell them what \z
        you need."
    end,


    story_hq_destroyed = function(commanderPerson)
        return "My stamp collection!! Those bastards destroyed our headquarters!!\n\nGive them a proper kick in their \z
        ass. And in case they do not have one - somewhere else where it hurts\n\nBlow them out of space. And then riddle \z
        them with bullet. Into small pieces. Very small pieces.\n\n- " .. commanderPerson:getFormalName()
    end,



    story_all_destroyed = function(commanderPerson)
        return "We are the last survivors in this sector.\n\nOur revenge could not be anything less than their total \z
        destruction.  - " .. commanderPerson:getFormalName()
    end,



    story_evacuation_order_1 = function(colonelPerson, playerCallSign, fortressCallSign, wormholeSectorName)
        return "Colonel " .. colonelPerson:getFormalName() .. " for the crew on " .. playerCallSign .. "\n\nThe \z
        enemy is heading towards " .. fortressCallSign .. ". I did not send you to the Krepios system to die. \z
        There is a worm hole in sector " .. wormholeSectorName .. ", close to the planet, that can bring you back to base.\n\n\z
        You are hereby relieved of your command to defend the sector. Use the worm hole as fast as possible and do \z
        not take any unnecessary risks. I need you alive!"
    end,
    story_evacuation_order_1_response_heroic = "We stay here and defend the sector",
    story_evacuation_order_1_response_neutral = "No unnecessary risks. Understood.",
    story_evacuation_order_1_response_coward = "We are on our way",

    story_evacuation_order_2_heroic = function(playerCallSign)
        return "I appreciate your courage, " .. playerCallSign .. ", but I have no use for you dead.\n\nDo not overestimate yourselves and come back alive."
    end,
    story_evacuation_order_2_neutral = function(playerCallSign)
        return "Agreed.\n\nI trust your knowledge of your ship, " .. playerCallSign .. ". Bring it back in one piece."
    end,
    story_evacuation_order_2_coward = "Very good, I am anticipating your return to the headquarters.",
    story_evacuation_order_2 = "We have no idea who the aggressors are. So we need to form a potent response fleet as soon as possible.",



    story_mission_evacuate = "Use the worm hole close to Krepios to evacuate",
    story_mission_evacuate_hint = function(wormholeSectorName)
        return "The worm hole is in sector " .. wormholeSectorName
    end,



    story_mission_debrief = "Use the worm hole close to Krepios to return to the headquarter.",
    story_mission_debrief_hint = function(wormholeSectorName)
        return "The worm hole is in sector " .. wormholeSectorName
    end,

    story_mission_debrief_1 = function(commanderPerson)
        return "You have made the impossible happen! We do not see any more enemy fleets on our scanners. \z
        Today is a day to celebrate indeed. Your mission on Krepios is finished - please use the wormhole to meet up \z
        with me.\n\n\z- " .. commanderPerson:getFormalName()
    end,



    story_final_evacuation_order_1 = function(playerCallSign, commanderPerson)
        return "Listen, " .. playerCallSign .. ". Return to the headquarters immediately. This is an order!\n\n\z
        Commander " .. commanderPerson:getFormalName() .. " let his life in the sector and don't want your crew to \z
        follow him. Our best strategy is to gather our forces and form a veritable retaliation fleet.\n\nFly to \z
        worm hole close to Krepios and pass it."
    end,
    story_final_evacuation_order_1_response_heroic = "We stay and fight for the death",
    story_final_evacuation_order_1_response_coward = "We are on our way",
    story_final_evacuation_order_2_heroic = function(playerCallSign, colonelPerson)
        return "That's insanity! You don't stand a ghost of a chance with your transport ship against their combat ships.\n\n\z
        Be reasonable and pass the worm hole, " .. playerCallSign .. ".\n\nColonel " .. colonelPerson:getFormalName() .. " over."
    end,
    story_final_evacuation_order_2_coward = function(commanderPerson, colonelPerson)
        return "Today is a sad day for us. Not only did we lose a sector, but also the life of " ..
        commanderPerson:getFormalName() .. ". Let us hope that at least you make it out of the sector alive.\n\n\z
        Colonel " .. colonelPerson:getFormalName() .. " over."
    end,

    story_final_evacuation_debrief_survivors = function(playerCallSign, commanderPerson)
        return "I'm happy to hear you are back from Krepios, " .. playerCallSign .. ". Thanks to your courageous efforts \z
        the enemy could be driven out of Krepios in the last second.\n\n\z
        Unfortunately our fellow soldier " .. commanderPerson:getFormalName() .. " had to give his life. But he did so \z
        on the side of countless civilians that he tried to protect until the last moment. I will award him a Medal of Honor \z
        posthumous.\n\n\z
        You are also invited to the festivity and will be awarded for your bravery on Krepios.\n\n\z
        Dismissed, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_heroic = function(playerCallSign, commanderPerson)
        return "The whole station is in a tizzy because of your return. They are waiting for your heroic stories you \z
        are going to tell about how you saved the sector Krepios from certain distinction by an unknown enemy force.\n\n\z
        However, the end of the sector is sealed. Reconstructing the sector will not be worth the effort. " ..
        commanderPerson:getFormalName() .. " will organize the final evacuation of the sector. Many citizens are looking \z
        into an uncertain future.\n\n\z
        But today is a day of celebration. Thanks to your heroic bravery many civilians will see another day. You earned \z
        a medal for that. I will award it to you this evening - but only after you've rested and got dressed.\n\n\z
        Dismissed, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_lost = function(playerCallSign, commanderPerson)
        return "Today is a sad day for the Human Navy. We lost a sector Krepios to an unknown enemy force. Many \z
        civilians and " .. commanderPerson:getFormalName() .. " lost their lives in the sector. \z
        All the more I'm glad that at least you made it back alive. We will need every crew when we face our unknown enemy. \z
        You have showed that they are vulnerable and with your experience we might be successful in a fight against them.\n\n\z
        But your duty is finished for today. We closed the worm hole behind you to avoid an immediate threat. Rest well \z
        and meet me tomorrow in my office.\n\n\z
        Dismissed, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_unclear = function(playerCallSign, commanderPerson)
        return "Lucky you made it out for Krepios alive. You are the last ship that could fleet from the sector. The \z
        worm hole got unstable after you flew through and is impassable now. Sadly we did not hear any messages from the \z
        sector since. We are expecting the worst, but we are not giving up hope. Maybe " ..
        commanderPerson:getFormalName() .. " is still alive.\n\n\z
        We will form a fleet to face the unknown enemy and search for survivors. If you want you can participate in that \z
        expedition. But you should take a rest for now. We prepared a quarter for you that you can use for the next days. \z
        Meet me tomorrow in my office when you have rested.\n\n\z
        Dismissed, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_ok = "Yes, Colonel."

})