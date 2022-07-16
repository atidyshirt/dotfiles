local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local o = vim.o

cmd('syntax enable') 	-- syntax highlighting
vim.o.titlestring = "%t - Vim" -- Set title string
o.rnu = true         	-- relative line numbers
o.nu = true         	-- line numbers
o.mouse = 'a'       	-- mouse controls
o.cursorline = true 	-- highlight line cursor is in
o.modeline = true   	-- enable modlines for files
o.modelines = 5			-- number of modelines

o.errorbells = false 	-- auditory stimulation annoying
vim.wo.fillchars='eob: ' -- removes tildas from empty lines

opt.ruler = false		-- how line number/column
opt.hidden = true 		-- keeps buffers loaded in the background
opt.ignorecase = true
opt.scrolloff = 4   	-- buffer starts scrolling 8 lines from the end of view
opt.incsearch = true


-- Tab settings
o.tabstop = 4 			-- 4 tabstop
o.shiftwidth = 4
o.expandtab = true    	-- tabs -> spaces
o.smartindent = true    -- nice indenting

 -- Better folding
o.foldenable = false

-- backup/swap files
opt.swapfile = false  	-- have files saved to swap
opt.undofile = true		-- file undo history preserved outside current session

-- fix clipboard
vim.o.clipboard = "unnamedplus"

-- new win split options
opt.splitbelow = true
opt.splitright = true
o.completeopt = 'menuone,noselect'

vim.opt.termguicolors = true

-- diagnostics don't show unless requested
vim.diagnostic.config({
  virtual_text = false
})

vim.api.nvim_exec('language en_US.UTF-8', true)

-- TODO: replicate this funcitionality using lua
-- vimscript persistant nobuflist for buffers that should not be in jump list
vim.cmd([[
function! s:PersistNobl()                             
  if exists('b:persist_nobl')                         
    setl nobuflisted                                
  elseif !&buflisted                                  
    let b:persist_nobl = 1                            
  endif                                               
endfunction                                           

augroup persist_nobuflisted                           
  autocmd!                                            
  autocmd OptionSet buflisted call <SID>PersistNobl() 
  autocmd BufEnter * call <SID>PersistNobl()          
augroup END
]])

