return {
  {
    "liangxianzhe/nap.nvim",
    commit = "925921b",
    opts = {
      next_prefix = ",",
      prev_prefix = ",",
      next_repeat = "<c-n>",
      prev_repeat = "<c-p>",
    },
    init = function()
      require("nap").operator("r", {
        next = { command = require("illuminate").goto_next_reference, desc = "Next cursor word" },
        prev = { command = require("illuminate").goto_prev_reference, desc = "Prev cursor word" },
        mode = { "n", "x", "o" },
      })
      require("nap").operator("h", {
        next = {
          command = function()
            require("gitsigns").next_hunk({ preview = false, wrap = true })
          end,
          desc = "Next diff",
        },
        prev = {
          command = function()
            require("gitsigns").prev_hunk({ preview = false, wrap = true })
          end,
          desc = "Prev diff",
        },
        mode = { "n", "v", "o" },
      })
    end,
  },
}
