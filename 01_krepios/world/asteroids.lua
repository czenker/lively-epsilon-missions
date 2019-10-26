local My = My or {}
local t = My.Translator.translate
local f = string.format

local dropDespawnTime = 300

My.Asteroid = function()
    local asteroid = Asteroid()
    local name = My.asteroidName()
    local description = t("asteroids_description", name)

    local contentOre, contentPlutonium = (function()
        -- generate a random distribution of ores
        local ore, plutonium = 0, 0

        if math.random(0, 3) > 0 then
            ore = math.random(0, 250)
        end
        if math.random(0, 3) == 3 then
            plutonium = math.random(0, 100)
        end
        local other = math.random(100, 1000)
        local total = ore + plutonium + other

        return ore / total * 100, plutonium / total * 100
    end)()

    local updateDescriptions = function()
        local extendedDescription

        if contentOre > 1 or contentPlutonium > 1 then
            extendedDescription = t("asteroids_composition") .. ": " .. f(
                "%0.1f%% %s, %0.1f%% %s",
                contentOre,
                t("products_ore_name"),
                contentPlutonium,
                t("products_plutoniumOre_name")
            )
        else
            extendedDescription = t("asteroids_composition_empty")
        end

        asteroid:setDescriptions(
            description,
            description .. " " .. extendedDescription
        )
    end

    local mineResources = function()
        local resources = {
            [products.ore] = 0,
            [products.plutoniumOre] = 0,
        }

        -- mine 10 times to add some randomness
        for _=0,9 do
            -- the higher the concentration - the higher the probability to get a matching ore
            if contentOre >= 1 and math.random(1, 100) <= contentOre then
                resources[products.ore] = resources[products.ore] + 1
                contentOre = contentOre - 1
            end
            if contentPlutonium >= 1 and math.random(1, 100) <= contentPlutonium then
                resources[products.plutoniumOre] = resources[products.plutoniumOre] + 1
                contentPlutonium = contentPlutonium - 1
            end
        end

        updateDescriptions()

        return resources
    end

    asteroid.mine = function(_, miner)
        local resources = mineResources()
        local totalAmount = 0
        for _, amount in pairs(resources) do
            totalAmount = totalAmount + amount
        end

        local aX, aY = asteroid:getPosition()
        local pX, pY = miner:getPosition()
        local angle = Util.angleFromVector(pX - aX, pY - aY) + math.random() * 60 - 30

        local x, y = aX, aY
        x, y = Util.addVector(x, y, angle, 300)
        local impulse = math.random(200, 400)
        local impulseDrag = impulse / 2

        local drop = My.Artifact("ore_chunk"):setPosition(x, y):setFaction(miner:getFaction()):onPickUp(function(_, player)
            if not Player:hasStorage(player) then return end
            for product, amount in pairs(resources) do
                if amount == 0 then
                    -- noop
                elseif player:getEmptyProductStorage(product) >= amount then
                    player:modifyProductStorage(product, amount)
                else
                    local remainingAmount = amount - player:getEmptyProductStorage(product)
                    logWarning(f("%d of %s could not be picked up, because storage is full.", remainingAmount, product:getName()))
                    player:modifyProductStorage(product, player:getEmptyProductStorage(product))
                end
            end
        end)

        if totalAmount > 0 then
            local dropDescription = {}
            for product, amount in pairs(resources) do
                if amount > 0 then
                    table.insert(dropDescription, f("%d %s", amount, product:getName()))
                end
            end

            drop:setScannedDescription(t("asteroids_chunk_description") .. " " .. Util.mkString(
                    dropDescription,
                ", ",
                " " .. t("generic_and") .. " "
            ) .. ".")
        else
            drop:setScannedDescription(t("asteroids_chunk_empty_description"))
        end

        Cron.regular(function(self, delta)
            -- animate movement of supply crate
            -- don't overdo it as it will be bumpy on remote screens
            if not drop:isValid() then
                Cron.abort(self)
                return
            end
            local x, y = drop:getPosition()
            x, y = Util.addVector(x, y, angle, impulse * delta)

            drop:setPosition(x, y)
            impulse = impulse - impulseDrag * delta
            if impulse < 0 then
                Cron.abort(self)
                return
            end
        end)

        -- despawn drop automatically
        Cron.once(function()
            if drop:isValid() then drop:destroy() end
        end, dropDespawnTime)

        return resources, drop
    end

    updateDescriptions()

    asteroid:setScanningParameters(1,1)

    return asteroid
end

My.EventHandler:register("onWorldCreation", function()
    local avgAsteroidDistance = My.Config.avgAsteroidDistance
    local minDistance = My.Config.avgDistance - My.Config.width / 2
    local maxDistance = My.Config.avgDistance + My.Config.width / 2
    local minAngle = My.Config.avgAngle - My.Config.segment / 2
    local maxAngle = My.Config.avgAngle + My.Config.segment / 2

    local numberOfAsteroids = math.floor(
            ((maxDistance * maxDistance) - (minDistance * minDistance)) / 360 * (maxAngle - minAngle) / ((avgAsteroidDistance * avgAsteroidDistance))
    )

    logInfo("Creating " .. numberOfAsteroids .. " Asteroids")
    local originX, originY = My.World.planet:getPosition()

    local randomPosition = function(distance)
        return function()
            local angle = math.random() * (maxAngle - minAngle) + minAngle
            local x,y = vectorFromAngle(angle, distance)

            -- blur position
            local randAngle = math.random() * 360
            local randDistance = math.random(0, My.Config.width)
            local dx, dy = vectorFromAngle(randAngle, randDistance)

            return originX + x + dx, originY + y + dy
        end
    end

    local step = ((maxDistance * maxDistance) - (minDistance * minDistance)) / numberOfAsteroids

    for i=minDistance * minDistance,maxDistance * maxDistance,step do
        local distance = math.sqrt(i)

        local x, y = My.World.Helper.tryMinDistance(randomPosition(distance), isEeAsteroid, avgAsteroidDistance / 2)

        My.Asteroid():setPosition(x, y)
    end
end, -99)