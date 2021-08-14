ESX = nil 
pXP = nil
pLevel = nil 
playerLoaded = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(30)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    while pXP == nil do
        ESX.TriggerServerCallback('almez-levels:getPlayerData', function(data) 
            pXP = data.xp
            pLevel = data.level
        end)
        playerLoaded = true
        Citizen.Wait(30)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if playerLoaded then 
            ESX.TriggerServerCallback('almez-levels:getPlayerData', function(data) 
                pXP = data.xp
                pLevel = data.level
            end) 
        end
    end
end)

exports('getLevel', function()
    return pLevel
end)

exports('getXP', function()
    return pXP
end)

exports('updateXP', function(xp)
    TriggerServerEvent('updatePlayerXP', xp)
end)

function GetPlayerData()
    ESX.TriggerServerCallback('almez-levels:getPlayerData', function(data) 
        local pData = data
    end)
    return pData
end
