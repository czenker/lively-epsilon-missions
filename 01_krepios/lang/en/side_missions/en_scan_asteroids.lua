local t = My.Translator.translate
local f = string.format

My.Translator:register("en", {
    side_mission_scan_asteroids = function(number)
        return f("Scan %d asteroids", number)
    end,
    side_mission_scan_asteroids_description = function(number, sectorName, payment)
        return Util.random({
            f("Our records on some asteroids in sector %s are outdated.", sectorName),
            f("The SMC asked us to predict our mining quotas for next month. But we can't do that without knowing the mineral concentration of some asteroids in sector %s.", sectorName),
            f("Our miners gave us contradicting mineral concentration numbers on some asteroids in %s. We are looking for someone to check which ones are right.", sectorName),
        }) .. " " .. Util.random({
            "So we need you to fly there and get the latest data for us.",
            "You need to go there and get those numbers for us.",
            "Get your ship ready and get this data for us.",
        }) .. "\n\n" .. Util.random({
            f("We will pay you %0.2fRP if you take the job.", payment),
            f("%0.2fRP if you take the job. That's easy money.", payment),
            f("%0.2fRP is a payment you can't deny.", payment),
        })
    end,
    side_mission_scan_asteroids_accept = function(asteroidNames, sectorName)
        return Util.random({
            f("Alright. Now this is your work assignment: Scan the following asteroids in sector %s:", sectorName),
            f("Do the following. Fly to sector %s and scan these asteroids there:", sectorName),
            f("Your work assignment is to scan these asteroids in sector %s:", sectorName),
        }) .. "\n\n" .. Util.mkString(Util.map(asteroidNames, function(asteroidName) return "  * " .. asteroidName end), "\n") .. "\n\n" .. Util.random({
            "Do you understand?",
            "Now hurry. You are not payed for slacking off.",
            "Stop standing around and do as I said.",
            "I'm your superior on this mission. So get to work NOW!",
        })
    end,
    side_mission_scan_asteroids_short_hint = function(numberOfAsteroids)
        if numberOfAsteroids > 1 then
            return f("Scan %d more asteroids.", numberOfAsteroids)
        else
            return "Scan one more asteroid."
        end
    end,
    side_mission_scan_asteroids_hint = function(asteroidNames, sectorName)
        return "Scan the following asteroids in sector " .. sectorName .. ": " .. Util.mkString(asteroidNames, ", ", " " .. t("generic_and") .. " ")
    end,
    side_mission_scan_asteroids_success = function(payment)
        return Util.random({
            f("So, here are your %0.2fRP for scanning those asteroids.", payment),
            f("Your job is finished. Your reward is %0.2fRP.", payment),
        }) .. " " .. Util.random({
            "Don't waste it all on drinks.",
            "Contact us to get your next assignment.",
        })
    end,
})