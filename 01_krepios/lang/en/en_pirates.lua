local f = string.format

My.Translator:register("en", {
    pirate_ship_description = function()
        return Util.random({
            "A darkly painted ship with a big white skull painted on its hull.",
            "A tally is kept on the hull of the ship. It obviously keeps track of the kills of this pilot.",
            "Telling by the energy signature this ship has multiple illegal upgrades installed.",
            "From a distance it looks as if this ship is armed to the teeth. But the scans show that half of the weapons are mockups. The ship is dangerous nevertheless.",
            "The hull bears the name of the ship framed by a tasteless composition of laser beams and rose spines.",
        })
    end,
})