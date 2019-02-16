local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

local steps = {20, 5, 1}

My.Comms.Merchant = Comms:merchantFactory({
    -- the label that leads to these commands
    label = t("comms_merchant_label"),

    -- the initial screen that the player sees
    mainScreen = function(screen, comms_target, comms_source, config)
        --
        -- We sell...
        --
        if Util.size(config.selling) > 0 then
            screen:addText(t("comms_merchant_main_sold") .. "\n\n")

            screen:addText(Util.mkString(Util.map(config.selling, function(sold)
                return t("comms_merchant_main_sold_item", sold.product:getName(), sold.price)
            end), "\n"))

            screen:addReply(Comms:newReply(t("comms_merchant_main_sold_label"), config.linkToSellScreen))
        end

        if Util.size(config.selling) > 0 and Util.size(config.buying) > 0 then screen:addText("\n\n") end

        --
        -- We buy...
        --
        if Util.size(config.buying) > 0 then
            screen:addText(t("comms_merchant_main_bought") .. "\n\n")

            screen:addText(Util.mkString(Util.map(config.buying, function(bought)
                return t("comms_merchant_main_bought_item", bought.product:getName(), bought.price)
            end), "\n"))

            screen:addReply(Comms:newReply(t("comms_merchant_main_bought_label"), config.linkToBuyScreen))
        end

        screen:addReply(Comms:newReply(t("generic_button_back")))
    end,

    -- the screen the player sees when they say they want to buy something
    buyScreen = function(screen, comms_target, comms_source, config)
        if Util.size(config.buying) > 0 then
            screen:addText(t("comms_merchant_detail_bought") .. "\n\n")
            for _, bought in pairs(config.buying) do
                local product = bought.product
                screen:addText(t("comms_merchant_detail_bought_item", bought.stationAmount, product:getName(), bought.price) .. "\n")
                screen:addReply(Comms:newReply(t("comms_merchant_detail_bought_label", product:getName()), bought.link))
            end
            screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToMainScreen))
        end
    end,

    -- the screen the player sees when they selected a product they want to buy
    buyProductScreen = function(screen, comms_target, comms_source, config)
        local product = config.product
        if config.stationAmount == 0 then
            screen:addText(t("comms_merchant_buy_not_available", product:getName()))
            screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToBuyScreen))
        else
            screen:addText(t("comms_merchant_buy", config.stationAmount, product:getName() , config.price))
            if not config.isDocked then
                screen:addReply(Comms:newReply(t("comms_merchant_buy_reply_not_docked"), config.linkToBuyScreen))
            elseif config.playerAmount == 0 then
                screen:addReply(Comms:newReply(t("comms_merchant_buy_reply_not_stored"), config.linkToBuyScreen))
            else
                if config.amount > 0 then
                    screen:addReply(Comms:newReply(t("comms_merchant_buy_response_confirm", config.amount, config.cost), config.linkConfirm(config.amount)))
                else
                    screen:addReply(Comms:newReply(t("comms_merchant_buy_response_confirm", config.maxTradableAmount, (config.maxTradableAmount * config.price)), config.linkConfirm(config.maxTradableAmount)))
                end
                for _,i in ipairs(steps) do
                    if config.maxTradableAmount - config.amount >= i then
                        local label
                        if config.amount == 0 then
                            label = t("comms_merchant_buy_response", i)
                        else
                            label = t("comms_merchant_buy_response_add", i)
                        end
                        screen:addReply(Comms:newReply(label, config.linkAmount(config.amount + i)))
                    end
                end
                screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToBuyScreen))
            end
        end
    end,

    -- here is the place to thank the player for their offer
    buyProductConfirmScreen = function(screen, comms_target, comms_source, config)
        local product = config.product
        screen:addText(t("comms_merchant_buy_confirm", config.amount, product:getName(), config.cost))
        screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToMainScreen))

        return true
    end,

    -- the screen the player sees when they say they want to sell something
    sellScreen = function(screen, comms_target, comms_source, config)
        if Util.size(config.selling) > 0 then
            screen:addText(t("comms_merchant_detail_sold") .. "\n\n")
            for _, sold in pairs(config.selling) do
                local product = sold.product
                screen:addText(t("comms_merchant_detail_sold_item", sold.stationAmount, product:getName(), sold.price) .. "\n")
                screen:addReply(Comms:newReply(t("comms_merchant_detail_sold_label", product:getName()), sold.link))
            end
            screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToMainScreen))
        end
    end,

    -- the screen the player sees when they selected a product they want to sell
    sellProductScreen = function(screen, comms_target, comms_source, config)
        local product = config.product
        if config.stationAmount == 0 then
            screen:addText(t("comms_merchant_sell_not_available", product:getName()))
            screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToSellScreen))
        else
            screen:addText(t("comms_merchant_sell", config.stationAmount, product:getName(), config.price))
            if not config.isDocked then
                screen:addReply(Comms:newReply(t("comms_merchant_sell_reply_not_docked"), config.linkToSellScreen))
            elseif config.playerAmount == 0 then
                screen:addReply(Comms:newReply(t("comms_merchant_sell_reply_not_storable"), config.linkToSellScreen))
            elseif config.affordableAmount == 0 then
                screen:addReply(Comms:newReply(t("comms_merchant_sell_reply_not_affordable"), config.linkToSellScreen))
            else
                if config.amount > 0 then
                    screen:addReply(Comms:newReply(t("comms_merchant_sell_response_confirm", config.amount, config.cost), config.linkConfirm(config.amount)))
                else
                    screen:addReply(Comms:newReply(t("comms_merchant_sell_response_confirm", config.maxTradableAmount, (config.maxTradableAmount * config.price)), config.linkConfirm(config.maxTradableAmount)))
                end
                for _,i in ipairs(steps) do
                    if config.maxTradableAmount - config.amount >= i then
                        local label
                        if config.amount == 0 then
                            label = t("comms_merchant_sell_response", i)
                        else
                            label = t("comms_merchant_sell_response_add", i)
                        end
                        screen:addReply(Comms:newReply(label, config.linkAmount(config.amount + i)))
                    end
                end
                screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToSellScreen))
            end
        end
    end,

    -- here is the place to thank the player for their purchase
    sellProductConfirmScreen = function(screen, comms_target, comms_source, config)
        local product = config.product
        screen:addText(t("comms_merchant_sell_confirm", config.amount, product:getName(), config.cost))
        screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToMainScreen))

        return true
    end,
    displayCondition = function(station, player)
        return not station:hasTag("mute") and not station:isEnemy(player)
    end,
})
