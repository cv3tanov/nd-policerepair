NDCore = exports['nd-core']:GetCoreObject()
local PlayerData = {}
local HasAlreadyGotMessage = false
local isInMarker = false

Locations = {
    vector3(378.45, -1629.54, 29.29),  -- Полиция
    --vector3(1853.73, 3676.5, 33.78), -- Шерифи
}

RegisterNetEvent('Hey:first', function()
    First()
end)

RegisterNetEvent('Hey:second', function()
    Second()
end)

CreateThread(function()
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            vehicle = GetVehiclePedIsIn(PlayerPedId())
            for k,v in ipairs(Locations) do
                local distance = #(coords.xy - v.xy)
                if distance < 5.0  then
                    if LocalPlayer.state.isLoggedIn and NDCore.Functions.GetPlayerData().job.name == "police" then
                        DrawMarker(36, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 151, 200, 222, false, false, false, true, false, false, false)
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent('Hey:first')
                            Wait(5000)
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)

function First()
    NDCore.Functions.Progressbar('Repair Vehicle', 'Ремонт на двигателя...', 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        SetVehicleEngineHealth(vehicle, 1000.0) 
        NDCore.Functions.Notify('Поправихме повредата по двигателя!')
        TriggerEvent('Hey:second')
    end, function() -- Cancel
        NDCore.Functions.Notify("Отказано!", "error")  
    end)
end

function Second()
    NDCore.Functions.Progressbar('Repair Vehicle', 'Ремонт на купето...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0.1)
        NDCore.Functions.Notify('Всички поправки по купето са направени!')
        TriggerEvent('Hey:third')
    end, function() -- Cancel
        NDCore.Functions.Notify("Отказано!", "error")    
    end)
end

