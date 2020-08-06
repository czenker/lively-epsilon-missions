local t = My.Translator.translate
local f = string.format

My.Translator:register("en", {
    side_mission_scan_crystal = "Scan a complex crystal",
    side_mission_scan_crystal_description = function(tinkererPerson, nebulaName, payment)
        return Util.random({
            f("Hey there fellows. It's me, your favorite tinkerer %s.", tinkererPerson:getNickName()),
            f("This is a very special mission from %s. Wanna do something valuable for my research?", tinkererPerson:getNickName())
        }) .. " " .. Util.random({
            f("A few weeks back I found this strange crystal in %s.", nebulaName),
            f("There is a very mysterious crystal in the close-by nebula %s. ", nebulaName),
            f("I got reports of a very interesting crystal in %s and tried to get more information on it.", nebulaName),
        }) .. " " .. Util.random({
            "I guess decoding its crystaline structure could further my development, but the scan is very complex.",
            "I tried to scan it for its molecular composition, but I was interrupted by an ingenious idea I had to pursue. Don't be fooled, the scan is very complex.",
            "It took me quite some time to scan it, but I had to return to my workshop because of a fire before I could finish.",
        }) .. " " .. Util.random({
            "Could you help and scan it for me?",
            "Would you help a fellow adventurer out and scan it?",
        }) .. "\n\n" .. Util.random({
            f("I will pay you %0.2fRP and you do something good for my research.", payment),
            f("You will get a discount and an honorable mention on my next invention. And I also pay %0.2fRP on top.", payment),
        })
    end,
    side_mission_scan_crystal_artifact_name = "Crystal",
    side_mission_scan_crystal_artifact_description = "A mysterious, highly complex crystal",
    side_mission_scan_crystal_accept = function()
        return Util.random({
            "You are real friends.\n\nScan the crystal and send me the data. I hope your Science Officer is more patient then me.",
            "Excellent. Send me the data when you are finished and I... Wait. Does it smell like burned rubber? ... It's coming from my workshop, isn't it? Gotta go! You know where to find me.",
        })
    end,
    side_mission_scan_crystal_hint = function(sectorName)
        return f("Scan the crystal in sector %s.", sectorName)
    end,
    side_mission_scan_crystal_success = function(tinkererPerson, payment)
        return Util.random({
            "You cracked the signature of the crystal! Send your Science Officer my deepest respect. I am truly impressed.",
            "I was not sure if the signature of the crystal could be cracked, but your Science Officer seems to be a genius.",
        }) .. " " .. Util.random({
            "With this information I can speed up my development.",
            "This will help me in my current development.",
        }) .. " " .. Util.random({
            f("Your payment of %0.2fRP has been transferred.", payment),
        }) .. " " .. Util.random({
            "I hope we meet again soon.",
            "Stop by my workshop when you are back at the station. Maybe I got an upgrade you are interested in.",
        }) .. "\n\n- " .. tinkererPerson:getNickName()
    end,
})