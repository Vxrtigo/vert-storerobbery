local QBCore = exports['qb-core']:GetCoreObject()
local CurrentCops = 0
local currentRegister = 0
local currentComputer = 0
local currentSafe = 0
local hackedComputer = nil

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

for k, v in pairs(Config.Registers) do
exports.ox_target:addBoxZone({
    coords = v.coords,
    size = vec3(0.5, 0.5, 0.6),
    rotation = v.coords.w,
    debug = Config.Debug,
    options = {
        {
            name = 'register',
            icon = 'fas fa-cash-register',
            label = 'Rob Register',
            distance = 1.5,
            onSelect = function()
                TriggerEvent('vert-storerobbery:client:BeginRobbery', k)
            end
        }
    }
})
end

-- Computers

for k, v in pairs(Config.Computers) do
    exports.ox_target:addBoxZone({
        coords = v.coords,
        size = vec3(0.5, 0.5, 1.1),
        rotation = v.coords.w,
        debug = Config.Debug,
        options = {
            {
                name = 'computer',
                icon = 'fas fa-computer',
                label = 'Hack Computer',
                distance = 1.5,
                onSelect = function()
                    TriggerEvent('vert-storerobbery:client:HackComputer', k)
                end
            }
        }
})
end

-- Safes

for k, v in pairs(Config.Safes) do
    exports.ox_target:addBoxZone({
        coords = v.coords,
        size = vec3(0.8, 0.8, 1.1),
        rotation = v.coords.w,
        debug = Config.Debug,
        options = {
            {
                name = 'safe',
                icon = 'fas fa-vault',
                label = 'Blow Open Safe',
                distance = 1.5,
                onSelect = function()
                    TriggerEvent('vert-storerobbery:client:BlowSafe', k)
                end
            }
        }
})
end

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true

    if model == `mp_m_freemode_01` then
        if Config.MaleFingerprints[armIndex] ~= nil and Config.MaleFingerprints[armIndex] then
            retval = false
        end
    else
        if Config.FemaleFingerprints[armIndex] ~= nil and Config.FemaleFingerprints[armIndex] then
            retval = false
        end
    end
    return retval
end

local function canLockpick()
    local playerInv = exports.ox_inventory:GetPlayerItems()
    local requiredItems = {[Config.RegisterItem] = 1}
    if not playerInv then return false end
    for _, item in pairs(playerInv) do
        if requiredItems[item.name] then
            return true
        end
    end
    return false
end

local function canHack()
    local playerInv = exports.ox_inventory:GetPlayerItems()
    local requiredItems = {[Config.ComputerItem] = 1}
    if not playerInv then return false end
    for _, item in pairs(playerInv) do
        if requiredItems[item.name] then
            return true
        end
    end
    return false
end

local function canBlow()
    local playerInv = exports.ox_inventory:GetPlayerItems()
    local requiredItems = {[Config.SafeItem] = 1}
    if not playerInv then return false end
    for _, item in pairs(playerInv) do
        if requiredItems[item.name] then
            return true
        end
    end
    return false
end

local function isHacked(computerID)
    return Config.Computers[computerId] and Config.Computers[computerId].hacked or false
end

-- Registers

RegisterNetEvent("vert-storerobbery:client:BeginRobbery", function(currentRegister)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
            if CurrentCops >= Config.MinimumPolice then
                if not canLockpick() then
                    QBCore.Functions.Notify("You don't have anything to pick the lock with!", "error")
                    return 
                end
                    QBCore.Functions.TriggerCallback('vert-storerobbery:server:RobStatus', function(isRobbed)
                        if not isRobbed then
                            exports['ps-ui']:VarHack(function(success)
                                if success then
                                    if not IsWearingHandshoes() then
                                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                    end -- Gloves
                                        QBCore.Functions.Progressbar("search_register", "Emptying the Register", 15000, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "veh@break_in@0h@p_m_one@",
                                            anim = "low_force_entry_ds",
                                            flags = 49,
                                        }, {}, {}, function() -- Done
                                            ClearPedTasks(ped)
                                            TriggerServerEvent('vert-storerobbery:server:RegisterReward')
                                            TriggerServerEvent('vert-storerobbery:server:setRegisterStatus', currentRegister, true)
                                        end) -- Progress bar
                                else --ui
                                    ClearPedTasks(ped)
                                    QBCore.Functions.Notify("You failed to open the register!", "error")
                                    TriggerServerEvent('vert-storerobbery:server:BreakLockpick')
                                end
                                if not copsCalled then
                                    TriggerEvent("vert-storerobbery:client:CallCops")
                                    copsCalled = true
                                end
                            end, 4, 3) -- NumberOfCircles, MS
                        else
                            QBCore.Functions.Notify("This has been robbed recently", "error")
                        end
                    end, currentRegister) -- CB
            else
                QBCore.Functions.Notify("Not enough cops on " .. Config.MinimumPolice .. " required", "error")
            end -- Current cops
end) --entire net

-- Computer

RegisterNetEvent("vert-storerobbery:client:HackComputer", function(currentComputer)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
        if CurrentCops >= Config.MinimumPolice then
            if not canHack() then
                QBCore.Functions.Notify("You don't have anything to hack the computer with!", "error")
                return 
            end
                QBCore.Functions.TriggerCallback('vert-storerobbery:server:ComputerStatus', function(isHacked)
                    if not isHacked then
                        exports['ps-ui']:Scrambler(function(success)
                            if success then
                                if not IsWearingHandshoes() then
                                    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                end -- Gloves
                                    QBCore.Functions.Progressbar("search_register", "Hacking the computer", 15000, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {
                                        animDict = "anim@heists@prison_heiststation@cop_reactions",
                                        anim = "cop_b_idle",
                                        flags = 49,
                                    }, {}, {}, function() -- Done
                                        ClearPedTasks(ped)
                                        TriggerServerEvent('vert-storerobbery:server:setComputerStatus', currentComputer, true)
                                        QBCore.Functions.Notify("The safe alarm has been disabled!", "success")
                                        hackedComputer = currentComputer
                                    end) -- Progress bar
                            else --ui
                                ClearPedTasks(ped)
                                QBCore.Functions.Notify("You failed to hack the computer!", "error")
                                TriggerServerEvent('vert-storerobbery:server:BreakTrojan')
                            end
                            if not copsCalled then
                                TriggerEvent("vert-storerobbery:client:CallCops")
                                copsCalled = true
                            end
                        end, "numeric", 30, 0) -- NumberOfCircles, MS
                    else
                        QBCore.Functions.Notify("This has been hacked recently", "error")
                    end
                end, currentComputer) -- CB
        else
            QBCore.Functions.Notify("Not enough cops on " .. Config.MinimumPolice .. " required", "error")
        end -- Current cops
end)

-- Safes

RegisterNetEvent("vert-storerobbery:client:BlowSafe", function(currentSafe)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    
    if CurrentCops >= Config.MinimumPolice then
        if not canBlow() then
            QBCore.Functions.Notify("You don't have anything to blow the safe open with!", "error")
            return 
        end
        if not hackedComputer then
            QBCore.Functions.Notify("The computer needs to be hacked first!", "error")
            return 
        end
        if hackedComputer == currentSafe then
            QBCore.Functions.TriggerCallback('vert-storerobbery:server:SafeStatus', function(isHacked)
                if not isHacked then
                    exports['ps-ui']:Thermite(function(success)
                        if success then
                            if not IsWearingHandshoes() then
                                TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                            end -- Gloves
                            QBCore.Functions.Progressbar("search_register", "Planting Thermite Charge", 15000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "anim@heists@ornate_bank@thermal_charge",
                                anim = "thermal_charge",
                                flags = 49,
                            }, {}, {}, function() -- Done
                                ClearPedTasks(ped)
                                TriggerServerEvent('vert-storerobbery:server:SafeReward')
                                TriggerServerEvent('vert-storerobbery:server:setSafeStatus', currentSafe, true)
                                QBCore.Functions.Notify("The safe has been blown open!", "success")
                            end) -- Progress bar
                        else --ui
                            ClearPedTasks(ped)
                            QBCore.Functions.Notify("You failed to plant the thermite!", "error")
                            TriggerServerEvent('vert-storerobbery:server:BreakThermite')
                        end
                        if not copsCalled then
                            TriggerEvent("vert-storerobbery:client:CallCops")
                            copsCalled = true
                        end
                    end, 10, 5, 3) -- NumberOfCircles, MS
                else
                    QBCore.Functions.Notify("This safe has been blown open recently", "error")
                end
            end, currentSafe) -- CB
        else
            QBCore.Functions.Notify("You can only unlock the safe connected to the hacked computer!", "error")
        end
    else
        QBCore.Functions.Notify("Not enough cops on " .. Config.MinimumPolice .. " required", "error")
    end
end)


RegisterNetEvent("vert-storerobbery:client:CallCops", function()
    if Config.Dispatch == 'cd' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police', 'bcso'}, 
            coords = data.coords,
            title = '10-15 - Store Robbery',
            message = 'A '..data.sex..' is robbing a store at '..data.street, 
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 431, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = '911 - Store Robbery',
                time = (5*60*1000),
                sound = 1,
            }
        })
    elseif Config.Dispatch == 'ps' then
        exports['ps-dispatch']:StoreRobbery()
    end    
end)