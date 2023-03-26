Config = {}

Config.koristiRadial = false
Config.radialData = {
    icon = 'soap',
    label = 'Carwash',
    useNotify = true,
    NotifyTitle = 'Carwash',
    NotifyDescription = 'Use the radial menu to start washing your car!',
    NotifyType = 'inform',
    NotifyDuration = 5000
}

Config.praona = {
    price = 200, -- cijena
    blipName = 'Auto Praonica', -- ime blipa
    progress = { 
        label = 'Pereš auto..',
        duration = 5000,
        position = 'bottom'
    },
    InformNotify = { --- ox_lib text ui
        title = 'Pranje',
        description = 'Pritisni [E] da zapocnes pranje auta. \n Price: ',
        type = 'inform',
        duration = 5000
    },
    ErrorNotify = {  -- greska
        title = 'Greška',
        description = 'Ne možeš ovo napraviti',
        type = 'error'
    },
    SuccessNotify = { -- uspjesno oprano
        title = 'Uspješno',
        description = 'Uspješno si oprao auto',
        type = 'success'
    },
    MoneyNotify = { --- nemas novac
        title = 'Greška',
        description = 'Nemaš novac',
        type = 'error'
    },
    positions = { --- lokacije auto praona, mozete da dodajete
        {coord = vector3(24.4675, -1391.8799, 29.3333), rot = 270.0, size = vec3(5, 7, 3), debug = false},
        {coord = vector3(-700.0496, -933.8840, 19.0139), rot = 360.0, size = vec3(5, 11, 6), debug = false}
    }
}