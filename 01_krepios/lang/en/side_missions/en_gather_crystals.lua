local f = string.format

My.Translator:register("en", {
    side_mission_gather_crystals = function(nebulaName)
        return f("Collect crystals in %s", nebulaName)
    end,
    side_mission_gather_crystals_description = function(person, amount, payment)
        return Util.random({
            "Hey you. Are you interested in science?",
            "You don't look like you'd disregard an opportunity to go on a little errand for science.",
        }) .. " " .. Util.random({
            "You probably know my name from my published papers.",
            "You know me from numerous publications in scientific journals.",
            "I assume you already know me from publications.",
        }) .. " " .. Util.random({
            "No? You don't?",
            "No? Really?",
            "Are you serious? You never heard of me?",
        }) .. " " .. Util.random({
            f("Well then, my name is %s.", person:getFormalName()),
            f("Then try to remember the name \"%s\" from now on.", person:getFormalName()),
        }) .. " " .. Util.random({
            "I am the leader of the crystallography department.",
            "I am head of science in the crystallography department.",
        }) .. "\n\n" ..
        "I am researching " .. Util.random({
            "hexagonal trapezoid",
            "monoclinic prismatic",
            "tetragonal dipyramidal",
            "triakis tetrahedric",
            "rhombic dodecahedric",
            "deltoid icositetraedric",
        }) .. " " .. Util.random({
            "crystal structures", "crystal textures", "lattice structures", "mesh effects"
        }) .. " in " .. Util.random({
            "idiomorphic", "hypidiomorphic", "xenomorphic", "polymorphic", "translational symmetric",
        }) .. " " .. Util.random({"minerals", "crystals"}) .. " and need " .. amount .. " more " .. Util.random({
            "samples", "specimens", "objects",
        }) .. " which can be found in the surrounding " .. Util.random({
            "molecular cloud", "matter concentration"
        }) .. ".\n\n" .. Util.random({
            f("Science will show its gratitude with %0.2fRP.", payment),
            f("What? An honorary mention in one of my papers is not enough for you? Well, you cutthroat. I can also offer up %0.2fRP as compensation.", payment),
            f("For waiving any claims to be mentioned in my Nobel Prize speech I am willing to pay you %0.2fRP.", payment),
        })
    end,
    side_mission_gather_crystals_accept = function()
        return Util.random({
            "I thank you in the name of science for your support.",
            "I am returning to my studies now.",
            "What do you still want here? Get to work.",
        }) .. " " .. Util.random({
            "I marked some places in the nebula where you might be lucky to find samples.",
            "Some common places for specimen have been marked on your map.",
        })
    end,

    side_mission_gather_crystals_artifact_name = "Crystal",
    side_mission_gather_crystals_artifact_description = "A crystal", -- @TODO: description is pretty lame

    side_mission_gather_crystals_hint_ok = "Crystal collected",
    side_mission_gather_crystals_hint_gather = function(amount, stationCallSign)
        local msg = "Collect "
        if amount > 1 then
            msg = msg .. f("%d more crystals", amount)
        else
            msg = msg .. "one more crystal"
        end
        msg = msg .. f(" and return to %s.", stationCallSign)
        return msg
    end,
    side_mission_gather_crystals_hint_return = function(stationCallSign)
        return f("Deliver the crystals to %s.", stationCallSign)
    end,
    side_mission_gather_crystals_success_comms = function(payment)
        return Util.random({
            "Oh, you found some exceptional specimen there. I have to analyze them immediately.",
            "Now give me the crystals. Aren't they beautiful... so very, very beautiful... this symmetry... and form....."
        }) .. " " ..
        Util.random({
            "Now what? Oh, the payment!",
            "Why are you still here holding your hand open? Alright! The payment.",
            "Why are you clearing your throat? Oh, I forgot. Your payment.",
            "What now? I forgot your payment?",
        }) .. " " .. Util.random({
            f("Why should I be interested in your human needs! Take the %0.2fRP already.", payment),
            f("Does scientific progress mean nothing to you?? Take these %0.2fRP from my research budget, you cutthroat.", payment),
            f("No money in the world can compensate for the joy crystallography brings. I pity you that you need to settle with these meager %0.2fRP.", payment),
        }) .. "\n\n" .. Util.random({
            "And now chop, chop. Get out. I need to work.",
            "You are still here? How often do I have to repeat myself: I need silence to work. Get out of here! Now!",
        })
    end,
})