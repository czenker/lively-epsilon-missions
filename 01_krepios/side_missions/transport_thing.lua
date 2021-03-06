local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

My.SideMissions.TransportThing = function(from, to, player)
    local size = math.random()
    size = size * size + 0.2 -- ensures the size is at the lower border more oftenly
    local amount = math.ceil(size * player:getMaxStorageSpace())
    local payment = My.SideMissions.paymentPerDistance(distance(from, to)) * 1.5
    local timeLimit
    if math.random(0, 1) == 1 then
        local difficulty = math.random(1.0, 2.0)
        timeLimit = distance(from, to) / 120 * difficulty
        payment = payment * (1 + 1/difficulty * 0.2)
    end

    local possibleStories = {}

    if from:hasTag("residual") and to:hasTag("mining") then
        table.insert(possibleStories, "alcohol")
    end
    if from:hasTag("residual") or to:hasTag("residual") then
        table.insert(possibleStories, "letters")
    end
    if from:hasTag("mining") and to:hasTag("science") then
        table.insert(possibleStories, "minerals")
    end
    table.insert(possibleStories, "memory")

    local story = Util.random(possibleStories)
    if story == nil then return nil end

    local product = Product:new(t("side_mission_transport_thing_product_" .. story))
    local description = t("side_mission_transport_thing_description_" .. story, to:getCallSign(), amount, payment)
    if not isNil(timeLimit) then
        description = description .. "\n\n" .. t("side_mission_transport_thing_time_limit", timeLimit / 60)
    end

    local mission

    mission = Missions:transportProduct(from, to, product, {
        amount = amount,
        acceptCondition = function(self, error)
            if error == "no_storage" then
                return t("side_mission_transport_thing_no_storage")
            elseif error == "small_storage" then
                return t("side_mission_transport_thing_small_storage", amount * product:getSize())
            end
            return true
        end,
        onAccept = function(self)
            local hint = t("side_mission_transport_thing_accept_hint", from:getCallSign(), product:getName())
            self:setHint(function()
                local text = hint
                if Mission:isTimeLimitMission(self) then
                    text = text .. "\n" .. t("generic_mission_time_limit", self:getRemainingTime() / 60)
                end
                return text
            end)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onLoad = function(self)
            self:getPlayer():addToShipLog(t("side_mission_transport_thing_load_log", product:getName()), "255,127,0")
            local hint = t("side_mission_transport_thing_load_hint", to:getCallSign(), product:getName())
            self:setHint(function()
                local text = hint
                if Mission:isTimeLimitMission(self) then
                    text = text .. "\n" .. t("generic_mission_time_limit", self:getRemainingTime() / 60)
                end
                return text
            end)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onInsufficientStorage = function(self)
            mission:getPlayer():addToShipLog(t("side_mission_transport_thing_insufficient_storage", product:getName(), amount * product:getSize()), "255,127,0")
        end,
        onSuccess = function(self)
            to:sendCommsMessage(self:getPlayer(), t("side_mission_transport_thing_success", payment))
            self:getPlayer():addReputationPoints(payment)
        end,
        onFailure = function(self)
            if self:getPlayer():isValid() and to:isValid() then
                to:sendCommsMessage(self:getPlayer(), t("side_mission_transport_thing_time_out"))
            end
        end,
        onEnd = function(self)
            if self:getPlayer():isValid() then
                self:getPlayer():modifyProductStorage(product, -999) -- make sure storage is not blocked
            end
        end,
    })

    if not isNil(timeLimit) then
        Mission:withTimeLimit(mission, timeLimit)
    end

    Mission:withBroker(mission, t("side_mission_transport_thing", product:getName(), to:getCallSign()), {
        description = description,
        acceptMessage = nil,
    })

    return mission
end