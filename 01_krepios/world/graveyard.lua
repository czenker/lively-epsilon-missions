local t = My.Translator.translate

local isValidPositionForGraveyard = function(thing)
    return isEeMine(thing) or isEeShipTemplateBased(thing)
end

local isValidPositionForShip = function(thing)
    return isEeMine(thing) or isEeShipTemplateBased(thing)
end

-- create ship graveyards
My.EventHandler:register("onWorldCreation", function()
    local divAngle = 360 * 30000 / math.pi / My.Config.avgDistance

    local minAngle = My.Config.avgAngle - divAngle
    local originX, originY = My.World.planet:getPosition()

    local randomPosition = function()
        local angle = math.random() * 2 * divAngle + minAngle
        local distance = My.Config.avgDistance - My.Config.width + math.random() * My.Config.width * 2

        local x, y = vectorFromAngle(angle, distance)
        return originX + x, originY + y
    end

    for i=1,5 do
        local x, y = My.World.Helper.tryMinDistance(randomPosition, isValidPositionForGraveyard, 5000)

        local randomShipPosition = function()
            local dx, dy = math.random(-1000, 1000), math.random(-1000, 1000)
            return x + dx, y + dy
        end

        for j=1,math.random(7,10) do
            local x,y = My.World.Helper.tryMinDistance(randomShipPosition, isValidPositionForShip, 200)
            My.World.Helper.eraseAsteroidsAround(x, y, 200)

            local shipCallSign = My.civilianShipName()

            My.WreckedCpuShip(Util.random({
                "MU52 Hornet",
                "MT52 Hornet",
                "Adder MK4",
                "Adder MK5",
                "Adder MK6",
                "Personnel Freighter " .. math.random(1,5),
                "Goods Freighter " .. math.random(1,5),
            })):
            setCallSign(shipCallSign):
            setPosition(x, y):
            setScanningParameters(1, 1):
            setScannedDescription(t("graveyard_ship_description", shipCallSign))
        end

        local shipGraveyard = {
            getPosition = function() return x,y end,
        }

        table.insert(My.World.shipGraveyards, shipGraveyard)
    end
end, 70)
