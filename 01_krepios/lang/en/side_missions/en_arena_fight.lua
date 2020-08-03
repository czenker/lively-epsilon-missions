local f = string.format
local t = My.Translator.translate

My.Translator:register("en", {
    side_mission_arena = "Fight in the arena",
    side_mission_arena_description = function(tinkererPerson, payment)
        return "Hey you." .. " " ..
        Util.random({
            "The people demand entertainment!",
            "This sector got a little bored recently.",
        }) .. "\n" ..
        Util.random({
            "You want to fight some drones in the arena?",
            f("Luckily %s built some drones. Are you up to fight them in the arena?", tinkererPerson:getNickName()),
        }) .. " " ..
        Util.random({
            f("You will be paid %0.2fRP if you defeat them all without taking too much damage.", payment),
            f("The winner will be paid %0.2fRP.", payment),
            f("If you fight well and defeat all enemies, you will be paid %0.2fRP.", payment),
        })
    end,
    side_mission_arena_accept = function(sectorName)
        return "Here are the rules: \n\n" ..
        " * You fight against machines. No need to have mercy on them. If you destroy all of them, you win.\n" ..
        " * If your hull drops below 10% the fight is aborted and you lose.\n" ..
        " * If you leave the arena the fight is ended and you lose.\n\n" ..
        f("Start the fight by entering the arena in sector %s. Come prepared.", sectorName)
    end,
    side_mission_arena_goto_hint = function(sectorName)
        return "Enter the arena in sector " .. sectorName .. " prepared to fight"
    end,
    side_mission_arena_fight_hint = "Destroy all enemies in the arena without leaving it",
    side_mission_arena_fight_warning = "!!!Stay inside the Arena or the mission will be lost!!!",

    side_mission_arena_success = function(stationName, payment)
        return Util.random({
            "That was some first-class entertainment out there in the arena.",
            "Amazing how you handled that fight.",
        }) .. " " .. Util.random({
            "You made short work of those drones.",
            "You gave them quite a fight.",
            "Those drones were no match for you.",
        }) .. "\n\n" .. Util.random({
            f("Here is your payment of %0.2fRP.", payment),
            f("Your payment of %0.2fRP was transferred.", payment),
        }) .. " " .. Util.random({
            f("If you return to %s, make sure to stop at the bar. There are a few guys wanting to pay you a drink.", stationName),
            "And don't be too hard on those guys who bet on the drones. I'm sure it was nothing personal.",
        })
    end,
    side_mission_arena_failure = function(tinkererPerson)
        return Util.random({
            "This was very unfortunate for you.",
            "Woo - that was bad luck."
        }) .. " " .. Util.random({
            "Those drones were coming at you like crazy.",
            "You were not up for the challenge.",
            Names.possessive(tinkererPerson:getNickName()) .. " drones are just too powerful.",
        }) .. " " .. Util.random({
            "At least the crowd was entertained.",
            "Better luck next time.",
            "Make your repairs and maybe try again.",
        })
    end,
})