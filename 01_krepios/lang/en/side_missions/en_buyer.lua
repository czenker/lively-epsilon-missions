local f = string.format
local t = My.Translator.translate

local units = function(amount)
    if amount > 1 then
        return amount .. " units"
    else
        return "one unit"
    end
end
local Units = function(amount)
    if amount > 1 then
        return amount .. " units"
    else
        return "One unit"
    end
end

My.Translator:register("en", {
    side_mission_buyer = function(productName)
        return "provide " .. productName
    end,
    side_mission_buyer_description = function(clientPerson, productName, amount, paymentPerUnit, paymentBonus)
        return t("comms_generic_introduction", clientPerson) .. "\n\n" .. Util.random({
            f("Can you provide me %s of %s?", units(amount), productName),
            f("I am in demand of %s of %s.", units(amount), productName),
            f("I'm in need of a trader who can provide me %s of %s.", units(amount), productName),
            f("You could help me by supplying me with %s of %s.", units(amount), productName),
        }) .. " " .. Util.random({
            f("I am paying well - %0.2fRP for every unit delivered plus a bonus of %0.2fRP as soon as you delivered the whole shipment.", paymentPerUnit, paymentBonus),
        })
    end,
    side_mission_buyer_accept = function(productName, amount)
        return Util.random({
            f("Very good. I am staying here waiting for you and the %s of %s.", units(amount), productName)
        }) .. " " .. Util.random({
            "I don't really care where you get the stuff from if only you do not keep me waiting for too long."
        })
    end,
    side_mission_buyer_hint = function(amount, productName, stationCallSign)
        return f("Bring %s of %s to %s.", units(amount), productName, stationCallSign)
    end,
    side_mission_buyer_comms_label = function(clientPerson)
        return f("Talk to %s.", clientPerson:getFormalName())
    end,
    side_mission_buyer_comms_confirm = function(amount, productName, payment)
        return f("%s of %s received, %0.2fRP paid.", Units(amount), productName, payment)
    end,
    side_mission_buyer_comms_reminder = function(productName)
        return Util.random({
            f("Hey, you still remember the %s, right?", productName),
            f("You have not yet delivered all units of %s.", productName),
        })
    end,
    side_mission_buyer_comms_todo = function(missingAmount, paymentBonus)
        return Util.random({
            f("Still %d units missing.", missingAmount),
        }) .. " " .. Util.random({
            f("And remember the bonus of %0.2fRP, which you will receive once the whole shipment is delivered.", paymentBonus)
        })
    end,
    side_mission_buyer_comms_sell_label = function(amount)
        return "sell " .. units(amount)
    end,
    side_mission_buyer_success = function(productName, paymentBonus)
        return Util.random({
            f("That was the last shipment of %s.", productName),
            f("I have received the last shipment of %s.", productName),
        }) .. " " .. Util.random({
            "Thank you for the fast delivery."
        }) .. " " .. Util.random({
            f("As promised, I transferred the bonus of %0.2fRP to you.", paymentBonus),
        })
    end,
})