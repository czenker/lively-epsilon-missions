local f = string.format

My.Translator:register("en", {
    chatter_leave = function()
        return Util.random({
            "I can hardly wait " .. Util.random({
                "to leave the system",
                "to get out of here",
            }) .. ". What a " .. Util.random({
                "sinkhole",
                "hellhole",
                "rat hole",
                "pigpen",
            }) .. ".",
        })
    end,

    chatter_existentialism = function()
        return Util.random({
            "Sometimes I wonder if I even exist when there is no one to see me.",
            "I feel watched.",
            "Am I being watched?",
            "Hey, I know you're listening to me! Stop it!",
        })
    end,

    chatter_existentialism_1 = function()
        return Util.random({
            "Do you sometimes feel like you're just a product of another person's imagination?",
            "Do you think our lives are predestined?",
            "Do you think you're acting on your own terms?",
            "Don't you also think now and then that someone else actually controls your life?",
            "Sometimes my life feels like a movie someone wrote with an intention. Don't you think?",
        })
    end,
    chatter_existentialism_2 = function()
        return Util.random({
            "No. I have my life in my hands and decide for myself what I do.",
            "It makes no difference as long as I feel like I'm making my own decisions.",
            "Then could I say what I want? Like \"shut the fuck up\"? You see! Completely free will.",
            "You have to stop drinking so much.",
            "I could fly into a black hole at any time and no one can stop me. But I decided against it.",
        })
    end,

    chatter_distance_to_dock = function(stationCallSign, distance)
        return Util.random({
            "Traveling in space takes an eternity.",
            "Waiting until you get to your destination sucks.",
            "Booooooooooooooooring.",
        }) .. " " .. Util.random({
            f("But fortunately it's only %du to %s.", distance, stationCallSign),
            f("But only %du until after %s.", distance, stationCallSign),
            f("I'll be in %s in about %du.", stationCallSign, distance),
            f("%s is only %du away. Then I am finally there.", stationCallSign, distance),
        })
    end,

    chatter_expensive_products_1 = function(productName, amount, price)
        return Util.random({
            "Can you imagine how little you can earn by trading goods these days?",
        }) .. " " .. Util.random({
            "Yesterday",
            "Last week",
            "Recently",
            "The other day"
        }) .. " a ran into some " .. Util.random({
            "trader",
            "nut",
            "swindler",
        }) .. " who " .. Util.random({
            f("demanded %.2fRP for just %d units of %s", price, amount, productName),
            f("wanted me to give him %.2fRP for %d units of %s", price, amount, productName),
        }) .. "."
    end,
    chatter_expensive_products_2 = "I hope he did not talk you into anything.",
    chatter_expensive_products_3 = "Of course not. But that is scandalous.",


    chatter_miner_retire_1 = "What are you gonna do when you've collected enough money to get out of this stink hole?",
    chatter_miner_retire_2 = function(metalBandName)
        return Util.random({
            "I would love to",
            "I don't know yet. But maybe I could",
            "If you ask me like that... I want",
            "Good question. I would"
        }) .. " " .. Util.random({
            "",
            "sell my apartment and",
            "sell my ship and",
            "quit my job and",
        }) .. " " .. Util.random({
            "buy a small cabin on " .. Util.random({
                "Earth",
                "Mars",
                "Alpha Centaury",
            }),
            "work as a roady for " .. metalBandName .. ".",
            "take a break and travel the universe.",
            "open a bar " .. Util.random({
                "on a free trading station",
                "on Earth",
                "on Mars",
            }) .. ".",
        })
    end,
    chatter_miner_retire_3 = function()
        return Util.random({
            "But I'll never be able to afford that.",
            "But it's never gonna work with those stupid taxes.",
            "As long as my boss pays me so badly, it's staying a dream.",
            "But for that, I'd have to win poker first.",
            "But first I have to pay off my betting debt.",
            "It just won't work as long as I waste my money on drink.",
        })
    end,

    chatter_miner_ship_envy_1 = function(merchantCallSign)
        return f("Hi %s.", merchantCallSign) .. " " .. Util.random({
            "How much is your hot rod?",
            "How much does it cost to take your vehicle for a ride?",
            "What do you want in exchange for your ship?"
        })
    end,
    chatter_miner_ship_envy_2 = function()
        return Util.random({
            "More than you can afford.",
            "Get the fuck off, you nut.",
        })
    end,

    chatter_abandoned_station_1 = function(stationCallSign)
        return Util.random({
            f("Would you like to explore %s from up close?", stationCallSign),
            f("What's your attitude to treasure hunts in abandoned stations?"),
            f("I'm looking for another person who would plunder %s with me?", stationCallSign),
        })
    end,
    chatter_abandoned_station_2 = function()
        return Util.random({
            "I'm not a treasure hunter. I stay away from the abandoned stations. You never know what dangers lurk there.",
            "It's not supposed to be safe. Leaking reactors, short-circuited lines. Anything can happen there.",
            "The prospect of a find by chance would appeal to me.",
        })
    end,

    chatter_nebula_1 = function(nebulaName)
        return Util.random({
            f("Have you ever seen %s from up close?", nebulaName),
            f("I heard %s is beautiful.", nebulaName),
            f("Do you think %s is a good place to hide from money collectors?", nebulaName),
        })
    end,
    chatter_nebula_2 = function()
        return Util.random({
            "I'm trying to stay away from nebulae.",
            "I wouldn't be seen dead in a place like that.",
            "My father advised me as a child to keep away from nebulae."
        }) .. " " .. Util.random({
            "You never know what kind of riffraff is living there.",
            "Last year I met pirates in the nebula. I barely got away with my life.",
            "You'll only meet scum there anyway.",
        })
    end,

    chatter_upgrade_1 = function(upgradeName)
        return Util.random({
            f("Do you know where I can buy %s?", upgradeName),
            f("I've been looking for %s for ages. Do you know who is selling it?", upgradeName),
            f("I'd like to buy %s, but I don't know where to find it.", upgradeName),
        })
    end,
    chatter_upgrade_2 = function(stationCallSign)
        return Util.random({
            f("Why don't you check at %s?", stationCallSign),
            f("I think %s does.", stationCallSign),
            f("I have seen it on %s once.", stationCallSign),
            f("Have you tried on %s?", stationCallSign),
            f("Maybe check on %s.", stationCallSign),
        })
    end,

    chatter_waste = function()
        local thing = Util.random({
            "an old satellite",
            "a frozen dead body",
            "space waste",
            "an asteroid lump",
            "a folding chair",
        })

        return Util.random({
            Util.random({
                "Garbage in space is the biggest problem our generation has to solve.",
                "Waste everywhere.",
                "Look at that! It's just junk all over the place.",
                "This garbage everywhere is a huge problem."
            }) .. " " .. Util.random({
                f("Just a quick nap and you collide with %s.", thing),
                f("I almost hit %s.", thing),
            })
        })
    end,

    chatter_betting_1 = function(person, amount)
        local reason = Util.random({
            "playing poker",
            "playing dice",
            "making sport bets",
            "arm wrestling",
            "in a race",
            "betting on a dogfight",
            "betting on a cockfight",
            "in a drinking contest",
            "playing space ball",
        })

        return Util.random({
            f("I heard you lost %dRP to %s %s.", amount, person:getFormalName(), reason),
            f("Is it really true that you lost %dRP to %s %s?", amount, person:getFormalName(), reason),
            f("I understand that %s has relieved you of %.2fRP %s. Is there any truth to the story?", person:getFormalName(), amount, reason),
            f("Is it true that you now have %dRP less cause you lost %s against %s?", amount, reason, person:getFormalName()),
        })
    end,

    chatter_betting_2 = function()
        return Util.random({
            "Unfortunately, the story is true.",
            "But it won't stay that way for long.",
            "Who did you hear the story from?",
            "Who's gonna tell the story? Sure some chatterbox.",
        }) .. " " .. Util.random({
            "I already have a plan how to get the money back.",
            "Tonight's a rematch.",
            "Next time I'll be luckier. I have a new talisman now.",
        })
    end,

    chatter_hope_for_peaceful_flight = function(product)
        return Util.random({
            f("I hope my cargo of %s doesn't attract pirates.", product:getName()),
            f("With the stories you always hear, you can only hope my cargo %s doesn't attract pirates.", product:getName()),
            f("Hiding my load of %s under a heap of worn socks was the best idea I ever had. No pirate will come up with the idea of looking there.", product:getName()),
            f("Last week another pilot was killed in a pirate attack. I can only hope that they are not interested in my cargo of %s.", product:getName()),
        })
    end,

    chatter_hartman_1 = function(person)
        local insultingAdjectivs = Util.randomSort({
            "battiest",
            "silliest",
            "most selfish",
            "fattest",
            "most idiotic",
            "most incompetent",
            "most imbecile",
            "dullest",
            "most untalented",
            "most unteachable",
            "most irresponsible",
            "trashiest",
            "most mindless",
            "most retarded",
        })

        local insult = {
            "amoebic brain",
            "scumbag",
            "dullard",
            "simpleton",
            "intelligence allergic",
            "failure",
            "booger nibbler",
            "desk goblin",
            "chair gnome",
            "denier of intellect",
        }

        return Util.random({
            "Argh!!!",
            "Honestly:",
        }) .. " " .. person:getFormalName() .. " is the " .. insultingAdjectivs[1] .. " and " .. insultingAdjectivs[2] .. " " .. Util.random(insult) .. ", " .. Util.random({
            "I have seen in my whole life",
            "I have ever seen",
        }) .. "."
    end,

    chatter_hartman_2_accept = function()
        return Util.random({
            "Haha, nicely said.",
            "Yeah, give it to him.",
            "I couldn't add anything to that.",
            "You got it.",
            "Lol. That's how it is.",
        })
    end,

    chatter_hartman_2_reject = function()
        return Util.random({
            "I wouldn't say that. Surely there is a reason why he behaves like that.",
            "If the wrong people hear this, you're going to have trouble in a jiffy.",
            "And you'd say that to his face? I don't think so.",
            "Stop insulting people or I'll sew your mouth shut.",
        })
    end,

    chatter_treasure_1 = function(dropSectorName)
        return Util.random({
            f("A friend told me there's a shipping container with no owner in sector %s. If the minefield wasn't there, I would get it.", dropSectorName),
            f("I've heard of a quick way to make money. In sector %s, in a minefield, there is a shipping container that nobody misses.", dropSectorName),
            f("Wanna earn some fast RP? In the minefield in sector %s there is allegedly a container without owner. I'm sure the mines are so old that they won't trigger anymore.", dropSectorName),
            f("Hey. I got a tip on how to get money real quick: In sector %s there is a ship container that nobody misses.", dropSectorName),
        })
    end,
    chatter_treasure_2 = function()
        return Util.random({
            "In a minefield? Are you insane?",
            "Do you really want to get shredded by a mine?",
            "Let's do it this way: You get the container and I'll survive in the meantime. OK?",
            "And if I bet you won't come back alive, I'm filthy rich, too.",
        })
    end,

})