local t = My.Translator.translate
local f = string.format

My.Translator:register("en", {
    random_ships_generic_personal_description = function(factionName)
        return f("A personal transport ship by the %s.", factionName)
    end,
    random_ships_generic_civilian_description = "A civilian ship.",

    random_ships_mine_workers_who_are_you = function(captainPerson, stationCallSign)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("I am dropping miners off for work on %s.", stationCallSign),
            f("My task is to bring miners to %s safely.", stationCallSign),
            f("These miners have to be brought to %s for their shift.", stationCallSign),
        })
    end,

    random_ships_mine_workers2_who_are_you = function(captainPerson, stationCallSign)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("I am bringing miners back from work to %s.", stationCallSign),
            f("My task is to bring miners to %s safely.", stationCallSign),
            f("These miners have to be returned to %s from their shift.", stationCallSign),
        })
    end,

    random_ships_fun_time_who_are_you = function(captainPerson, stationCallSign)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("I am going to have a fun time at %s. Working as a miner is stressful, so you regularly need to take some time off.", stationCallSign),
            f("Some friends invited me to join their poker night at %s. Keep your fingers crossed that I'm not loosing my ship.", stationCallSign),
            f("Why should I tell you what I am doing at %s? You would not understand it anyways.", stationCallSign),
            "Me and my friends are going to paaaaarrrrteeeeeeyyyy!!! We need to blow off some steam.",
            f("The bar at %s has the best booze in the sector. I'm going there to forget the last few days.", stationCallSign),
            f("I just got my paycheck. And I think it's best invested in a some beers on %s.", stationCallSign),
            f("A long shift is over. I need to get some time off. And what better way is there then to drown yourself in %s on %s.",
                Util.random({"whiskey", "rum", "moonshine"}),
                stationCallSign
            ),
        })
    end,

    random_ships_fun_time2_who_are_you = function(captainPerson, stationCallSign)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("I am returning to my next shift on %s.", stationCallSign),
            f("I lost all my earnings on gambling. Now I need to return to my job on %s.", stationCallSign),
        }) .. " " .. Util.random({
            "I hate this life.",
            "This job is the worst.",
        })
    end,

    random_ships_leaving_who_are_you = function(captainPerson)
        return Util.random({
            "I am finally leaving this shit hole.",
            "I can't stand this anymore – I quit!",
            "I just quit my job to start a new life on Earth."
        }) .. " " .. Util.random({
            f("Oh, by the way - my name is %s. But there is no need to remember it.", captainPerson:getFormalName()),
            f("If anyone asks for %s, tell them I am gone for good.", captainPerson:getFormalName()),
            f("Say hi from %s if you ever meet my boss. And tell him he is the worst ever.", captainPerson:getFormalName()),
        })
    end,

    random_ships_nebula_tourism_who_are_you = function(captainPerson, nebulaName)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("Me and my friends are flying to %s to have a good time there - if you catch my drift.", nebulaName),
            f("I heard %s was beautiful, so I picked up a few friends to go there.", nebulaName),
            f("I think %s is the best place to relax. But only if you bring lots of alcohol and a few friends. I got both. So here we go.", nebulaName),
        })
    end,
    random_ships_nebula_tourism2_who_are_you = function(captainPerson, nebulaName, stationCallSign)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("We are returning from a short trip to %s.", nebulaName),
            f("We had a great time at %s, isn't that right guys? ... [You here a yelling from the seating area] ... Now we are heading back to %s.", nebulaName, stationCallSign),
        })
    end,

    random_ships_prospector_who_are_you = function(captainPerson, stationCallSign)
        return t("comms_generic_introduction", captainPerson) .. " " ..  Util.random({
            f("I am scanning asteroids around %s for minerals.", stationCallSign),
            "My task is to update measures of the mineral concentration on nearby asteroids for the SMC.",
            f("My job is to find the mineral richest asteroids around %s for the Saiku Mining Company.", stationCallSign),
        })
    end
})