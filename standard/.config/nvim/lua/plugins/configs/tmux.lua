-- tpipeline configuration
vim.g['tpipeline_preservebg'] = 1
vim.g['tpipeline_autoembed'] = 0
vim.g['tpipeline_split'] = 0
vim.g['tpipeline_focuslost'] = 0
vim.cmd [[highlight MyBackground guifg=#a89984 guibg=#504945]]
vim.g['tpipeline_statusline'] = '%#MyBackground#%t'
vim.o.titlestring = "%t - Vim"
