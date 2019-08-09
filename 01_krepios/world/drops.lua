local t = My.Translator.translate

-- distribute some mine fields with treasures inside
My.EventHandler:register("onWorldCreation", function()
    local divAngle = 360 * 60000 / math.pi / My.Config.avgDistance

    local minAngle = My.Config.avgAngle - divAngle
    local originX, originY = My.World.planet:getPosition()

    local randomPosition = function()
        local angle = math.random() * 2 * divAngle + minAngle
        local distance = My.Config.avgDistance - My.Config.width + math.random() * My.Config.width * 2

        local x, y = vectorFromAngle(angle, distance)
        return originX + x, originY + y
    end

    for i=1,5 do
        local x, y = My.World.Helper.tryMinDistance(randomPosition, function(thing)
            return isEeStation(thing) or isEeArtifact(thing) or isEeSupplyDrop(thing)
        end, 15000)

        local shipCallSign = My.civilianShipName()
        local danger = math.random(0, 4)
        local value = 80 + (danger + 1) * (math.random() * 10)
        local energy = Util.round(100 + (danger + 1) * (math.random() * 100), 10)

        local drop
        drop = SupplyDrop():
        setFaction("Player"):
        setPosition(x, y):
        setCallSign(t("drops_name")):
        onPickUp(function(_, player)
            logInfo("SupplyDrop at " .. drop:getSectorName() .. " was picked up.")
            -- this line is unfortunately necessary to avoid the "[convert<ScriptSimpleCallback>::param] Upvalue 1 of function is not a table" error
            local msg = t("drops_pickup", value, energy)
            player:addCustomMessage("helms", Util.randomUuid(), msg)
            player:addToShipLog(msg, "255,127,0")
            player:addReputationPoints(value)
            player:setEnergy(player:getEnergy() + energy)
        end):
        setDescriptions(
            t("drops_description_unknown"),
            t("drops_description_full", shipCallSign, value, energy)
        ):
        setScanningParameters(1, 1)

        table.insert(My.World.drops, drop)

        local randomMinePosition = function()
            local angle = math.random() * 360
            local distance = math.random(800, 5000)

            local dx, dy = vectorFromAngle(angle, distance)
            return x + dx, y + dy
        end

        for j=1,math.random(16,16 + danger * 4) do
            local x,y = My.World.Helper.tryMinDistance(randomMinePosition, isEeMine, 1500)
            My.World.Helper.eraseAsteroidsAround(x, y, 2000)
            local mine = Mine():setPosition(x, y)
        end
    end


end, 60)
