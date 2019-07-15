local f = string.format

My.Translator:register("en", {
    side_mission_repair = "technician is called",
    side_mission_repair_description = function(captainPerson, fromCallSign, toCallSign, crewCount, payment)
        return Util.random({
            f("Hey, my name is %s, captain of a spaceship", captainPerson:getFormalName())
        }) .. ".\n\nBecause of " .. Util.random({
            "a short circuit in the energy distributor",
            "an overcharged reactor",
            "a loss of coolant fluid",
        }) .. ", the majority of my systems have stopped working. " .. Util.random({
            "I need professional help for the repairs",
            "I am not able to fix this fault on my own",
            "I have no idea how to repair a ship and need your help",
            "Managing this kind of damage exceeds my technical knowledge",
        }) .. ". " .. Util.random({
            f("I got stuck on my flight from %s to %s.", fromCallSign, toCallSign),
            f("The problem occurred on my way from %s to %s.", fromCallSign, toCallSign),
            f("Originally, I was expecting a quiet flight from %s to %s but then crap like this happens.", fromCallSign, toCallSign),
            f("It was not long after I undocked %s when I noticed the problem. Now I won't be able to make it to %s.", fromCallSign, toCallSign),
        }) .. "\n\n" .. Util.random({
            f("Can you lend me %d of your technicians?", crewCount),
            f("With the support of %d of your technicians I'm sure to fix the problem.", crewCount),
            f("Could you dispense of %d of your technicians to support me?", crewCount),
        }) .. " " .. Util.random({
            f("I would pay %0.2fRP for your help.", payment),
            f("I can reward your help with %0.2fRP.", payment),
            f("Once the issue is solved your technicians can return and I'll add another %0.2fRP.", payment),
            f("How about %0.2fRP?", payment),
        })
    end,
    side_mission_repair_small_crew = "Erm, your crew looks quite puny. I think I will look for someone else.",
    side_mission_repair_accept = function()
        return Util.random({
            "Excellent",
            "Marvelous",
            "Great",
        }) .. ". " .. Util.random({
            "Meet me at the rendezvous point",
            "Let's meet on my ship",
        }) .. ". " .. Util.random({
            "I, erm... I am waiting here for you.",
            "Don't fret. I'm not flying away.",
            "I will just stay here and wait for you - of necessity.",
        })
    end,
    side_mission_repair_start_hint = function(callSign, sectorName)
        return f("Fly close to %s in sector %s. Your engineer can then send the crew.", callSign, sectorName)
    end,
    side_mission_repair_hail = function()
        return Util.random({
            "You have the technicians to solve my problem on board?",
            "You brought the technicians to fix my problem?",
            "Ah, you have the technicians on board",
        }) .. " Please fly " .. Util.random({
            "closer than 1u",
            "very close",
        }) .. " to my ship so your engineer can send the " .. Util.random({"colleagues", "technicians", "engineers", "repair crew"}) .. "."
    end,


    side_mission_repair_send_crew_label = function(crewCount)
        return f("Send %d technicians", crewCount)
    end,
    side_mission_repair_send_crew_failure = function(crewCount)
        return f("Your crew is too small. At least %d technicians are needed.", crewCount)
    end,

    side_mission_repair_crew_arrived_comms = function()
        return Util.random({
            "Great. The technicians are all on board.",
            "Excellent. The technicians have just arrived.",
            "Thank you. The technicians are here.",
        }) .. "\n\n" .. Util.random({
            "But I don't understand why they immediately went into my storage rooms.",
            "Somehow they went to my storage rooms very determined. I don't understand that, but I'm no expert.",
            "They went into the storage room for an \"inspection\" as they said.",
        }) .. " However... " .. Util.random({
            "I inform you as soon as the work is done",
            "I will call you then the problem is fixed",
            "I will contact you when all is done",
        }) .. ". " .. Util.random({
            "This could take multiple minutes.",
            "It could take a good while.",
        })
    end,
    side_mission_repair_crew_arrived_hint = function(callSign)
        return f("Wait for the repairs on %s to be finished. This could take multiple minutes. ", callSign)
    end,
    side_mission_repair_crew_ready_comms = function(captainPerson, stationCallSign)
        return Util.random({
            f("This is %s again.", captainPerson:getFormalName()),
            f("It is me again, Captain %s.", captainPerson:getFormalName()),
        }) .. "\n\n" .. Util.random({
            "Your repair crew did a marvelous job",
            "You have a very skilled crew",
        }) .. " - " .. Util.random({
            "my ship is fully functional again",
            "all systems are up and running again",
            "my old ship is as good as new",
            "they solved all the problems",
        }) .. ". " .. Util.random({
            f("I am continuing my flight to %s", stationCallSign),
            f("I am heading to %s, as I originally planned", stationCallSign),
            f("The station %s will be happy that I am heading there again", stationCallSign),
        }) .. ". " .. Util.random({
            "Meet me on my way",
            "Intercept me on the way there",
        }) .. " or " .. Util.random({
            "meet me at the station",
            "meet me there",
            "I will wait for you at the station"
        }) .. ". " .. Util.random({
            "But please hurry",
            "Don't take too much time",
        }) .. ", because " .. Util.random({
            "I'm running short on alcohol",
            "my moonshine is running out soon",
            "my alcohol supplies are almost exhausted"
        }) .. " and I " .. Util.random({"fear", "suspect"}) .. " the mood on board could swing any moment."
    end,

    side_mission_repair_crew_ready_hint = function(callSign, stationCallSign)
        return f("Pick your crew up from %s. The ship is heading towards %s.", callSign, stationCallSign)
    end,
    side_mission_repair_crew_returned_hail = function()
        return Util.random({
            "Thanks again for your help",
            "Your repair crew did a great job",
        }) .. ". " .. Util.random({
            "The ship is running as smoothly as never before"
        }) .. "."
    end,
    side_mission_repair_crew_returned_comms = function(payment)
        return Util.random({
            "Your technicians did an amazing job",
            "You got a fine crew there",
        }) .. ". " .. Util.random({
            f("I transferred you the %0.2fRP as promised.", payment),
        })
    end,
    side_mission_repair_failure_comms_crew_lost = "The ship that you lent your repair crew to has vanished from our scanners. We don't expect your crew to appear again. I know this is hard to take, but this is live out here. Life and death aren't very far apart.",
    side_mission_repair_failure_comms = "The ship that your crew was working on has disappeared. It is lost forever.",


    side_mission_repair_comms_label = "How are the repairs going?",
    side_mission_repair_comms_1 = "I appreciate the trust you have in your repair crew, but they have just arrived. Not much happened yet.",
    side_mission_repair_comms_2 = "I showed the problem to your technicians and I got the impression they understood what has to be done. They are taking a break now and took some alcohol from my storage they are going to fix the problem.",
    side_mission_repair_comms_3 = "Your repair crew is busy working and drinking moonshine. But I, as a layperson, can not tell what is going on. The repair will still take a considerable amount of time, I fear.",
    side_mission_repair_comms_4 = "Fixing the issue is quite cumbersome. I think your technicians found the cause for the problem, but they are drinking most of the time. But it looks as if half of the work was done.",
    side_mission_repair_comms_5 = "The most important systems are up and running again. Your repair crew is doing good progress - and sometimes a break in the storage.",
    side_mission_repair_comms_6 = "Most of the issues are fixed. Some lights are flickering every now and then, but the ship is mostly operational again. Your crew is celebrating in the storage room - so I think they are finished soon.",
    side_mission_repair_comms_7 = "Everything is green again. Your repair crew is cleaning up and clink glasses of moonshine. They should be finished any moment.",
    side_mission_repair_comms_completed = function(stationCallSign)
        return f("Your repair crew did a great job of repairing the ship. All systems are fully operational again.\n\nYou can pick them up anytime.\n\nI am on my way to station %s. Fly close to my ship and your engineer can pick up your crew.", stationCallSign)
    end,

    side_mission_repair_return_crew_label = function(crewCount)
        return f("Pick up %d technicians", crewCount)
    end,

    side_mission_repair_ship_description = "A ship with an old manufacturing year",
    side_mission_repair_ship_description_broken = "It seems to be immobile.",
    side_mission_repair_ship_description_extended = "Scans show an increased concentration of ethanol in the storage area.",
    side_mission_repair_ship_description_crew = "Spirits on board seem high, though there are other spirits on board that are in decline.",
    side_mission_repair_ship_description_repaired = "The systems got a makeover recently.",
})