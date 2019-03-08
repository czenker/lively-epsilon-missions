local f = string.format
local t = My.Translator.translate

local units = function(amount)
    if amount > 1 then
        return amount .. " Einheiten"
    else
        return "eine Einheit"
    end
end
local Units = function(amount)
    if amount > 1 then
        return amount .. " Einheiten"
    else
        return "Eine Einheit"
    end
end

My.Translator:register("de", {
    side_mission_buyer = function(productName)
        return productName .. " besorgen"
    end,
    side_mission_buyer_description = function(clientPerson, productName, amount, paymentPerUnit, paymentBonus)
        return t("comms_generic_introduction", clientPerson) .. "\n\n" .. Util.random({
            f("Könnt ihr für mich %s %s organisieren?", units(amount), productName),
            f("Ich bin auf der Suche nach %s %s.", units(amount), productName),
            f("Ich brauche einen Händler, der mir %s %s besorgen kann.", units(amount), productName),
            f("Ihr könntet mir dabei helfen, %s %s zu besorgen.", units(amount), productName),
        }) .. " " .. Util.random({
            f("Ich zahle gut - %0.2fRP pro gelieferte Einheit und noch einmal %0.2fRP als Bonus, wenn alles geliefert ist.", paymentPerUnit, paymentBonus),
        })
    end,
    side_mission_buyer_accept = function(productName, amount)
        return Util.random({
            f("Sehr gut. Ich warte hier auf euch und auf die %s %s.", units(amount), productName)
        }) .. " " .. Util.random({
            "Es ist mir egal, woher ihr das Zeug besorgt, Hauptsache ich muss nicht ewig warten."
        })
    end,
    side_mission_buyer_hint = function(amount, productName, stationCallSign)
        return f("Bringen Sie %s %s nach %s.", units(amount), productName, stationCallSign)
    end,
    side_mission_buyer_comms_label = function(clientPerson)
        return f("Mit %s sprechen", clientPerson:getFormalName())
    end,
    side_mission_buyer_comms_confirm = function(amount, productName, payment)
        return f("%s %s erhalten, %0.2fRP überwiesen.", Units(amount), productName, payment)
    end,
    side_mission_buyer_comms_reminder = function(productName)
        return Util.random({
            f("Hey, denkt ihr an die Einheiten %s?", productName),
            f("Ihr habt noch nicht alle Einheiten %s geliefert.", productName),
        })
    end,
    side_mission_buyer_comms_todo = function(missingAmount, paymentBonus)
        return Util.random({
            f("Es fehlen noch %d Einheiten.", missingAmount),
        }) .. " " .. Util.random({
            f("Und denkt an den Bonus von %0.2fRP, den ich euch zahle, sobald die Lieferung komplett ist.", paymentBonus)
        })
    end,
    side_mission_buyer_comms_sell_label = function(amount)
        return Units(amount) .. " verkaufen"
    end,
    side_mission_buyer_success = function(productName, paymentBonus)
        return Util.random({
            f("Das war die letzte Ladung %s, die ihr liefern solltet.", productName),
            f("Die letzte Lieferung %s ist angekommen.", productName),
        }) .. " " .. Util.random({
            "Vielen Dank für die schnelle Lieferung."
        }) .. " " .. Util.random({
            f("Wie versprochen habe ich euch zusätzlich den Bonus in Höhe von %0.2fRP überwiesen.", paymentBonus),
        })
    end,
})