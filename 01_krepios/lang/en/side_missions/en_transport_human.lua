local f = string.format
local t = My.Translator.translate

local lateForJobDescription = function(role, task, clientPerson, stationCallSign, payment)
    return t("comms_generic_hail", clientPerson) .. " " .. Util.random({
        "I am working as " .. role .. " for the Saiku Mining Corporation and",
        "As " .. role .. " for Saiku Mining Corporation, I",
        "In my job as " .. role .. " for Saiku Mining Corporation, I",
        "I am employed by Saiku Mining Corporation as " .. role .. ". This morning I",
        "I am " .. role .. " with Saiku Mining Corporation. Yesterday I",
    }) .. " " .. Util.random({
        "was asked by",
        "was requested by",
    }) .. " " .. stationCallSign .. " to " .. task .. ". " ..  Util.random({
        "I missed the shuttle to the station unfortunately and need to look for alternatives now.",
        "My usual pilot is occupied with some family business today.",
        "I overslept toady. Usually this does not happen to me, but I'm in a hassle now.",
    }) .. "\n\n" .. Util.random({
        f("I am willing to pay %0.2fRP if you bring me to work.", payment),
        f("I would make your efforts worthwhile with %0.2fRP.", payment),
    })
end

My.Translator:register("en", {
    side_mission_transport_human = function(stationCallSign)
        return Util.random({
            f("Personal transport to %s", stationCallSign),
            f("Bring a person to %s", stationCallSign),
        })
    end,
    side_mission_transport_human_description = function(clientPerson, stationCallSign, payment)
        return t("comms_generic_hail", clientPerson) .. " " .. Util.random({
            "I am looking for a lift to ".. stationCallSign .. ".",
            "Are you flying to ".. stationCallSign .. "?",
            "Can you take me to ".. stationCallSign .. "?",
            "You are not passing ".. stationCallSign .. " by chance, are you?",
        }) .. "\n\n" .. Util.random({
            f("Of course, I would pay you. How about %0.2fRP?", payment),
            f("I would pay you %0.2fRP for your efforts.", payment),
            f("I am paying you %0.2fRP for your help.", payment),
            f("I am carrying %0.2fRP - I would give it to you in exchange.", payment),
        })
    end,
    side_mission_transport_human_description_technician = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Chief Engineer",
            Util.random({
                "recalibrate the drill heads",
                "solve the problem with waste heat of the drillers",
                "check the fuel consumption of the mining ships",
                "optimize the control electronic of the drones",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_chemist = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Chemist",
            Util.random({
                "analyze the quality of the ore",
                "do chemical experiments on asteroid rocks",
                "analyze the minerals for impurities",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_ceo = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Executive Officer",
            Util.random({
                "estimate the profitability of the station",
                "improve the workflow",
                "negotiate over investments",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_physician = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "Doctor",
            Util.random({
                "research a mysterious influenza",
                "convince the laborers of a healthy diet",
                "offer help for alcoholics",
                "take care of injured miners",
                "explain irregularities in sickness leave",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,
    side_mission_transport_human_description_scientist = function(clientPerson, stationCallSign, payment)
        return lateForJobDescription(
            "scientist",
            Util.random({
                "research enclaves in minerals",
                "support with important experiments",
                "research pleochroism of xenomorphic crystaline macro molecules",
            }),
            clientPerson,
            stationCallSign,
            payment
        )
    end,

    side_mission_transport_human_time_limit = function(timeLimit)
        return Util.random({
            f("I need to be there in %0.1f minutes.", timeLimit),
            f("I have to be there within %0.1f minutes.", timeLimit),
        }) .. " Please hurry!"
    end,
    side_mission_transport_human_accept = "Thank you for taking me with you. I feared I had to stay here forever.",
    side_mission_transport_human_accept_hint = function(stationCallSign, clientPerson)
        return f("Dock to %s to pick %s up", stationCallSign, clientPerson:getFormalName())
    end,
    side_mission_transport_human_load_log = function(clientPerson)
        return clientPerson:getFormalName() .. " came on board"
    end,
    side_mission_transport_human_load_hint = function(stationCallSign, clientPerson)
        return f("Bring %s to %s", clientPerson:getFormalName(), stationCallSign)
    end,
    side_mission_transport_human_success = function(stationCallSign, payment)
        return f("Thanks for bringing me to %s. As agreed upon, I have already transferred %0.2fRP to your account.", stationCallSign, payment)
    end,

})