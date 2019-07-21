My = My or {}

local navyAlphabet = {
    "Able",
    "Baker",
    "Charlie",
    "Dog",
    "Easy",
    "Fox",
    "George",
    "How",
    "Item",
    "Jig",
    "King",
    "Love",
    "Mike",
    "Nutley",
    "Oboe",
    "Peter",
    "Queen",
    "Roger",
    "Sail",
    "Tare",
    "Uncle",
    "Victor",
    "William",
    "X-Ray",
    "Yoke",
    "Zebra",
}

local englishAlphabet = {
    "Alfa",
    "Bravo",
    "Charlie",
    "Delta",
    "Echo",
    "Foxtrot",
    "Golf",
    "Hotel",
    "India",
    "Juliet",
    "Kilo",
    "Lima",
    "Mike",
    "November",
    "Oscar",
    "Papa",
    "Quebec",
    "Romeo",
    "Sierra",
    "Tango",
    "Uniform",
    "Victor",
    "Whiskey",
    "X-Ray",
    "Yankee",
    "Zulu",
}

local cantoneseNumerals = {
    "ling",
    "jat",
    "ji",
    "saam",
    "sei",
    "ng",
    "luk",
    "cat",
    "baat",
    "gau",
    "sap",
}

local roles = {
    "Advisor",
    "Administrator",
    "Assistant",
    "Astrologer",
    "Baron",
    "Bodyguard",
    "Chief",
    "Count",
    "Duke",
    "Emir",
    "Emperor",
    "Excellency",
    "General",
    "Guard",
    "Instructor",
    "Judge",
    "Khan",
    "King",
    "Lord",
    "Minister",
    "Nobility",
    "Officer",
    "Prince",
    "Royal",
    "Ruler",
    "Shah",
    "Sheik",
    "Soldier",
    "Sultan",
    "Tsar",
}

local sector = {
    "Sol",
    "Centauri",
    "Sirius",
    "Luyten",
    "Ross",
    "Aquarii",
    "Cygni",
    "Proycon",
    "Canis",
    "Ceti",
    "Virginis",
    "Ursea",
    "Leporis",
    "Pegasi",
    "Leonis",
    "Piscium",
    "Cassiopeiae",
    "Vega",
    "Ori",
    "Eri",
    "Pavonis",
    "Mensae",
    "Andromedae",
    "Draconis",
    "Scorpii",
    "Herculis",
    "Phoenicis",
    "Aquilae",
    "Persei",

}

local sectorMod = {
    "Alpha ",
    "Beta ",
    "Gamma ",
    "Tau ",
    "Proxima ",
    "Primus ",
    "Secundus ",
    "Tertius ",
    "Quadrus ",
    " Prime",
    " Minor",
    " Major",
    " Librae",
    " Prior",
    " Ultimate",
    " Minutus",
    " Borealis",
    " Orientis",
    " Australis",
    " Occidens",
    "Magna ",
    "Old ",
    "New ",
    "Far ",
    " Nova",
    " Veteris",
    " Tantum",
}



My.nebulaName = My.deduplicateName(function()
    local version = math.random(1,3)
    if version == 1 then
        return Util.random(Names.greekAlphabet) .. " " .. Util.random(Names.greekTitans)
    elseif version == 2 then
        return Util.random(Names.bodyPart) .. " of " .. Util.random(Names.greekTitans)
    else
        return Names.possessive(Util.random(Names.greekTitans)) .. " " .. Util.random(Names.bodyPart)
    end
end)

My.sectorName = My.deduplicateName(function()
    local name = Util.random(sector)

    local mod = Util.random(sectorMod)
    if mod:sub(1,1) == " " then
        name = name .. mod
    else
        name = mod .. name
    end

    return name
end)
