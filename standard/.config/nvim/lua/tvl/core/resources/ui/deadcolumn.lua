return {
  {
    "Bekaboo/deadcolumn.nvim",
    config = function()
      require("deadcolumn").setup({
        scope = "line",
        modes = { "i", "ic", "ix", "R", "Rc", "Rx", "Rv", "Rvc", "Rvx" },
        blending = {
          threshold = 0.50,
          colorcode = "#ea6962",
          hlgroup = {
            "Normal",
            "background",
          },
        },
        warning = {
          alpha = 0.4,
          offset = 0,
          colorcode = "#ea6962",
          hlgroup = {
            "Error",
            "background",
          },
        },
        extra = {
          follow_tw = nil,
        },
      })
    end,
  },
}
