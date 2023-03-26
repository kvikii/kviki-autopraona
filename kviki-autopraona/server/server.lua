RegisterServerEvent('kviki:provjeripranje')
AddEventHandler('kviki:provjeripranje', function()
    local player <const> = source
    local price <const> = Config.praona.price

    local money = exports.ox_inventory:GetItem(player, 'money', nil, true)
    if money < price then
        return TriggerClientEvent('kviki:notifikacija', player, Config.praona.MoneyNotify.title, Config.praona.MoneyNotify.description, Config.praona.MoneyNotify.type)
    end
    exports.ox_inventory:RemoveItem(player, 'money', price)

    TriggerClientEvent('kviki:pocnipranje', player)
end)
