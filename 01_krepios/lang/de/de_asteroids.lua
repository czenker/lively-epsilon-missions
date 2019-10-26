local f = string.format

My.Translator:register("de", {
    asteroids_description = function(callSign)
        return Util.random({
            "",
            "Oh schau, ",
            "Überraschung! Es ist ",
            "Man mag es kaum glauben, es ist ",
            "Ist es denn die Möglichkeit? Es ist ",
            "Wie spannend, ",
            "Es ist ",
            "Das ist ",
            "Das hier ist ",
            "Anscheinend ",
            "Offenbar ",
            "Ganz offensichtlich ",
            "Wie vermutet ",
            "Die Datenbank sagt es sei ",
            "Die meisten Menschen sagen es ist ",
            "Man ist sich einig, es ist ",
            "Die Wissenschaft behauptet, es sei ",
            "Die Wissenschaft glaubt, es ist ",
        }) .. Util.random({
            "",
            "",
            "",
            "",
            "nur noch ",
            "noch ",
            "nur ",
            "bloß ",
            "leider nur ",
        }) .. Util.random({
            "ein Asteroid",
            "ein anderer Asteroid",
            "ein weiterer Asteroid",
            "ein langweiliger Asteroid",
            "ein unbeeindruckender Asteroid",
            "ein wenig besonderer Asteroid",
            "ein unbedeutender Asteroid",
            "ein durchschnittlicher Asteroid",
            "ein austauschbarer Asteroid",
            "ein öder Asteroid",
            "ein mittelmäßiger Asteroid",
            "ein verzichtbarer Asteroid",
            "ein Asteroid, wie jeder andere auch",
            "ein Asteroid, der sich von anderen nicht unterscheidet",
            "ein Asteroid ohne besondere Eigenschaften"
        }) .. ". " .. Util.random({
            f("Er trägt den Namen %s.", callSign),
            f("Er hat den Namen %s.", callSign),
            f("Man nennt ihn %s.", callSign),
            f("Ein verliebtes Pärchen hat ihm den Namen %s gegeben.", callSign),
            f("Seine offizielle Bezeichnung lautet %s.", callSign),
            f("Er heißt %s.", callSign),
            f("Er wird %s genannt.", callSign),
            f("Von seinen Entdeckern wurde er %s genannt.", callSign),
            f("Er ist unter dem Namen %s katalogisiert.", callSign),
            f("Jemand hat 50RP bezahlt, um ihn auf den Namen %s taufen zu dürfen.", callSign),
            f("In einer feierlichen Zeremonie wurde er auf den Namen %s getauft.", callSign),
            f("Jemand hat seinen Namen als %s in der Datenbank angegeben und seit dem heißt er so.", callSign),
            f("Die Datenbank meint, er heißt %s.", callSign),
            f("Seine Entdecker waren besonders kreativ und haben ihn %s genannt.", callSign),
            f("Um ihn von anderen zu unterscheiden wurde ihm der Name %s gegeben.", callSign),
            f("Man hat ihm den Namen %s gegeben, um ihn nicht zu verwechseln.", callSign),
        })
    end,


    asteroids_composition_empty = function()
        return Util.random({
            "Alles Erz wurde vollständig abgebaut.",
            "Es gibt hier keine wertvollen Mineralien mehr.",
        })
    end,
    asteroids_composition = function()
        return Util.random({
            "Er setzt sich zusammen aus",
            "Die Zusammensetzung ist"
        })
    end,

    asteroids_chunk_description = "Ein Stück mit Mineralien. Es besteht aus",
})