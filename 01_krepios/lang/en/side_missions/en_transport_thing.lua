local f = string.format

My.Translator:register("en", {
    side_mission_transport_thing = function(productName, stationCallSign)
        return f("Bring %s to %s", productName, stationCallSign)
    end,

    side_mission_transport_thing_product_alcohol = "crate of alcohol",
    side_mission_transport_thing_description_alcohol = function(stationCallSign, amount, payment)
        return Util.random({
            f("I heard that the workers on %s are running dry.", stationCallSign),
            f("It came to my knowledge that the workers on %s are running low on alcohol.", stationCallSign),
            f("Have you heard that %s is running low on booze?", stationCallSign),
        }) .. " " .. Util.random({
            "I guess bringing a crate of alcohol there could return a nice profit.",
            "I'm sensing good business. All I need to do is to deliver a crate of good booze there.",
        }) .. " " .. Util.random({
            f("Can you help me? I need a ship that can load at least %d units.", amount),
            f("If you can load %d units, this could be a nice business opportunity for you.", amount),
        }) .. " " .. Util.random({
            f("Of course, you get a share on the profit: %0.2fRP.", payment),
            f("Take over the transport and you can enjoy %0.2fRP as share from our business deal.", payment),
        })
    end,

    side_mission_transport_thing_product_letters = "private letters",
    side_mission_transport_thing_description_letters = function(stationCallSign, amount, payment)
        return Util.random({
            f("For the communal postal services I am looking for a courier to deliver a bunch of private letters that are expected on %s.", stationCallSign),
        }) .. " " .. Util.random({
            f("All in all I'm looking for a ship that can spare %d units of storage space.", amount),
        }) .. " " .. Util.random({
            f("The tariff list recommends %0.2fRP as fair payment.", payment),
        })
    end,

    side_mission_transport_thing_product_memory = "data storage",
    side_mission_transport_thing_description_memory = function(stationCallSign, amount, payment)
        return Util.random({
            f("Important files need to be brought to station %s.", stationCallSign),
            f("This data storage need to be brought to %s.", stationCallSign),
        }) .. " " .. Util.random({
            "I am not allowed to tell you what is on them.",
            "We trust into your confidentiality when delivering the data sticks.",
            "The crate is sealed and must only be opened by the recipient.",
        }) .. " " .. Util.random({
            f("Can you spare %d units in your storage room?", amount),
            f("Those data sticks require %d units of space.", amount),
        }) .. " " .. Util.random({
            f("If you are interested in this contract, we can pay you %0.2fRP.", payment),
            f("Your discretion will be compensated with %0.2fRP.", payment),
        })
    end,

    side_mission_transport_thing_product_minerals = "minerals",
    side_mission_transport_thing_description_minerals = function(stationCallSign, amount, payment)
        return Util.random({
            f("The station %s asked us to send them a shipment of minerals.", stationCallSign),
            f("There is a need for minerals on station %s.", stationCallSign),
            f("This crate with minerals needs to be delivered to %s.", stationCallSign),
        }) .. " " .. Util.random({
            "From what I heard they will be analyzed by the eggheads there.",
            "I don't know what they need them for. But they pay well, so I am not asking any questions.",
            "The scientist said something why they need them - but I forgot.",
        }) .. " " .. Util.random({
            f("Can you spare %d units in your storage room?", amount),
            f("The minerals require %d units of space.", amount),
        }) .. " " .. Util.random({
            f("If you are interested in this contract, we can pay you %0.2fRP.", payment),
            f("Your discretion will be compensated with %0.2fRP.", payment),
        })
    end,

    side_mission_transport_thing_no_storage = "Your ship does not have a storage. I hope you can understand that we can not consider your application.",
    side_mission_transport_thing_small_storage = function(storageAmount)
        return f("We are very sorry, but the storage room of your ship is too small. for this contract. You need at least %d units of space", storageAmount)
    end,

    side_mission_transport_thing_accept_hint = function(stationCallSign, productName)
        return f("Dock to %s to load %s", stationCallSign, productName)
    end,
    side_mission_transport_thing_load_log = function(productName)
        return productName .. " loaded"
    end,
    side_mission_transport_thing_load_hint = function(stationCallSign, productName)
        return f("Dock to %s to deliver %s", stationCallSign, productName)
    end,
    side_mission_transport_thing_insufficient_storage = function(productName, storageAmount)
        return f("Storage too small to load %s. %d required.", productName, storageAmount)
    end,
    side_mission_transport_thing_success_log = function(productName)
        return productName .. "  delivered. Mission successful"
    end,
    side_mission_transport_thing_success = function(payment)
        return f("Thank you for the delivery. As negotiated, we paid you %0.2fRP. Should you need a contract again contact us.", payment)
    end,
})