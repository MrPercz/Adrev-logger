-- Percz Development discord.gg/perczdev

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end


    local function sendInitialMessage()
        local embed = {
            ["color"] = 16776960, -- Yellow color
            ["title"] = "Logger Started",
            ["description"] = "The Logs are up and running!",
            ["footer"] = {
                ["text"] = "PD - Admin Revive Logs"
            },
            ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S')
        }


        PerformHttpRequest(Config.webhookUrl, function(statusCode, response, headers)
            if statusCode == 200 then
                print('Successfully logged initial message to Discord channel!')
            else
                print('Failed to log initial message to Discord channel. Error code: ' .. statusCode)
            end
        end, 'POST', json.encode({ embeds = { embed } }), { ['Content-Type'] = 'application/json' })
    end


    sendInitialMessage()
end)

RegisterCommand(Config.adrevCommand, function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)


    local playerDiscordId = nil
    for _, identifier in ipairs(GetPlayerIdentifiers(source)) do
        if string.find(identifier, 'discord:') then
            playerDiscordId = string.sub(identifier, 9)
            break
        end
    end

    local playerMention = "<@" .. (playerDiscordId or "N/A") .. ">"

    
    local revivedPlayerName = args[1] or "N/A" 

    local revivedPlayerDiscordId = nil
    for _, playerId in ipairs(GetPlayers()) do
        local playerName = GetPlayerName(playerId)
        if playerName == revivedPlayerName then

            for _, identifier in ipairs(GetPlayerIdentifiers(playerId)) do
                if string.find(identifier, 'discord:') then
                    revivedPlayerDiscordId = string.sub(identifier, 9)
                    break
                end
            end
            break
        end
    end

    local revivedPlayerMention = "<@" .. (revivedPlayerDiscordId or "N/A") .. ">"

    local embed = {
        ["color"] = 16711680, -- red color
        ["title"] = "Admin Revive Command Used",
        ["fields"] = {
            {
                ["name"] = "Player Name",
                ["value"] = playerName,
                ["inline"] = true
            },
            {
                ["name"] = "Player Discord ID",
                ["value"] = playerMention,
                ["inline"] = true
            },
            {
                ["name"] = "Revived Player ID",
                ["value"] = revivedPlayerName,
                ["inline"] = true
            },

        },
        ["footer"] = {
            ["text"] = "Adrev Command Log"
        },
        ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S')
    }


    PerformHttpRequest(Config.webhookUrl, function(statusCode, response, headers)
        if statusCode == 200 then
            print('Successfully logged to Discord channel!')
            print('Player Discord ID: ' .. (playerDiscordId or "N/A"))
        else
            print('Successfully logged to Discord channel! ' .. statusCode)
        end
    end, 'POST', json.encode({ embeds = { embed } }), { ['Content-Type'] = 'application/json' })
end)

RegisterCommand(Config.adresCommand, function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)


    local playerDiscordId = nil
    for _, identifier in ipairs(GetPlayerIdentifiers(source)) do
        if string.find(identifier, 'discord:') then
            playerDiscordId = string.sub(identifier, 9)
            break
        end
    end

    local playerMention = "<@" .. (playerDiscordId or "N/A") .. ">"


    local locationName = args[1] or "N/A" 
    local locationCoords = vector3(123.45, 67.89, 10.11)

    local embed = {
        ["color"] = 3447003, -- Blue color
        ["title"] = "AdRes Command Used",
        ["fields"] = {
            {
                ["name"] = "Player Name",
                ["value"] = playerName,
                ["inline"] = true
            },
            {
                ["name"] = "Player Discord ID",
                ["value"] = playerMention,
                ["inline"] = true
            },
            {
                ["name"] = "Revived Player ID",
                ["value"] = revivedPlayerName,
                ["inline"] = true
            },
        },
        ["footer"] = {
            ["text"] = "AdRes Command Log"
        },
        ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S')
    }


    PerformHttpRequest(Config.webhookUrl, function(statusCode, response, headers)
        if statusCode == 200 then
            print('Successfully logged to Discord channel!')
            print('Player Discord ID: ' .. (playerDiscordId or "N/A"))
        else
            print('Failed to log to Discord channel. Error code: ' .. statusCode)
        end
    end, 'POST', json.encode({ embeds = { embed } }), { ['Content-Type'] = 'application/json' })
end)
