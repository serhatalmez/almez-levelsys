ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

LevelXPCounts = {
    [1] = 500,
    [2] = 1000,
    [3] = 1500,
    [4] = 2000,
    [5] = 2500,
    [6] = 3000,
    [7] = 3500,
    [8] = 4000,
    [9] = 4500,
    [10] = 5000,
}

RegisterServerEvent('updatePlayerXP')
AddEventHandler('updatePlayerXP', function(ixp)
    local player = ESX.GetPlayerFromId(source)
    local pData = getPlayerDetails(player.identifier)
    local isLevelUP = getPlayerLevelState(player.identifier, ixp)
    if isLevelUP then
        txp = pData.xp + ixp
        lastxp = txp - LevelXPCounts[pData.level]
        MySQL.Async.execute('UPDATE users SET xp = @ixp, level = (level + 1) WHERE identifier = @identifier',{
			['@identifier'] = player.identifier,
            ['@ixp'] = lastxp
		})
    else
        MySQL.Async.execute('UPDATE users SET xp = (xp + @ixp) WHERE identifier = @identifier',{
			['@identifier'] = player.identifier,
            ['@ixp'] = ixp
		})
    end
end)

RegisterServerEvent('sadf')
AddEventHandler('sadf', function(asd)
end)

ESX.RegisterServerCallback("almez-levels:getPlayerData", function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    local pData = exports.ghmattimysql:executeSync('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = player.identifier})
    cb(pData[1])
end)

getPlayerLevelState = function(ide, xp)
    local player = ESX.GetPlayerFromId(ide)
    local pData = exports.ghmattimysql:executeSync('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide})
    if pData[1].xp + xp < LevelXPCounts[pData[1].level] then
        return false 
    else
        return true
    end
end

getPlayerDetails = function(ide)
    local pData = exports.ghmattimysql:executeSync('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = ide})
    return pData[1]
end