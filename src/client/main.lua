local ESX = nil

local isMenuOpened = false

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

local menu_main = RageUI.CreateMenu("Armurerie", "Faites l'achat de votre choix", nil, nil, "root_cause", "black_red")

menu_main.Closed = function()
    isMenuOpened = false
    FreezeEntityPosition(PlayerPedId(), false)
end

local function requestOpenMenu()
    if (isMenuOpened) then
        return
    end
    FreezeEntityPosition(PlayerPedId(), true)
    isMenuOpened = true
    RageUI.Visible(menu_main, true)
    CreateThread(function()
        while (isMenuOpened) do
            RageUI.IsVisible(menu_main, function()
                for id, weapon in ipairs(ArmoryConfig.weapons) do
                    local hasWeapon = HasPedGotWeapon(PlayerPedId(), GetHashKey(weapon.item))
                    RageUI.Button(weapon.label, "Appuyez pour acheter", { RightLabel = (not hasWeapon) and ("~g~%s$ ~s~→"):format(ESX.Math.GroupDigits(weapon.price)) or "~r~Déjà possédé" }, true, {
                        onSelected = function()
                            if (hasWeapon) then
                                ESX.ShowNotification("~r~Erreur~s~: Vous avez déjà cette arme en votre possession")
                            else
                                TriggerServerEvent("esx_armory:buyWeapon", id)
                            end
                        end
                    })
                end
            end)
            Wait(0)
        end
    end)
end

CreateThread(function()
    while (true) do
        local interval = 250
        local pCoords = GetEntityCoords(PlayerPedId())
        for i = 1, #ArmoryConfig.positions do
            local aCoords = ArmoryConfig.positions[i]
            local dst = #(pCoords - aCoords)
            if (dst <= 20.0) then
                interval = 0
                DrawMarker(25, aCoords.x, aCoords.y, aCoords.z - 0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, false, true, 2, false, false, false, false)
                if (dst <= 1.0) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la zone")
                    if (IsControlJustPressed(0, 51)) then
                        requestOpenMenu()
                    end
                end
            end
        end
        Wait(interval)
    end
end)