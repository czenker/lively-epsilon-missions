local t = My.Translator.translate

local newNebula = function(artifact, clouds)
    local usage, usageData = nil, nil

    return {
        getArtifact = function() return artifact end,
        getName = function() return artifact:getCallSign() or "unknown" end,
        getRandomPosition = function()
            local cloud = Util.random(clouds)
            local x, y = cloud:getPosition()
            local dx, dy = Util.vectorFromAngle(math.random(0, 359), math.random(0, 3000))
            return x + dx, y + dy
        end,
        getPosition = function() return artifact:getPosition() end,
        getSectorName = function() return artifact:getSectorName() end,
        countClouds = function() return Util.size(clouds) end,
        setUse = function(self, use, data)
            usage, usageData = use, data
            return self
        end,
        hasUse = function() return usage ~= nil end,
        getUse = function() return usage, usageData end,
    }
end

My.EventHandler:register("onWorldCreation", function()
    local divAngle = 360 * 60000 / math.pi / My.Config.avgDistance

    local minAngle = My.Config.avgAngle - divAngle
    local originX, originY = My.World.planet:getPosition()

    local randomPosition = function()
        local angle = math.random() * 2 * divAngle + minAngle
        local distance = My.Config.avgDistance - My.Config.width * 1.5 + math.random() * My.Config.width * 3

        local x, y = vectorFromAngle(angle, distance)
        return originX + x, originY + y
    end

    My.World.nebulas = {}

    for i=1,9 do
        local x, y = My.World.Helper.tryMinDistance(randomPosition, function(thing)
            return isEeStation(thing) or isEeArtifact(thing) or isEeNebula(thing)
        end, 15000)
        local artifact = Artifact():
        setModel("does_not_exist"):
        setPosition(x, y):
        allowPickup(false):
        setCallSign(My.nebulaName())

        local clouds = {}

        local randomNebulaPosition = function()
            local angle = math.random() * 360
            local distance = math.random(0, 10000)

            local dx, dy = vectorFromAngle(angle, distance)
            return x + dx, y + dy
        end

        local numNebulas = math.random(3,7)
        for j=1,numNebulas do
            local cloud = Nebula():setPosition(My.World.Helper.tryMinDistance(randomNebulaPosition, isEeNebula, 3000))
            table.insert(clouds, cloud)
        end

        -- fix position of the artifact so it is in the middle of the clouds
        local sumX, sumY = 0, 0
        for _,cloud in pairs(clouds) do
            local dx, dy = cloud:getPosition()
            sumX, sumY = sumX + dx, sumY + dy
        end
        artifact:setPosition(sumX / numNebulas, sumY / numNebulas)

        table.insert(My.World.nebulas, newNebula(artifact, clouds))
    end
end, 40)

My.EventHandler:register("onStart", function()
    for _, nebula in pairs(My.World.nebulas) do
        -- description is set even though it is not displayed in Science (yet). But it can be used in scripts.
        local artifact = nebula:getArtifact()
        local description
        local use, usageData = nebula:getUse()
        if use == "science" then
            description = t("nebulas_description_research", artifact:getCallSign(), nebula:countClouds(), artifact:getSectorName(), usageData:getCallSign())
        elseif use == "battlefield" then
            description = t("nebulas_description_battlefield", artifact:getCallSign(), nebula:countClouds(), artifact:getSectorName())
        else
            description = t("nebulas_description", artifact:getCallSign(), nebula:countClouds(), artifact:getSectorName())
        end
        artifact:setDescription(description)
    end
end)
