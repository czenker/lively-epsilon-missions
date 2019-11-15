local f = string.format
local t = My.Translator.translate

My.Translator:register("en", {
    side_mission_secret_code = function(stationCallSign)
        return "Secret message for " .. stationCallSign
    end,
    side_mission_secret_code_description = function(receiverPerson, stationCallSign, payment)
        local HeShe, HisHer
        if Person:hasTags(receiverPerson) and receiverPerson:hasTag("male") then
            HisHer = "His"
            HeShe = "He"
        else
            HisHer = "Her"
            HeShe = "She"
        end
        return Util.random({
            "Shhhsh. Yes, you.",
            "Hey you. Don't look so suspicious.",
            "Over here! Are you sure nobody followed you?",
        }) .. " " .. Util.random({
            f("You need to deliver a secret message to my contact on %s.", stationCallSign),
            f("I have important information for my contact on %s that you need to deliver as fast as possible.", stationCallSign),
            f("My contact on %s asked my to share my knowledge.", stationCallSign)
        }) .. " " .. Util.random({
            f(HisHer .. " code name is \"%s\".", receiverPerson:getFormalName()),
            f(HeShe .. " is known by the name \"%s\" there.", receiverPerson:getFormalName()),
            f("You need to look for someone named \"%s\" on the station. It is a code name of course.", receiverPerson:getFormalName()),
        }) .. " " .. Util.random({
            "I expect you handle the message confidentially.",
            "If you spill the beans about the message, I will have to kill you unfortunately. But we do not have to let it come to this, right? ... Haha, just one of my hilarious jokes.",
        }) .. " " .. Util.random({
            f("We will pay you %.2fRP as soon as you delivered the message.", payment),
            f("Your secrecy in this matter will be rewarded with %.2fRP.", payment),
        })
    end,

    side_mission_secret_code_not_docked = function(stationCallSign)
        return Util.random({
            f("Please meet me personally on %s to talk about the matter.", stationCallSign)
        }) .. " ".. Util.random({
            "I would not need your help if I could just radio the message.",
        })
    end,

    side_mission_secret_code_accept = function(senderPerson, phrase)
        return Util.random({
            "Very good.",
            "Marvelous.",
        }) .. " " .. Util.random({
            "I will just tell you the message one single time.",
            "Please take into consideration that I will only tell you the message once.",
        }) .. " " .. Util.random({
            "You must not forget it under any circumstance.",
            "Don't forget it!",
            "You need to remember the message.",
            "I hope your brain is healthy."
        }) .. " " .. Util.random({
            "The message is:",
            "Say this:",
            "Remember this message:",
        }) .. "\n\n\"" .. phrase .. "\"\n\n" .. Util.random({
            "[With these words the stranger is disappearing.]",
        })
    end,

    side_mission_secret_code_hint = function(senderPerson, receiverPerson, stationCallSign)
        return f("Deliver message from \"%s\" to \"%s\" on %s.", senderPerson:getFormalName(), receiverPerson:getFormalName(), stationCallSign)
    end,

    side_mission_secret_code_comms_label = function(receiverPerson)
        return f("Talk to %s", receiverPerson:getFormalName())
    end,

    side_mission_secret_code_comms_not_docked = function(stationCallSign)
        return Util.random({
            "Who are you? I do not know you!",
            "Why are you contacting me? I'm sure you misdialed.",
        }) .. " " .. Util.random({
            f("If you want to talk about confidential topics, come meet me on %s.", stationCallSign),
            f("Confidential issues are not to be talked on via Comms. Please meet me in person on %s.", stationCallSign),
        })
    end,

    side_mission_secret_code_comms = function(receiverPerson, senderPerson)
        local himHer
        if Person:hasTags(senderPerson) and senderPerson:hasTag("male") then
            himHer = "him"
        else
            himHer = "her"
        end
        return Util.random({
            "Shhhsh. Yes, you.",
            "Hey you. Don't look so suspicious.",
            "Over here! Are you sure nobody followed you?",
        }) .. " " .. Util.random({
            f("If you are looking for %s, then you have found " .. himHer .. ".", receiverPerson:getFormalName()),
            t("comms_generic_introduction", receiverPerson) .. " I have been expecting you.",
        })
        .. " " .. Util.random({
            f("%s mentioned you had a message for me!?", senderPerson:getFormalName()),
            f("You are supposed to deliver a message from %s. So, what is it?", senderPerson:getFormalName()),
            f("What is the message you should deliver from %s?", senderPerson:getFormalName()),
        })
    end,

    side_mission_secret_code_success = function(payment)
        return Util.random({
            "Alas!",
            "I see!",
            "Oh yes. That is it!",
            "Ooooh, I see.",
            "So that's the way it is?",
        }) .. " " .. Util.random({
            "Everything starts making sense now.",
            "This certainly explains the recent events.",
            "I'm surprised I didn't figure that out myself.",
            "This information sheds a totally different light on this situation.",
            "If it is true, then it would explain the strange behavior of the last days.",
            "I was expecting something like this. But I was not aware that it was this bad.",
            "And I was thinking something completely different. I'm glad you brought the information to me in time.",
            "Then it means that my conclusions have been wrong the whole time. Thanks for helping me understand the links.",
        }) .. " " .. Util.random({
            "I will prepare everything that is necessary.",
            "I can not waste any more time.",
            "I will be on the way immediately.",
            "I need to draft a plan immediately.",
            "This information has to be distributed as soon as possible.",
        }) .. "\n\n" .. Util.random({
            f("Thank you for your help. Your payment of %.2fRP has been transferred.", payment),
            f("You received a payment of %.2fRP.", payment),
        })
    end,

    side_mission_secret_code_failure = function(senderPerson)
        return Util.random({
            "You are a damn liar.",
            "Stop lying already.",
            "Lie to somebody else.",
        }) .. " " .. Util.random({
            "This can not be true.",
            f("No way %s said that.", senderPerson:getFormalName()),
            "This message does not make any sense at all.",
        }) .. " " .. Util.random({
            "Get out and do not bother me again.",
            "You must have misheard something.",
        }) .. " " .. Util.random({
            "You won't get a reward for such hokum.",
            "I won't pay you for such gibberish.",
        })
    end,

    side_mission_secret_code_part1 = function()
        return Util.random({
            "A blackbird",
            "A blue tit",
            "A chimney swift",
            "A dove",
            "A duck",
            "An eagle",
            "A falcon",
            "A godwit",
            "A golden-plover",
            "A hawk",
            "A hummingbird",
            "A killdeer",
            "A mangrove cuckoo",
            "A nighthawk",
            "An owl",
            "A parrot",
            "A sandpiper",
            "A sparrow",
            "A willet",
            "A woodcock",
            "A woodpecker",
            "A yellow rail",
        })
    end,
    side_mission_secret_code_part2 = function()
        return Util.random({
            "breeds",
            "builds",
            "calls",
            "cleans itself",
            "drinks",
            "eats",
            "hides",
            "hunts",
            "is on the lookout",
            "mates",
            "nests",
            "poops",
            "rests",
            "roosts",
            "sits",
            "sleeps",
            "waits",
            "watches",
        })
    end,
    side_mission_secret_code_part3 = function()
        return Util.random({
            "next to a stump",
            "on the mountaintop",
            "between the branches",
            "on the gable",
            "on a power line",
            "on the roof of a church",
            "in a crevice",
            "at the rectory",
            "on a rock",
            "on top of a street light",
            "on a fir",
            "under an awning",
            "at the forest lake",
        })
    end,

})