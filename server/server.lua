local QBCore = exports['qb-core']:GetCoreObject()
local Registers = {}
local Computers = {}
local Safes = {}

function resetTimer(regnum)
    SetTimeout(1000 * Config.ResetTime, function()
    Registers[regnum].robbed = false
    end)
end

function computerTimer(comnum)
    SetTimeout(1000 * Config.ResetTime, function()
    Computers[comnum].hacked = false
    end)
end

function safeTimer(safenum)
    SetTimeout(1000 * Config.ResetTime, function()
    Safes[safenum].blown = false
    end)
end

RegisterNetEvent("vert-storerobbery:server:RegisterReward", function(safe)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local amount = math.random(Config.MinAmount, Config.MaxAmount)
    exports.ox_inventory:AddItem(source, Config.PayoutItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['blackmoney'], "add")

    local chance = math.random(1, 100)
    if chance <= Config.SpecialChance then
        Item = Config.SpecialItems[math.random(1, #Config.SpecialItems)]
    end
    if exports.ox_inventory:CanCarryItem(src, Item, 1) then
        Player.Functions.AddItem(Item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Item], "add", 1)
        TriggerClientEvent('QBCore:Notify', src, 'It looks like something valuable was in the register!', "success", 4000)
    end
end)

RegisterNetEvent("vert-storerobbery:server:SafeReward", function(safe)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local amount = math.random(Config.MinAmount, Config.MaxAmount)
    exports.ox_inventory:AddItem(source, Config.PayoutItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['blackmoney'], "add")

    local chance = math.random(1, 100)
    if chance <= Config.SpecialChance then
        Item = Config.SpecialItems[math.random(1, #Config.SpecialItems)]
    end
    if exports.ox_inventory:CanCarryItem(src, Item, 1) then
        Player.Functions.AddItem(Item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Item], "add", 1)
        TriggerClientEvent('QBCore:Notify', src, 'It looks like something valuable was in the safe!', "success", 4000)
    end
end)

RegisterNetEvent("vert-storerobbery:server:BreakLockpick", function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem(Config.RegisterItem, 1)
end)

RegisterNetEvent("vert-storerobbery:server:BreakTrojan", function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem(Config.ComputerItem, 1)
end)

RegisterNetEvent("vert-storerobbery:server:BreakThermite", function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem(Config.SafeItem, 1)
end)

-- Registers

CreateThread(function()
    for k, v in pairs(Config.Registers) do
        Registers[k] = {robbed = false}
    end
end)

RegisterNetEvent('vert-storerobbery:server:setRegisterStatus', function(regnum, status)
    Registers[regnum].robbed = status
    if status then 
        resetTimer(regnum)
    end
end)

QBCore.Functions.CreateCallback('vert-storerobbery:server:RobStatus', function(source, cb, regnum)
    local src = source
    cb(Registers[regnum].robbed)
end)

-- Computers

CreateThread(function()
    for k, v in pairs(Config.Computers) do
        Computers[k] = {hacked = false}
    end
end)

RegisterNetEvent('vert-storerobbery:server:setComputerStatus', function(comnum, status)
    Computers[comnum].hacked = status
    if status then 
        computerTimer(comnum)
    end
end)

QBCore.Functions.CreateCallback('vert-storerobbery:server:ComputerStatus', function(source, cb, comnum)
    local src = source
    cb(Computers[comnum].hacked)
end)

-- Safes

CreateThread(function()
    for k, v in pairs(Config.Safes) do
        Safes[k] = {blown = false}
    end
end)

RegisterNetEvent('vert-storerobbery:server:setSafeStatus', function(safenum, status)
    Safes[safenum].hacked = status
    if status then 
        safeTimer(safenum)
    end
end)

QBCore.Functions.CreateCallback('vert-storerobbery:server:SafeStatus', function(source, cb, safenum)
    local src = source
    cb(Safes[safenum].hacked)
end)