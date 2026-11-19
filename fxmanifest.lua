fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'whip_blackjack'
description 'Casino blackjack on whip: real tables, a dealer who deals, up to four players a table, money through whip.'
version '0.1.0'
author 'Flek'

shared_script '@whip_core/lib/satellite.lua'
shared_script 'config.lua'
shared_script 'shared/cards.lua'
client_scripts {
    'client/table.lua',
    'client/play.lua',
    'client/editor.lua',
    'client/cashier.lua',
}
server_scripts {
    'server/shoe.lua',
    'server/main.lua',
    'server/round.lua',
    'server/cashier.lua',
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'casinochips.png',
}

dependency 'whip_core'
whip_requires '1.0'
