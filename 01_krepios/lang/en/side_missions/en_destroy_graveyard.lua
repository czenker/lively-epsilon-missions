local f = string.format

My.Translator:register("en", {
    side_mission_destroy_graveyard_too_close = "You are too close to the area of operations and can not accept the mission.",
    side_mission_destroy_graveyard = function(sectorName)
        return f("Destroy space junk in sector %s", sectorName)
    end,
    side_mission_destroy_graveyard_description = function(sectorName, number, payment)
        return Util.random({
            "You might have noticed that we have a problem with space scrap here.",
            "We have to admit this mission is not the most prestigious. But someone has to do it.",
        }) .. " " .. Util.random({
            f("Some wrecks on the ship graveyard in sector %s went off route and threaten to drift into a nearby trade route. You have to vaporize the wrecks of %d ships.", sectorName, number),
            f("%d ship wrecks in the nearby ship graveyard will leave their stable orbit soon. We do not want them to be a danger to near travel routes, so we are looking for someone to vaporize them.", number),
        }) .. "\n\n" .. Util.random({
            f("We pay %0.2fRP on completion.", payment),
            f("If you would help us, we are paying %0.2fRP.", payment),
        })

    end,
    side_mission_destroy_graveyard_hint = function(numberOfTargets)
        if numberOfTargets > 1 then
            return f("Destroy %d more marked ships on the ship graveyard.", numberOfTargets)
        else
            return "Destroy one more marked ship on the ship graveyard."
        end
    end,

    side_mission_destroy_graveyard_success_comms = function(payment)
        return Util.random({
            "Excellent. You proofed you can shoot on immobile targets.",
        }) .. " " .. Util.random({
            "Should ever again be in need of someone to destroy immovable targets with an oversized beam weapon, we might come back to you.",
            "Don't worry about it: Every good fighter pilot started small.",
            "If you continue to put your shoulder to the wheel, maybe we'll have you shooting at moving targets soon - like the big boys.",
            "Don't listen to people who say that the mission could have been done by a group of Girl Scouts. They're just jealous.",
        }) .. "\n\n" .. Util.random({
            f("Here are your %0.2fRP.", payment),
            f("As agreed you get %0.2fRP from us.", payment),
        }) .. " " .. Util.random({
            "You can buy yourself a medal of cleanness in the next toy shop.",
            "Get yourself an ice cream.",
            "If you invest the money well, you might buy a dollhouse in a few years.",
        })
    end,
})