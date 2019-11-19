local f = string.format

My.Translator:register("en", {

    drops_name = function()
        return Util.random({
            "container",
            "shipping container",
            "canister",
            "crate",
            "transport container",
        })
    end,

    drops_description_unknown = "unknown object",

    drops_description_full = function(shipCallSign, value, energy)
        return Util.random({
            f("This shipping container originates from the ship %s that crashed in this minefield.", shipCallSign),
            f("The container seems to have been lost by the ship %s.", shipCallSign),
            f("The container comes from the damaged ship %s.", shipCallSign),
        }) .. " " .. Util.random({
            f("It contains %0.2fRP and %d energy.", value, energy),
            f("In it there are %0.2fRP and %d energy.", value, energy),
            f("The scans show that its contents are %0.2fRP and %d energy.", value, energy),
        })
    end,

    drops_pickup = function(value, energy)
        return f("You have collected %0.2fRP and %d energy.", value, energy)
    end,

    drops_ship_description = function(shipCallSign)
        return Util.random({
            f("The wreck of the former ship %s.", shipCallSign),
            f("The remains of a ship known as \"%s\".", shipCallSign),
            f("This is what remained of the ship %s.", shipCallSign),
        }) .. " " .. Util.random({
            "It has collided with a mine and got destroyed.",
            "Its crew had problems navigating and got the ship destroyed in a mine field.",
            "How it ended up in a mine field remains a mystery.",
        })
    end,

})