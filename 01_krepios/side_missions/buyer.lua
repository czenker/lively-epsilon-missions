local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

My.SideMissions.Buyer = function(station, product)
    local person = Person:newHuman()
    local amount = math.floor(station:getMaxProductStorage(product) * (math.random() * 0.15 + 0.1))

    local paymentPerUnit = product.basePrice * (math.random() * 0.3 + 1.2)
    local paymentBonus = product.basePrice * (math.random() * 0.25 + 0.25) * amount

    local mission = Missions:bringProduct(station, {
        product = product,
        amount = amount,
        onStart = function(self)
            local hint = t("side_mission_buyer_hint", amount, product:getName(), station:getCallSign())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        commsLabel = t("side_mission_buyer_comms_label", person),
        sellProductScreen = function(self, screen, player, info)
            if info.justBroughtAmount > 0 then
                screen:addText(t("side_mission_buyer_comms_confirm", info.justBroughtAmount, product:getName(), info.justBroughtAmount * paymentPerUnit))
            else
                screen:addText(t("side_mission_buyer_comms_reminder", product:getName()))
            end
            screen:addText("\n\n" .. t("side_mission_buyer_comms_todo", info.remainingAmount, paymentBonus))
            if player:isDocked(station) then
                if info.maxAmount > 0 then
                    screen:addReply(Comms:newReply(t("side_mission_buyer_comms_sell_label", info.maxAmount), info.link(info.maxAmount)))
                end
                for _,i in ipairs({20,5,1}) do
                    if i < info.maxAmount then
                        screen:addReply(Comms:newReply(t("side_mission_buyer_comms_sell_label", i), info.link(i)))
                    end
                end
            end
            screen:addReply(Comms:newReply(t("generic_button_back")))
        end,
        onDelivery = function(self, amount, player)
            player:addReputationPoints(amount * paymentPerUnit)
            self:setHint(t("side_mission_buyer_hint", self:getTotalAmount() - self:getBroughtAmount(), product:getName(), station:getCallSign()))
        end,
        successScreen = function(self, screen, player)
            screen:addText(t("side_mission_buyer_success", product:getName(), paymentBonus))
        end,
        onSuccess = function(self)
            self:getPlayer():addReputationPoints(paymentBonus)
        end,
    })

    Mission:withBroker(mission, t("side_mission_buyer", product:getName()), {
        description = t("side_mission_buyer_description", person, product:getName(), amount, paymentPerUnit, paymentBonus),
        acceptMessage = t("side_mission_buyer_accept", product:getName(), amount),
    })

    Mission:forPlayer(mission)

    return mission
end