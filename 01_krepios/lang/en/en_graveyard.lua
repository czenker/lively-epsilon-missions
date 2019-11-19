local f = string.format

My.Translator:register("en", {

    graveyard_ship_description = function(shipCallSign)
        return Util.random({
            "This ship has been put out of service years ago.",
            f("A clunker that formerly had the name %s.", shipCallSign),
            f("The name %s is still partly visible through the rust.", shipCallSign),
            "Obviously, this ship is no longer functional and was scrapped here.",
            "A ship on a ship graveyard.",
        })
    end,
})