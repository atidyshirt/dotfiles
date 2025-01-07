local Config = require('utilities.config')

return Config
  :init()
  :set_options(require('config.defaults'))
  :set_options(require('config.general'))
  :set_options(require('config.theme'))
  :set_options(require('config.bindings'))
  :build()
