local f = string.format
local t = My.Translator.translate

My.Translator:register("en", {
    side_mission_disable_ship = function(sectorName)
        return f("Intercept ship in sector %s", sectorName)
    end,
    side_mission_disable_ship_description = function()
        return Util.random({
            "Compared to other ships in this sector this ship is rather modern and is considered one of the fastest ships around.",
            "Uncommon signatures from the impulse drive suggest that the impulse drive has been tinkered with.",
        })
    end,
    side_mission_disable_ship_briefing = function(sectorName, minPayment, maxBonus, shipCallSign, clientPerson, thiefPerson)
        return Util.random({
            "Have you seen that?",
            "You came here just in time.",
            "Great that you contact me right now.",
        }) .. " " .. t("comms_generic_introduction", clientPerson) .. " " .. Util.random({
            "That thief " .. thiefPerson:getFormalName() .. " stole my space ship right in front my eyes.",
            "I have only briefly been " .. Util.random({
                "to the toilet",
                "at the marketplace",
                "in the gambling hall",
                "at the merchant",
                "at the customs office",
            }) .. " and when I returned to the hangar my ship was stolen by " .. thiefPerson:getFormalName() .. ".",
            thiefPerson:getFormalName() .. " robbed my space ship from me with a drawn blaster.",
        }) .. " " .. Util.random({
            (thiefPerson:hasTag("male") and "He" or "She") .. " is somewhere in sector " .. sectorName .. " now.",
            (thiefPerson:hasTag("male") and "He" or "She") .. " set course towards sector " .. sectorName .. ".",
        }) .. "\n\n" .. Util.random({
            f("You have to get my space ship %s back for me.", shipCallSign),
            f("Without my space ship %s I'm not able to leave this station. You have to bring it back!", shipCallSign),
        }) .. " " .. Util.random({
            f("Once you returned my ship I will pay you %0.2fRP - plus a bonus of up to %0.2fRP if you bring it back unscathed.", minPayment, maxBonus),
            f("Return my ship and I will reward you %0.2fRP. But try not to hit anything other than the drives or I can not pay you the bonus of %0.2fRP in full.", minPayment, maxBonus),
        })
    end,
    side_mission_disable_ship_accept = "Please, do not destroy my ship. Aim at the drive and try not to damage the hull too much.",
    side_mission_disable_ship_comms_too_close = "You are too close to the target area to start the mission.",
    side_mission_disable_ship_start_hint = function(shipName, sectorName)
        return f("Find the ship %s in sector %s.", shipName, sectorName)
    end,
    side_mission_disable_ship_approach_hint = function(shipCallSign, sectorName)
        return f("Damage the impulse drive of %s in sector %s.", shipCallSign, sectorName)
    end,
    side_mission_disable_ship_approach_comms = function(thiefPerson, shipName)
        return Util.random({
            "Haha, are you here to catch the ship?",
        }) .. " " .. Util.random({
            "You are not seriously thinking I will return it voluntarily.",
            "I doubt you will be able to do that.",
            "Have fun trying it. You won't be able to get me.",
            "But with your small tin can you have not chance.",
        }) .. " " .. Util.random({
            f("%s is the fastest ship in the whole sector.", shipName),
            f("I will be gone before you even blink."),
            f("As soon as I charge the drive to full power, you won't see anything other of me than a cloud of plasma."),
        }) .. "\n\n- " .. thiefPerson:getFormalName()
    end,

    side_mission_disable_ship_taunt_hail1 = "What's up? You are annoying.",
    side_mission_disable_ship_taunt_player_says = "Return the stolen ship immediately.",
    side_mission_disable_ship_taunt_response = function(shipCallSign)
        return Util.random({
            "You are not seriously thinking I will return it voluntarily.",
            "I doubt you will be able to do that.",
            "Have fun trying it. You won't be able to get me.",
            "But with your small tin can you have not chance.",
        }) .. " " .. Util.random({
            f("%s is the fastest ship in the whole sector.", shipName),
            f("I will be gone before you even blink."),
            f("As soon as I charge the drive to full power, you won't see anything other of me than a cloud of plasma."),
        })
    end,
    side_mission_disable_ship_taunt_hail2 = "Catch me if you can.",

    side_mission_disable_ship_surrender_comms = function(shipCallSign, playerCallSign, thiefPerson, stationCallSign)
        return Util.random({
            "OK, OK. I give up!",
            f("Stop shooting at me, %s. I give up!", playerCallSign)
        }) .. "\n\n" .. Util.random({
            f("I have activated the auto pilot and \"%s\" will return to %s.", shipCallSign, stationCallSign),
            f("I have programmed %s as target for the autopilot. \"%s\" will return there automatically.", stationCallSign, shipCallSign)
        }) .. "\n\n- " .. thiefPerson:getFormalName()
    end,

    side_mission_disable_ship_destruction_comms = function(shipCallSign, clientPerson)
        return Util.random({
            "Oh!! You slobs!!! You destroyed my ship?",
            "Have you taken leave of your senses?? You destroyed my ship!",
            "Don't tell me that was my ship that caused that big explosion!?",
        }) .. " " .. Util.random({
            "You were supposed to aim for the drives, not destroy the ship!",
        }) .. " " .. Util.random({
            f("I hope you do not expect me to pay you for the destruction of \"%s\".", shipCallSign),
            f("Obviously you did not understand your mission. Our contract is hereby canceled."),
        }) .. "\n\n- " .. clientPerson:getFormalName()
    end,

    side_mission_disable_ship_success_comms = function(shipCallSign, person, payment)
        return Util.random({
            f("Good job. \"%s\" is on its way back to me.", shipCallSign),
            f("You caught my ship? Thanks a ton!"),
            f("The auto pilot shows that \"%s\" is on its way back. Thanks.", shipCallSign),
        }) .. " " .. Util.random({
            f("As I need to take the repair costs from your bonus, you are receiving a payment of %0.2fRP. That's still not bad, right?", payment),
            f("Unluckily I need to deduct the repair costs for the ship's hull from your bonus. But I consider %0.2fRP to still be a proper payment.", payment),
        }) .. "\n\n- " .. person:getFormalName()
    end,
})