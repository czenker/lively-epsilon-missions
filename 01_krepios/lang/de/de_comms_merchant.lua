local f = string.format

My.Translator:register("de", {
    comms_merchant_label = "Händler",
    comms_merchant_main_sold = "Wir verkaufen:",
    comms_merchant_main_sold_item = function(productName, productPrice)
        return f(" * %s   für   %0.2fRP   pro Einheit", productName, productPrice)
    end,
    comms_merchant_main_sold_label = "Etwas kaufen",
    comms_merchant_main_bought = "Wir kaufen:",
    comms_merchant_main_bought_item = function(productName, productPrice)
        return f(" * %s   für   %0.2fRP   pro Einheit", productName, productPrice)
    end,
    comms_merchant_main_bought_label = "Etwas verkaufen",



    comms_merchant_detail_sold = "Wir verkaufen:",
    comms_merchant_detail_sold_item = function(maxAmount, productName, productPrice)
        return f(" * %d   x   %s   für   %0.2fRP   pro Einheit", maxAmount, productName, productPrice)
    end,
    comms_merchant_detail_sold_label = function(productName)
        return productName .. " kaufen"
    end,
    comms_merchant_sell_not_available = function(productName)
        return "Aufgrund der hohen Nachfrage können wir " .. productName .. " im Augenblick nicht anbieten."
    end,
    comms_merchant_sell = function(maxAmount, productName, productPrice)
        return f("Wir können Ihnen bis zu   %d   Einheiten   %s   zu einem Stückpreis von   %0.2fRP   verkaufen.", maxAmount, productName, productPrice)
    end,
    comms_merchant_sell_reply_not_docked = "Danke für die Information",
    comms_merchant_sell_reply_not_storable = "Unser Lagerraum ist voll",
    comms_merchant_sell_reply_not_affordable = "Das ist zu teuer für uns",
    comms_merchant_sell_response = function(amount)
        if amount == 1 then
            return "1 Einheit"
        else
            return f("%d Einheiten", amount)
        end
    end,
    comms_merchant_sell_response_add = function(amount)
        if amount == 1 then
            return "+1 Einheit"
        else
            return f("+%d Einheiten", amount)
        end
    end,
    comms_merchant_sell_response_confirm = function(amount, productPrice)
        local msg = f("%d", amount) .. " Einheit"
        if amount ~= 1 then
            msg = msg .. "en"
        end
        msg = msg .. f(" für %.2fRP kaufen", productPrice)
        return msg
    end,



    comms_merchant_sell_confirm = function(amount, productName, productPrice)
        return f("%d Einheiten %s wurden in ihr Schiff geladen und %0.2fRP abgebucht.", amount, productName, productPrice)
    end,



    comms_merchant_detail_bought = "Wir kaufen:",
    comms_merchant_detail_bought_item = function(maxAmount, productName, productPrice)
        return f(" * %d   x   %s   für   %0.2fRP   pro Einheit", maxAmount, productName, productPrice)
    end,
    comms_merchant_detail_bought_label = function(productName)
        return productName .. " verkaufen"
    end,
    comms_merchant_buy_not_available = function(productName)
        return "Gegenwärtig haben wir keinen Bedarf an " .. productName .. "."
    end,
    comms_merchant_buy = function(maxAmount, productName, productPrice)
        return f("Wir können Ihnen bis zu   %d   Einheiten   %s   zu einem Stückpreis von   %0.2fRP   abkaufen.", maxAmount, productName, productPrice)
    end,
    comms_merchant_buy_reply_not_docked = "Danke für die Information",
    comms_merchant_buy_reply_not_stored = "Das haben wir nicht gelagert",
    comms_merchant_buy_response = function(amount)
        if amount == 1 then
            return "1 Einheit"
        else
            return f("%d Einheiten", amount)
        end
    end,
    comms_merchant_buy_response_add = function(amount)
        if amount == 1 then
            return "+1 Einheit"
        else
            return f("+%d Einheiten", amount)
        end
    end,
    comms_merchant_buy_response_confirm = function(amount, productPrice)
        local msg = f("%d", amount) .. " Einheit"
        if amount ~= 1 then
            msg = msg .. "en"
        end
        msg = msg .. f(" für %.2fRP verkaufen", productPrice)
        return msg
    end,



    comms_merchant_buy_confirm = function(amount, productName, productPrice)
        return f("Es freut uns mit Ihnen Geschäfte zu machen. %d Einheiten %s uns überstellt und %0.2fRP an Sie überwiesen.", amount, productName, productPrice)
    end,
})