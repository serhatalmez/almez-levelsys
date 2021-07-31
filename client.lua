ESX = nil 
pXP = nil
pLevel = nil 
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(30)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        ESX.TriggerServerCallback('almez-levels:getPlayerData', function(data) 
            pXP = data.xp
            pLevel = data.level
        end) 
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