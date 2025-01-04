ESX = exports['es_extended']:getSharedObject()


local activePeds = {}
local activeNames = {}


local function _U(str, ...)
    local text = Config.Locales[Config.Locale][str]
    if text == nil then
        return 'Translation_Missing: ' .. Config.Locale .. '/' .. str
    end
    return string.format(text, ...)
end

local function Debug(msg, ...)
    if Config.Debug then
        print('^3[esx_SleepOffline][CLIENT] ^7' .. string.format(msg, ...))
    end
end

local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))
    
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * Config.TextSettings.Scale * fov
    
    if onScreen then
        SetTextScale(0.0 * scale, Config.TextSettings.Scale * scale)
        SetTextFont(Config.TextSettings.Font)
        SetTextProportional(1)
        SetTextColour(
            Config.TextSettings.Color.r,
            Config.TextSettings.Color.g,
            Config.TextSettings.Color.b,
            Config.TextSettings.Color.a
        )
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


local function CreateSleepingPed(identifier, coords, heading, skin)
    Debug('Creating sleeping ped for %s at coords: %s, %s, %s', identifier, coords.x, coords.y, coords.z)
    

    if activePeds[identifier] then
        Debug('Removing existing ped for %s', identifier)
        DeleteEntity(activePeds[identifier])
        activePeds[identifier] = nil
    end

    local modelHash = skin.sex == 0 and "mp_m_freemode_01" or "mp_f_freemode_01"
    Debug('Loading model: %s', modelHash)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end
    
    local ped = CreatePed(4, modelHash, coords.x, coords.y, coords.z + Config.PedOffset, heading, false, true)
    activePeds[identifier] = ped
    Debug('Created ped with handle: %s', ped)
    
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    
    if skin then
        Debug('Applying skin to ped')
        Debug('Full skin data:')
        for k,v in pairs(skin) do
            Debug('  %s = %s', k, v)
        end

        SetPedHeadBlendData(ped, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)

        if skin.hair_1 then
            SetPedComponentVariation(ped, 2, skin.hair_1, skin.hair_2 or 0, 0) -- Hair
            Debug('Set hair: %s, %s', skin.hair_1, skin.hair_2 or 0)
        end
        

        local hairColor1 = skin.hair_color_1 or 0
        local hairColor2 = skin.hair_color_2 or 0
        SetPedHairColor(ped, hairColor1, hairColor2)
        Debug('Set hair colors: %s, %s', hairColor1, hairColor2)

        if skin.arms then
            SetPedComponentVariation(ped, 3, skin.arms, 0, 0) -- Arms
            Debug('Set arms: %s', skin.arms)
        end

        if skin.pants_1 then
            SetPedComponentVariation(ped, 4, skin.pants_1, skin.pants_2 or 0, 0) -- Pants
            Debug('Set pants: %s, %s', skin.pants_1, skin.pants_2 or 0)
        end

        if skin.shoes_1 then
            SetPedComponentVariation(ped, 6, skin.shoes_1, skin.shoes_2 or 0, 0) -- Shoes
            Debug('Set shoes: %s, %s', skin.shoes_1, skin.shoes_2 or 0)
        end

        if skin.tshirt_1 then
            SetPedComponentVariation(ped, 8, skin.tshirt_1, skin.tshirt_2 or 0, 0) -- Tshirt
            Debug('Set tshirt: %s, %s', skin.tshirt_1, skin.tshirt_2 or 0)
        end

        if skin.torso_1 then
            SetPedComponentVariation(ped, 11, skin.torso_1, skin.torso_2 or 0, 0) -- Torso
            Debug('Set torso: %s, %s', skin.torso_1, skin.torso_2 or 0)
        end

        if skin.mask_1 then
            SetPedComponentVariation(ped, 1, skin.mask_1, skin.mask_2 or 0, 0) -- Mask
            Debug('Set mask: %s, %s', skin.mask_1, skin.mask_2 or 0)
        end

        if skin.chain_1 then
            SetPedComponentVariation(ped, 7, skin.chain_1, skin.chain_2 or 0, 0) -- Chain
            Debug('Set chain: %s, %s', skin.chain_1, skin.chain_2 or 0)
        end

        if skin.bproof_1 then
            SetPedComponentVariation(ped, 9, skin.bproof_1, skin.bproof_2 or 0, 0) -- Bulletproof
            Debug('Set bproof: %s, %s', skin.bproof_1, skin.bproof_2 or 0)
        end

        if skin.helmet_1 then
            if skin.helmet_1 == -1 then
                ClearPedProp(ped, 0)
            else
                SetPedPropIndex(ped, 0, skin.helmet_1, skin.helmet_2 or 0, true)
            end
            Debug('Set helmet: %s, %s', skin.helmet_1, skin.helmet_2 or 0)
        end

        if skin.glasses_1 then
            if skin.glasses_1 == -1 then
                ClearPedProp(ped, 1)
            else
                SetPedPropIndex(ped, 1, skin.glasses_1, skin.glasses_2 or 0, true)
            end
            Debug('Set glasses: %s, %s', skin.glasses_1, skin.glasses_2 or 0)
        end

        if skin.watches_1 then
            if skin.watches_1 == -1 then
                ClearPedProp(ped, 6)
            else
                SetPedPropIndex(ped, 6, skin.watches_1, skin.watches_2 or 0, true)
            end
            Debug('Set watch: %s, %s', skin.watches_1, skin.watches_2 or 0)
        end
    end

    Debug('Loading sleep animation')
    RequestAnimDict(Config.Animation.Dict)
    while not HasAnimDictLoaded(Config.Animation.Dict) do
        Wait(0)
    end
    
    TaskPlayAnim(ped, Config.Animation.Dict, Config.Animation.Name, 
        Config.Animation.BlendIn, Config.Animation.BlendOut, -1, 
        Config.Animation.Flag, 0, false, false, false)
    Debug('Animation started')
    
    SetModelAsNoLongerNeeded(modelHash)
end


RegisterNetEvent('esx_sleepoffline:spawnSleepingPed')
AddEventHandler('esx_sleepoffline:spawnSleepingPed', function(identifier, coords, heading, skin, playerName)
    Debug('Received spawnSleepingPed event for %s (%s)', identifier, playerName)
    CreateSleepingPed(identifier, coords, heading, skin)
    activeNames[identifier] = playerName
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for identifier, ped in pairs(activePeds) do
            if DoesEntityExist(ped) then
                local pedCoords = GetEntityCoords(ped)
                local dist = #(playerCoords - pedCoords)
                
                if dist < Config.TextSettings.DrawDistance then
                    sleep = 0
                    local name = activeNames[identifier] or _U('unknown')
                    local displayText = string.format(Config.NameDisplay.Format, name)
                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z - 0.5, displayText)
                end
            end
        end
        
        Wait(sleep)
    end
end)

RegisterNetEvent('esx_sleepoffline:removeSleepingPed')
AddEventHandler('esx_sleepoffline:removeSleepingPed', function(identifier)
    Debug('Received removeSleepingPed event for %s', identifier)
    if activePeds[identifier] then
        DeleteEntity(activePeds[identifier])
        activePeds[identifier] = nil
        activeNames[identifier] = nil
        Debug('Removed ped and name for %s', identifier)
    else
        Debug('No ped found to remove for %s', identifier)
    end
end)


AddEventHandler('playerSpawned', function()
    Debug('Player spawned, requesting sleeping peds data')
    ESX.TriggerServerCallback('esx_sleepoffline:getSleepingPeds', function(sleepingPeds)
        Debug('Received %s sleeping peds', #sleepingPeds)
        for identifier, data in pairs(sleepingPeds) do
            CreateSleepingPed(identifier, data.coords, data.heading, data.skin)
            activeNames[identifier] = data.name
        end
    end)
end)
