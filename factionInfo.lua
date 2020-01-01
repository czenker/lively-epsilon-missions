--
neutral = FactionInfo():setName("Independent")
neutral:setGMColor(128, 128, 128)

--
abandoned = FactionInfo():setName("Abandoned")
abandoned:setGMColor(128, 128, 128)

--
traders = FactionInfo():setName("Free Trader")
traders:setGMColor(128, 128, 128)

-- the player
player = FactionInfo():setName("Player")
player:setGMColor(255, 255, 255)

-- military and police of the humans
humanNavy = FactionInfo():setName("Human Navy")
humanNavy:setGMColor(255, 255, 255)
humanNavy:setFriendly(player)

civilian = FactionInfo():setName("Civilian")
civilian:setGMColor(127, 255, 0)
civilian:setFriendly(humanNavy)

-- a mining company
smc = FactionInfo():setName("SMC")
smc:setGMColor(0, 127, 255)
smc:setFriendly(humanNavy)

-- generic outlaw
outlaw = FactionInfo():setName("Outlaw")
outlaw:setGMColor(255, 127, 0)
outlaw:setEnemy(player)
outlaw:setEnemy(humanNavy)

-- pirates
pirates = FactionInfo():setName("Pirate")
pirates:setGMColor(255, 63, 0)
pirates:setEnemy(traders)
pirates:setEnemy(player)
pirates:setEnemy(humanNavy)
pirates:setEnemy(civilian)
pirates:setEnemy(smc)

-- the evil
legion = FactionInfo():setName("Legion")
legion:setGMColor(255, 0, 0)
legion:setEnemy(neutral)
--legion:setFriendly(abandoned) -- neutral
legion:setEnemy(traders)
legion:setEnemy(player)
legion:setEnemy(humanNavy)
legion:setEnemy(civilian)
legion:setEnemy(smc)
legion:setEnemy(outlaw)
legion:setEnemy(pirates)