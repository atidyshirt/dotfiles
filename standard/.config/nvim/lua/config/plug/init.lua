--[[
This init file loads all of the plugin configuration files
--]]

return {
	require('config.plug.cmp'),
	require('config.plug.harpoon'),
	require('config.plug.tmux'),
	require('config.plug.lualine'),
	require('config.plug.lspkind'),
	require('config.plug.orgmode'),
	require('config.plug.gitsigns'),
	require('config.plug.ultisnips'),
	require('config.plug.autopairs'),
	require('config.plug.telescope'),
	require('config.plug.nvimcomment'),
	require('config.plug.nvimcolorizer'),
	require('config.plug.treesitter'),
}

-- # vim foldmethod=marker
