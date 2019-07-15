local t = My.Translator.translate
local f = string.format

My.Translator:register("en", {

    mines_miner_station_description = function()
        return Util.random({
            "A port for miners.",
            "Mining ships start here to dig surrounding asteroids.",
            "One of the old trade stations in the sector where mining ships set out.",
            "An aged mining station operated by the SMC.",
        }) .. " " .. Util.random({
            "Miners return here to sell their yield and waste the profits on drinks.",
        })
    end,

    mines_miner_description = function(shipCallSign, captainPerson)
        return Util.random({
            "A mining ship that has seen better days.",
            "A clapped out ship that is used to mine asteroids in the outer zones.",
            "The better times as a miner have passed for this ship.",
            "A transporter that has been refitted as a mining ship.",
        }) .. " " .. Util.random({
            "Its hull bears many scratches.",
            "How this ship is still able to fly remains a mystery.",
            "A provisionally patched hole in the ships hull tells of the recent history of the ship.",
            "Someone scribbled the ships name \"" .. shipCallSign .. "\" on the ship's hull with white color.",
            "The ship pulls a big cloud of asteroid dust behind it.",
            "This ship does not seem to have a license for operating.",
            "A graffiti on the ships hull informs that captain " .. captainPerson:getNickName() .. " " .. Util.random({
                "is a boozer.",
                "is stupid.",
                "has a strong odor. Or does it mean the ship?",
            }),
            "\"Clean me\" was drawn into the dust on one of the windows with a finger.",
        })
    end,

    mines_miner_who_are_you = function(captainPerson, stationCallSign, minedProductNames)
        local minedProducts = Util.mkString(minedProductNames, ", ", " " .. t("generic_and") .. " ")
        return t("comms_generic_introduction", captainPerson) .. " " .. Util.random({
            f("I am working for the station %s.", stationCallSign),
            f("I'm flying on behalf of station %s for Saiku Mining Corporation.", stationCallSign),
            f("I was hired by Saiku Mining Corporation and deliver my yield to %s.", stationCallSign),
        }) .. " " .. Util.random({
            f("I extract %s from asteroids and return it to my home station.", minedProducts),
            f("I mine %s from asteroids.", minedProducts),
            f("I specialized in mining asteroids. %s are my specialty.", minedProducts),
            f("My task is to mine %s from asteroids.", minedProducts),
        }) .. " " .. Util.random({
            "Payment is not the best, but somehow I need to make a living.",
            "I am paid way too badly for the dangers I run into every day out here. But I am not qualified for a better job.",
        })
    end,

    mines_miner_undocking_chat_1 = function()
        return Util.random({
            "And off I go to another hour surrounded by asteroids.",
            "My boss says I need to fly my next shift.",

            -- say bye
            "See you later. I am going to laser asteroids.",

            -- crappy ship
            "Let's hope " .. Util.random({
                "the laser",
                "the drive",
                "the shield",
                "the control system",
            }) .. " does not " .. Util.random({
                "go haywire",
                "go bonkers",
                "break down",
            }) .. " again or it is going to be a long shift.",
        })
    end,
    mines_miner_undocking_chat_2 = function(minerCallSign, randomPerson)
        return Util.random({
            -- personal
            "And who is cleaning up your barf in the hangar?",
            "You better come back. There needs to be a rematch this evening.",
            "See you this evening " .. Util.random({
                "at " .. randomPerson:getNickName() .. ".",
                "at the casino.",
                "at the bar.",
                "at the mess hall.",
                "at the poker table.",
            }),
            -- crappy ship
            Util.random({
                "The mechanic said",
                randomPerson:getNickName() .. " said",
            }) .. f(" the pile of junk you call %s should survive the next flight.", minerCallSign),
        })
    end,

    mines_miner_dock_initiation_chat_request = function(stationCallSign, shipPerson, stationPerson)
        local hail = Util.random({
            f("Hey %s.", stationCallSign),
            f("Hello %s.", stationCallSign),
            f("This is captain %s for the idiots on %s.", shipPerson:getFormalName(), stationCallSign),
            f("Does anybody on %s hear me?", stationCallSign),
            f("Hey %s. Do you hear me?", stationCallSign),
            f("Hello?? Do you hear me, %s?", stationCallSign),
            f("Can you hear me, %s? My Comms relay went haywire again.", stationPerson:getNickName()),
            f("Does your Comms relay still work, %s?", stationCallSign),
        })
        local jobDone = Util.random({
            "I finished my shift and approach the station.",
            "If this junk pile stays in one piece a little longer, I will be back with you in a minute.",
            "If you want to prevent my ship from falling apart, you should call an emergency repair team to the hangar already. I'm back in a second.",
            "Can you put a beer on ice? I will be back soon.",
        })

        return hail .. " " .. jobDone
    end,
    mines_miner_dock_initiation_chat_response = function(stationCallSign, shipPerson, randomPerson)
        local response = Util.random({
            "And I thought you collided with an asteroid.",
            f("You are still alive? Crap, now I have to buy %s a drink.", randomPerson:getNickName()),
            "I smelled your clunker already two hours ago.",
            "I've got you on screen for a long time already. Your fat ass is hard to overlook.",
            f("Is that you, %s? Did not recognize you between all this junk.", shipPerson:getNickName()),
            "We only grant docking permission to pilots with a blood alcohol level below 0.2%. But I make an exception for you.",
        })

        local additional = Util.random({
            "Welcome home.",
            f("Welcome back to %s.", stationCallSign),
            "Great that you are back.",
            Util.random({
                "The boss",
                "Your brother",
                "Your sister",
                "The fatso",
                randomPerson:getNickName(),
            }) .. " " .. Util.random({
                "was looking for you and waits for you",
                "waits for you",
                "asked for you and is expecting you",
                "seems to be missing you and awaits you",
            }) .. " " .. Util.random({
                "for an inspection in the hangar.",
                "at the bar with some moonshine.",
                "in the hangar to talk about your gambling debt.",
                "at the casino with a pile of cards.",
                "with some moonshine in the canteen.",
                "wrestle ring. " .. Util.random({
                    "In my opinion you don't stand a chance.",
                    "I already placed my bet on you.",
                }),
                "at the sick bay for a checkup.",
            })
        })

        return response .. " " .. additional
    end,

})