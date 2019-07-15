local f = string.format

My.Translator:register("en", {
    side_mission_transport_product = function(amount, productName, toCallSign)
        return f("Bring %d units of %s to %s", amount, productName, toCallSign)
    end,
    side_mission_transport_description = function(amount, productName, toCallSign, payment, penalty)
        return f("Our colleagues on %s asked us to send a shipment of %s.\n\nWe are therefore looking for a courier to deliver %d units of %s. We are paying %0.2fRP upon delivery. Additionally, we are keeping a deposit of %0.2fRP - just in case you are planning to sell our goods on the free market.", toCallSign, productName, amount, productName, payment, penalty)
    end,
    side_mission_transport_product_no_storage = "You ship does not have a storage. I hope you understand that you are not eligible for this contract.",
    side_mission_transport_product_small_storage = function(storageAmount)
        return f("We are very sorry. Your storage room is too small to take over the contract. You need at least a storage of %d units.", storageAmount)
    end,
    side_mission_transport_product_no_penalty = "You are currently not able to afford the deposit. This is a requirement to take over the contract.",

    side_mission_transport_product_accept_hint = function(fromCallSign, productName)
        return f("Dock to %s to pick up %s", fromCallSign, productName)
    end,
    side_mission_transport_product_load_log = function(productName)
        return f("%s picked up", productName)
    end,
    side_mission_transport_product_load_hint = function(toCallSign, productName)
        return f("Dock to %s to unload %s", toCallSign, productName)
    end,
    side_mission_transport_product_insufficient_storage = function(productName, storageAmount)
        return f("Storage room too small to pick up %s. %d required.", productName, storageAmount)
    end,
    side_mission_transport_product_product_lost = function(penalty)
        return f("Well, you sold the goods. As agreed upon in our contract, we are keeping your deposit of %0.2fRP.", penalty)
    end,
    side_mission_transport_product_success = function(payment)
        return f("Thank you for the fast delivery. We transferred your payment of %0.2fRP together with your deposit. Should you ever look for a contract again, please contact us.", payment)
    end,
})