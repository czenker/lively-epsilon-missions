local f = string.format

My.Translator:register("en", {
    comms_merchant_label = "Trader",
    comms_merchant_main_sold = "We sell:",
    comms_merchant_main_sold_item = function(productName, productPrice)
        return f(" * %s   for   %0.2fRP   per unit", productName, productPrice)
    end,
    comms_merchant_main_sold_label = "Buy something",
    comms_merchant_main_bought = "We buy:",
    comms_merchant_main_bought_item = function(productName, productPrice)
        return f(" * %s   for   %0.2fRP   per unit", productName, productPrice)
    end,
    comms_merchant_main_bought_label = "Sell something",



    comms_merchant_detail_sold = "We sell:",
    comms_merchant_detail_sold_item = function(maxAmount, productName, productPrice)
        return f(" * %d   x   %s   for   %0.2fRP   per unit", maxAmount, productName, productPrice)
    end,
    comms_merchant_detail_sold_label = function(productName)
        return "Buy " .. productName
    end,
    comms_merchant_sell_not_available = function(productName)
        return "Due to high demand we can't sell " .. productName .. " at the moment."
    end,
    comms_merchant_sell = function(maxAmount, productName, productPrice)
        return f("We can sell up to   %d   units of   %s   at a unit price of   %0.2fRP.", maxAmount, productName, productPrice)
    end,
    comms_merchant_sell_reply_not_docked = "Thanks for the information",
    comms_merchant_sell_reply_not_storable = "Our storage is full",
    comms_merchant_sell_reply_not_affordable = "We can not afford that",
    comms_merchant_sell_response = function(amount)
        if amount == 1 then
            return "1 unit"
        else
            return f("%d units", amount)
        end
    end,
    comms_merchant_sell_response_add = function(amount)
        if amount == 1 then
            return "+1 unit"
        else
            return f("+%d units", amount)
        end
    end,
    comms_merchant_sell_response_confirm = function(amount, productPrice)
        local msg
        if amount == 1 then
            msg = "1 unit"
        else
            msg = f("%d", amount) .. " units"
        end
        msg = "buy " .. msg .. f(" for %.2fRP", productPrice)
        return msg
    end,



    comms_merchant_sell_confirm = function(amount, productName, productPrice)
        return f("%d units of %s were loaded on your ship and %0.2fRP charged.", amount, productName, productPrice)
    end,



    comms_merchant_detail_bought = "We buy:",
    comms_merchant_detail_bought_item = function(maxAmount, productName, productPrice)
        return f(" * %d   x   %s   for   %0.2fRP   per unit", maxAmount, productName, productPrice)
    end,
    comms_merchant_detail_bought_label = function(productName)
        return "sell " .. productName
    end,
    comms_merchant_buy_not_available = function(productName)
        return "Currently we have no need for " .. productName .. "."
    end,
    comms_merchant_buy = function(maxAmount, productName, productPrice)
        return f("We would buy up to   %d   units of   %s   at a unit price of   %0.2fRP.", maxAmount, productName, productPrice)
    end,
    comms_merchant_buy_reply_not_docked = "Thanks for the information",
    comms_merchant_buy_reply_not_stored = "We do not have that in storage",
    comms_merchant_buy_response = function(amount)
        if amount == 1 then
            return "1 unit"
        else
            return f("%d units", amount)
        end
    end,
    comms_merchant_buy_response_add = function(amount)
        if amount == 1 then
            return "+1 unit"
        else
            return f("+%d units", amount)
        end
    end,
    comms_merchant_buy_response_confirm = function(amount, productPrice)
        local msg = f("%d", amount) .. " unit"
        if amount ~= 1 then
            msg = msg .. "s"
        end
        msg = "sell " .. msg .. f(" for %.2fRP", productPrice)
        return msg
    end,



    comms_merchant_buy_confirm = function(amount, productName, productPrice)
        return f("We are happy to do business with you. %d units of %s where unloaded from your ship, and we transferred %0.2fRP to you.", amount, productName, productPrice)
    end,
})