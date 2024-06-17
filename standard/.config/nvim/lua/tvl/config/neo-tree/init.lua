local Util = require("tvl.util")
local Icons = require("tvl.core.icons")

local config = {
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = Util.generate_borderchars("thick", "tl-t-tr-r-bl-b-br-l"),
  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "diagnostics",
    -- "document_symbols",
  },
  source_selector = {
    winbar = true, -- toggle to show selector on winbar
    content_layout = "center",
    tabs_layout = "equal",
    show_separator_on_edge = true,
    sources = {
      { source = "filesystem", display_name = "󰉓" },
      { source = "buffers", display_name = "󰈙" },
      { source = "git_status", display_name = "" },
      { source = "diagnostics", display_name = "󰒡" },
    },
  },
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = Icons.directory,
    modified = { symbol = "" },
    git_status = { symbols = Icons.git },
    diagnostics = { symbols = Icons.diagnostics },
  },
  window = {
    width = 40,
    mappings = {
      ["<1-LeftMouse>"] = "open",
      ["l"] = "open",
    },
  },
  filesystem = {
    window = {
      mappings = {
        ["H"] = "navigate_up",
        ["<bs>"] = "toggle_hidden",
        ["."] = "set_root",
        ["/"] = "fuzzy_finder",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["a"] = { "add", config = { show_path = "relative" } }, -- "none", "relative", "absolute"
        ["D"] = "diff_two_files",
      },
    },
    git_status = {
      window = {
        mappings = {
          ["D"] = "diff_two_files",
        },
      },
    },

    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = {
      enabled = true,
    }, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = true, -- when true, empty folders will be grouped together
  },
  async_directory_scan = "always",
}

config.commands = {
  diff_two_files = function(state)
    local node = state.tree:get_node()
    local log = require("neo-tree.log")
    state.clipboard = state.clipboard or {}
    if diff_Node and diff_Node ~= tostring(node.id) then
      local current_Diff = node.id
      require("neo-tree.utils").open_file(state, diff_Node, open)
      vim.cmd("vert diffs " .. current_Diff)
      log.info("Diffing " .. diff_Name .. " against " .. node.name)
      diff_Node = nil
      current_Diff = nil
      state.clipboard = {}
      require("neo-tree.ui.renderer").redraw(state)
    else
      local existing = state.clipboard[node.id]
      if existing and existing.action == "diff" then
        state.clipboard[node.id] = nil
        diff_Node = nil
        require("neo-tree.ui.renderer").redraw(state)
      else
        state.clipboard[node.id] = { action = "diff", node = node }
        diff_Name = state.clipboard[node.id].node.name
        diff_Node = tostring(state.clipboard[node.id].node.id)
        log.info("Diff source file " .. diff_Name)
        require("neo-tree.ui.renderer").redraw(state)
      end
    end
  end,
}

config.filesystem.components = require("tvl.config.neo-tree.sources.filesystem.components")
local function hideCursor()
  vim.cmd([[
    setlocal guicursor=n:block-Cursor
    hi Cursor blend=100
  ]])
end
local function showCursor()
  vim.cmd([[
    setlocal guicursor=a:block-Cursor
    hi Cursor blend=0
  ]])
end

local neotree_group = Util.augroup("neo-tree_hide_cursor")
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertEnter" }, {
      group = neotree_group,
      callback = function()
        local fire = vim.bo.filetype == "neo-tree" and hideCursor or showCursor
        fire()
      end,
    })
    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
      group = neotree_group,
      callback = function()
        showCursor()
      end,
    })
  end,
})

return config
