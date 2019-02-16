local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

My.SideMissions.TransportProduct = function(from, to, player)
    local possibleProducts = {}
    if from:hasTag("residual") and to:hasTag("mining") then
        possibleProducts[products.miningMachinery] = products.miningMachinery
    end
    if from:hasTag("mining") and to:hasTag("residual") then
        possibleProducts[products.ore] = products.ore
        possibleProducts[products.plutoniumOre] = products.plutoniumOre
    end
    if from:hasTag("residual") and (to:hasTag("mining") or to:hasTag("science")) then
        possibleProducts[products.power] = products.power
    end

    local product = Util.random(possibleProducts)
    if product == nil then return nil end

    local minAmount = math.floor(player:getMaxStorageSpace() / product:getSize() * 0.4)
    local maxAmount = math.ceil(player:getMaxStorageSpace() / product:getSize() * 1.2) -- give incentive to increase storage space
    local amount = math.random(minAmount,maxAmount)
    if amount == 0 then return nil end

    local payment = My.SideMissions.paymentPerDistance(distance(from, to)) + amount * product.basePrice * (math.random() * 0.1 + 0.1)
    local penalty = amount * product.basePrice
    local mission

    mission = Missions:transportProduct(from, to, product, {
        amount = amount,
        acceptCondition = function(self, error)
            if error == "no_storage" then
                return t("side_mission_transport_product_no_storage")
            elseif error == "small_storage" then
                return t("side_mission_transport_product_small_storage", amount * product:getSize())
            elseif self:getPlayer():getReputationPoints() < penalty then
                return t("side_mission_transport_product_no_penalty")
            end
            return true
        end,
        onAccept = function(self)
            self:getPlayer():addReputationPoints(-1 * penalty)
            local hint = t("side_mission_transport_product_accept_hint", from:getCallSign(), product:getName())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onLoad = function(self)
            self:getPlayer():addToShipLog(t("side_mission_transport_product_load_log", product:getName()), "255,127,0")
            local hint = t("side_mission_transport_product_load_hint", to:getCallSign(), product:getName())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
            if Station:hasStorage(from) and from:canStoreProduct(product) then
                from:modifyProductStorage(product, -1 * amount)
            end
        end,
        onUnload = function(self)
            if Station:hasStorage(to) and to:canStoreProduct(product) then
                to:modifyProductStorage(product, amount)
            end
        end,
        onInsufficientStorage = function(self)
            mission:getPlayer():addToShipLog(t("side_mission_transport_product_insufficient_storage", product:getName(), amount * product:getSize()), "255,127,0")
        end,
        onProductLost = function(self)
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_transport_product_product_lost", penalty))
        end,
        onSuccess = function(self)
            logInfo("Mission " .. self:getTitle() .. " successful.")
            self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_transport_product_success", payment))
            self:getPlayer():addReputationPoints(payment + penalty)
        end,
        onFailure = function(self)
            logInfo("Mission " .. self:getTitle() .. " failed.")
            if self:getPlayer():isValid() then
                self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
            end
        end,
    })
    Mission:withBroker(mission, t("side_mission_transport_product", amount, product:getName(), to:getCallSign()), {
        description = t("side_mission_transport_description", amount, product:getName(), to:getCallSign(), payment, penalty),
        acceptMessage = nil,
    })
    Mission:withTags(mission, "transport")

    return mission
end