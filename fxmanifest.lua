game 'gta5'
fx_version 'adamant'

lua54 'yes'

client_scripts {
    "src/vendors/RageUI/RMenu.lua",
    "src/vendors/RageUI/menu/RageUI.lua",
    "src/vendors/RageUI/menu/Menu.lua",
    "src/vendors/RageUI/menu/MenuController.lua",
    "src/vendors/RageUI/components/*.lua",
    "src/vendors/RageUI/menu/elements/*.lua",
    "src/vendors/RageUI/menu/items/*.lua",
    "src/vendors/RageUI/menu/panels/*.lua",
    "src/vendors/RageUI/menu/windows/*.lua",
}

client_script {
    'src/client/*.lua'
}

server_script {
    'src/server/*.lua'
}

shared_script {
    'config/config.lua'
}


