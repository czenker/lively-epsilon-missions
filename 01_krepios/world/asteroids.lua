local t = My.Translator.translate

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

    local randomPosition = function(distance)
        return function()
            local angle = math.random() * (maxAngle - minAngle) + minAngle
            local x,y = vectorFromAngle(angle, distance)

            -- blur position
            local randAngle = math.random() * 360
            local randDistance = math.random(0, My.Config.width)
            local dx, dy = vectorFromAngle(randAngle, randDistance)

            return x + dx, y + dy
        end
    end

    local step = ((maxDistance * maxDistance) - (minDistance * minDistance)) / numberOfAsteroids

    for i=minDistance * minDistance,maxDistance * maxDistance,step do
        local distance = math.sqrt(i)

        local x, y = My.World.Helper.tryMinDistance(randomPosition(distance), isEeAsteroid, avgAsteroidDistance / 2)

        Asteroid():setPosition(x, y):setDescription(t("asteroids_description", My.asteroidName()))
    end
end, -99)