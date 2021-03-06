local t = My.Translator.translate

local isValidPositionForMine = function(thing)
    return isEeMine(thing) or isEeShipTemplateBased(thing) or isEeSupplyDrop(thing)
end

local randomDropContent = function(danger)
    local rnd = math.random(1,4)
    if rnd == 1 then
        return {
            energy = Util.round(100 + (danger + 1) * (math.random() * 100), 10),
            reputation = 80 + (danger + 1) * (math.random() * 10),
        }
    elseif rnd == 2 then
        -- weapon drop
        return {
            [products.homing] = math.random(1, 1 + danger),
            [products.hvli] = math.random(1, 1 + danger),
        }
    elseif rnd == 3 then
        -- machinery drop
        return {
            [products.miningMachinery] = math.random(1, 1 + danger),
            energy = Util.round(100 + (danger + 1) * (math.random() * 100), 10),
        }
    else
        -- ore drop
        return {
            [products.ore] = math.random(4, 4 + danger*3),
            [products.plutoniumOre] = math.random(0, danger * 2),
        }
    end
end

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
        end, 10000)

        My.World.Helper.eraseAsteroidsAround(x, y, 2000)

        local shipCallSign = My.civilianShipName()
        local danger = math.random(0, 4)

        local dropX, dropY = Util.addVector(x, y, math.random(0, 359), math.random(100, 750))
        local shipX, shipY = Util.addVector(dropX, dropY, math.random(0, 359), math.random(500, 1750))

        local drop
        drop = My.SupplyDrop(dropX, dropY, randomDropContent(danger))
        drop:setScannedDescription(
            t("drops_description_full", shipCallSign) .. drop:getContentText()
        )

        local ship
        ship = My.WreckedCpuShip("Goods Freighter " .. math.random(1,5)):
        setCallSign(shipCallSign):
        setPosition(shipX, shipY):
        setScanningParameters(1, 1):
        setScannedDescription(t("drops_ship_description", shipCallSign))

        table.insert(My.World.drops, drop)

        local randomMinePosition = function()
            local angle = math.random() * 360
            local distance = math.random(800, 5000)

            local dx, dy = vectorFromAngle(angle, distance)
            return x + dx, y + dy
        end

        for j=1,math.random(16,16 + danger * 4) do
            local x,y = My.World.Helper.tryMinDistance(randomMinePosition, isValidPositionForMine, 1500)
            My.World.Helper.eraseAsteroidsAround(x, y, 600)
            Mine():setPosition(x, y)
        end
    end


end, 60)
