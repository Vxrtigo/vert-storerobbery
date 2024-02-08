fx_version 'cerulean'
game 'gta5'

description 'Store Robbery using ox_target'
author 'Vertigo'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

shared_scripts {
    'shared/*.lua',
    '@ox_lib/init.lua'
}

lua54 'yes'
