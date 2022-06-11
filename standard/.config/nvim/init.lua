-- Load All packer plugins
require('plug')

-- load keybindings and editor options
require('keymap')
require('options')
require('autocmds')

-- load theme loading library
local scheme = require('lib.scheme')
scheme.load_shared_scheme('github_dark')
-- require('themes.github_dark')

-- loading configs
require('config.lsp')
require('config.plug')
