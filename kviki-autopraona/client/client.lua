local isWashing = false

local function createBlip(coord)
    local blip = AddBlipForCoord(coord.x, coord.y, coord.z)

    SetBlipSprite(blip, 100)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.praona.blipName)
    EndTextCommandSetBlipName(blip)

    return blip
end

for _, v in pairs(Config.praona.positions) do
    v.blip = createBlip(v.coord)

    local zone = lib.zones.box({
        coords = v.coord,
        size = v.size,
        rotation = v.rot,
        debug = v.debug,
    })
    v.zone = zone

    function zone:onEnter()
        if not IsPedInAnyVehicle(cache.ped, false) then
            return
        end
        if Config.koristiRadial then
            lib.addRadialItem({
                id = 'carwash',
                icon = Config.radialData.icon,
                label = Config.radialData.label,
                onSelect = function()
                    TriggerEvent('kviki:mozeli')
                end
            })
            if Config.radialData.useNotify then
                lib.notify({
                    title = Config.radialData.NotifyTitle,
                    description = Config.radialData.NotifyDescription,
                    type = Config.radialData.NotifyType,
                    duration = Config.radialData.NotifyDuration,
                })
            end
            return
        end
        lib.notify({
            title = Config.praona.InformNotify.title,
            description = Config.praona.InformNotify.description .. Config.praona.price .. '$',
            type = Config.praona.InformNotify.type,
            duration = Config.praona.InformNotify.duration
        })
    end

    function zone:onExit()
        if Config.koristiRadial then
            lib.removeRadialItem('carwash')
        end
    end

    function zone:inside()
        if not IsPedInAnyVehicle(cache.ped, false) then
            return
        end
        if Config.koristiRadial then
            return
        end
        if IsControlJustReleased(0, 38) then
            TriggerEvent('kviki:mozeli')
        end
    end
end

AddEventHandler('kviki:mozeli', function()
    if isWashing then
        return lib.notify({
            title = Config.praona.ErrorNotify.title,
            description = Config.praona.ErrorNotify.description,
            type = Config.praona.ErrorNotify.type
        })
    end

    TriggerServerEvent('kviki:provjeripranje')
end)

RegisterNetEvent('kviki:notifikacija', function(title, description, icon)
    lib.notify({
        title = title,
        description = description,
        type = icon
    })
end)

function startWash()
    isWashing = true
    local vehicle = GetVehiclePedIsIn(cache.ped)
    local dist = 'cut_family2'
    local fxName = 'cs_fam2_ped_water_splash'
    FreezeEntityPosition(vehicle, true)
    RequestNamedPtfxAsset(dist)
    while not HasNamedPtfxAssetLoaded(dist) do
        Wait(1)
    end
    UseParticleFxAssetNextCall(dist)
    local particle = StartParticleFxLoopedAtCoord(fxName, GetEntityCoords(cache.ped), 0.0, 0.0, 0.0, 8.0, false,
        false,
        false, 0)
    if lib.progressCircle({
            duration = Config.praona.progress.duration,
            label = Config.praona.progress.label,
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                move = true,
                combat = true,
                mouse = true
            }
        })
    then
        StopParticleFxLooped(particle, false)
        SetVehicleDirtLevel(vehicle, 0.0)
        WashDecalsFromVehicle(vehicle, 1.0)
        FreezeEntityPosition(vehicle, false)
        isWashing = false
        lib.notify({
            title = Config.praona.SuccessNotify.title,
            description = Config.praona.SuccessNotify.description,
            type = Config.praona.SuccessNotify.type
        })
    end
end
RegisterNetEvent('kviki:pocnipranje', startWash)
