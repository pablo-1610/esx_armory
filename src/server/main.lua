local ESX

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

local function weaponExists(weaponId)
    return (ArmoryConfig.weapons[weaponId] ~= nil)
end

RegisterNetEvent("esx_armory:buyWeapon", function(weaponId)
    local _src <const> = source
    if (not weaponExists(weaponId)) then
        return TriggerClientEvent("esx:showNotification", _src, "~r~Erreur~s~: Une erreur est survenue")
    end
    local weaponData = ArmoryConfig.weapons[weaponId]
    local xPlayer = ESX.GetPlayerFromId(_src)
    if (xPlayer.getAccount('bank').money < weaponData.price) then
        return TriggerClientEvent("esx:showNotification", _src, "~r~Erreur~s~: Vous n'avez pas assez d'argent pour acheter cette arme")
    end
    xPlayer.removeAccountMoney('bank', weaponData.price)
    xPlayer.addWeapon(weaponData.item, 250)
    TriggerClientEvent("esx:showNotification", _src, ("~g~Succès~s~: Vous avez bien acheté l'arme (~o~%s~s~)"):format(weaponData.label))
end)