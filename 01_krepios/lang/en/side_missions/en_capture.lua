local f = string.format

My.Translator:register("en", {
    side_mission_capture = function(criminalPerson)
        return "Bounty " .. criminalPerson:getFormalName()
    end,
    side_mission_capture_description = function(criminalPerson, companionsNr, sectorName, payment)
        local HeShe, heShe
        if Person:hasTags(criminalPerson) and criminalPerson:hasTag("male") then
            HeShe = "He"
            heShe = "he"
        else
            HeShe = "She"
            heShe = "she"
        end

        local companionDescription
        if companionsNr == 0 then
            companionDescription = HeShe .. " " .. f("was seen in sector %s recently", sectorName)
        elseif companionsNr == 1 then
            companionDescription = f("%s was seen in sector %s last time with a companion.", HeShe, sectorName)
        else
            companionDescription = HeShe .. " " .. f("was seen in sector %s with an escort recently.", sectorName)
        end

        return f("We are requesting your aid in the capture of %s.", criminalPerson:getFormalName()) .. " " .. heShe .. " is wanted for " .. Util.random({
            "misappropriation of corporate property",
            "taking part in a non-approved strike",
            "blackmailing of superiors",
            "offense to an immediate superior",
            "membership in a workers union",
            "contempt of direct orders",
            "misconduct of security guidelines",
            "defiance of break times",
            "unauthorized stay in a high security area",
        }) .. " by us. " .. companionDescription .. " " .. f("The capture and transfer into our custody is rewarded with %0.2fRP.", payment)
    end,
    side_mission_capture_accept = "You are doing the corporation a big service by making an example and helping us to bring this slum back to order.",
    side_mission_capture_pod_description = function(criminalPerson)
        return "The rescue capsule of " .. criminalPerson:getFormalName()
    end,
    side_mission_capture_ship_description = function(captainPerson)
        return "Ship of " .. captainPerson:getFormalName() .. ". Wanted by the SMC."
    end,
    side_mission_capture_companion_description = function(captainPerson, criminalPerson)
        local HeShe
        if captainPerson:hasTag("male") then
            HeShe = "He"
        else
            HeShe = "She"
        end

        return f(
            "This ship is flown by %s. %s is %s of %s.",
            captainPerson:getFormalName(),
            HeShe,
            Util.random({
                "a colleague",
                "a friend from old days",
                "a former classmate",
                "a cousin",
                "a roommate",
                "a friend",
            }),
            criminalPerson:getFormalName()
        )
    end,
    side_mission_capture_too_close = "You are too close to the target area to start the mission.",
    side_mission_capture_start_hint = function(criminalPerson, sectorName)
        return f("Find %s in sector %s", criminalPerson:getFormalName(), sectorName)
    end,
    side_mission_capture_approach_comms = function(criminalPerson, companionsNr)
        local description = f("You should see the %s on your radar now. You need to destroy %s ship and salvage %s rescue capsule.",
                Util.random({
                    "traitor",
                    "criminal",
                }),
                criminalPerson:hasTag("male") and "his" or "her",
                criminalPerson:hasTag("male") and "his" or "her"
        )
        if companionsNr > 0 then
            description = description .. " " .. f(
                    "%s is in company of an escort that will defend %s to death. These collaborators are of no interest to us and you are free to blow them out of the ether.",
                    criminalPerson:getFormalName(),
                    criminalPerson:hasTag("male") and "him" or "her"
            )
        end

        return description
    end,
    side_mission_capture_approach_hint = function(shipCallSign, criminalPerson)
        return f("Destroy %s to salvage %s's rescue capsule", shipCallSign, criminalPerson:getFormalName())
    end,
    side_mission_capture_bearer_destruction_comms = "You are in trouble now.",
    side_mission_capture_bearer_destruction_hint = function(criminalPerson, sectorName)
        return f("Salvage the rescue capsule of %s in sector %s", criminalPerson:getFormalName(), sectorName)
    end,

    side_mission_capture_item_destruction_comms = function(criminalPerson)
        return f("The rescue capsule of %s was destroyed. We won't reproach you, but we hope you understand that we will deny any involvement into this incident. Therefore, we can not offer you any payment.\n\nWe herby consider our agreement terminated.", criminalPerson:getFormalName())
    end,
    side_mission_capture_pickup_hint = function(stationCallSign)
        return f("Please dock with station %s", stationCallSign)
    end,
    side_mission_capture_success_comms = function(criminalPerson, payment)
        return "We are very grateful for your help in capturing the " .. Util.random({
            "traitor",
            "criminal",
        }) .. " " .. criminalPerson:getFormalName() .. ". " .. (criminalPerson:hasTag("male") and "He" or "She") .. " won't be able to breath the air of freedom all too soon. " .. f("As by our contract, you are receiving %0.2fRP for your help.", payment)
    end,
})