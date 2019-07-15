local f = string.format

My.Translator:register("en", {
    side_mission_raging_miner = function(sectorName)
        return f("Destroy miner in sector %s", sectorName)
    end,
    side_mission_raging_miner_description = function(payment)
        local cause = Util.random({
            "an asteroid collision",
            "infirmity",
            "space junk",
            "an electromagnetic pulse",
            "corrosion",
            "radiation",
            "a short circuit",
        })

        return Util.random({
            "We got a little problem.",
            "I have a delicate problem.",
        }) .. " " .. Util.random({
            "My mining ship",
            "I am a miner and my space ship",
        }) .. " was severely damaged by " .. cause .. " " .. Util.random({
            "recently",
            "yesterday",
            "a few hours ago",
        }) .. ". It has damaged some systems. " .. Util.random({
            "I was too stupid and activated the autopilot",
            "Before I left the ship I activated the autopilot",
        }) .. ", but now " .. Util.random({
            "the ship is in a frenzy",
            "that junk pile is going crazy",
        }) .. ". The Friend-or-Foe detection " .. Util.random({
            "was squashed like a space fly",
            "is nothing more than rubbish",
            "did not survive it",
            "went belly up",
        }) .. " and now the AI considers any ship an asteroid. The laser is extremely " .. Util.random({
            "dangerous",
            "deadly",
        }) .. ". And if this was not enough the shields " .. Util.random({
            "are also going haywire",
            "also got a dent",
            "also got damaged",
            "also had a short circuit",
        }) .. " and do no longer boot up correctly. Instead, they are releasing a huge EMP spike when they are charged. I need someone to destroy this crappy ship and I was thinking of you. " .. f("How do %0.2fRP sound as a reward?", payment)
    end,

    side_mission_raging_miner_too_close = "You are too close to the target area to start the mission.",
    side_mission_raging_miner_accept = "Yes! An epic duel between two machines. What a pity that I can not attend.",

    side_mission_raging_miner_ship_description = function()
        return Util.random({
            "An old mining ship",
            "A miner ready for the junk yard",
        }) .. " that was damaged."
    end,
    side_mission_raging_miner_ship_description_simple = "The Friend-or-Foe detection and the shield generator too severe damage. It is recommended to avoid it.",
    side_mission_raging_miner_ship_description_extended = "The ship causes significant EMP damage once the shields are charged to 0%. The Friend-or-Foe detection is not working and any object is considered an asteroid abundant with ore. Approach with extreme caution.",

    side_mission_raging_miner_approach_comms = "The miner should be visible on your scanners. Please be careful. The laser is extremely dangerous and the EMP pulses can shred your shields in seconds.",
    side_mission_raging_miner_success_comms = function(payment)
        return Util.random({
            "Hurrah!"
        }) .. " " .. Util.random({
            "This junk pile",
            "This old clunker",
        }) .. " is finally " .. Util.random({
            "history",
            "destroyed",
            "disabled",
        }) .. ". This maniac machine did not deserve anything else. " .. f("Here are your %0.2fRP - don't spend it all on liquor at once.", payment)
    end,
})