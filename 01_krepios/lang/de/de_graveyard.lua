local f = string.format

My.Translator:register("de", {

    graveyard_ship_description = function(shipCallSign)
        return Util.random({
            "Dieses Schiff wurde bereits vor Jahren außer Dienst gestellt.",
            f("Ein Schrotthaufen, der früher mal den Namen %s trug.", shipCallSign),
            f("Zwischen dem Rost des Schiffes lässt sich noch der Name %s erahnen.", shipCallSign),
            "Das Schiff ist offensichtlich nicht mehr betriebsbereit und wurde hier verschrottet.",
            "Ein Schiff auf einem Schiffsfriedhof.",
        })
    end,
})