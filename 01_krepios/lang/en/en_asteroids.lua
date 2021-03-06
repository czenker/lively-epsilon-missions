local f = string.format
local t = My.Translator.translate

My.Translator:register("en", {
    asteroids_description = function(callSign)
        return Util.random({
            "",
            "Oh look, ",
            "Big surprise! It's ",
            "Hard to believe, it is ",
            "Could it be possible? It's ",
            "How surprising, ",
            "It is ",
            "It's ",
            "This is ",
            "Apparently ",
            "Obviously ",
            "Very obviously ",
            "As suspected, ",
            "The database says it is ",
            "Most people say it's ",
            "There's a consensus it is ",
            "Science says it's ",
            "Science believes it is ",
        }) .. Util.random({
            "",
            "",
            "",
            "",
            "only ",
            "simply ",
            "nothing but ",
            "merely ",
        }) .. Util.random({
            "an asteroid",
            "a different asteroid",
            "another asteroid",
            "a boring asteroid",
            "a very unimpressive asteroid",
            "an insignificant asteroid",
            "an asteroid of little importance",
            "an unimportant asteroid",
            "a very average asteroid",
            "a replaceable asteroid",
            "a bland asteroid",
            "a mediocre asteroid",
            "a dispensable asteroid",
            "an asteroid like any other",
            "an asteroid that is indistinguishable from others",
            "an asteroid without any special properties",
        }) .. ". " .. Util.random({
            f("It is called %s.", callSign),
            f("It has the name %s.", callSign),
            f("A couple in love gave him the name %s.", callSign),
            f("Its official name is %s.", callSign),
            f("It's name's %s.", callSign),
            f("Its discoverers called it %s.", callSign),
            f("It is cataloged under the name %s.", callSign),
            f("Someone paid 50RP to give it the name %s.", callSign),
            f("In a celebratory ceremony it was christened %s.", callSign),
            f("Someone entered the name %s in the database and that has been its name since.", callSign),
            f("The database says it is called %s.", callSign),
            f("Their discoverers where exceptionally creative and called it %s.", callSign),
            f("To distinguish it from others, it was given the name %s.", callSign),
            f("It was given the name %s so as not to confuse it.", callSign),
        })
    end,

    asteroids_composition_empty = function()
        return Util.random({
            "It has been mined completely.",
            "There are no valuable minerals left here.",
            "No minerals remain on it.",
        })
    end,
    asteroids_composition = function()
        return Util.random({
            "It is composed of",
            "It's composition is"
        })
    end,

    asteroids_chunk_description = "A chunk of minerals. It contains",
    asteroids_chunk_empty_description = "An asteroids chunk that does not contain any valuable minerals.",


})