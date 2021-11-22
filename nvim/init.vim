" 0 general settings
" This config set general rule for vim.
" e.g. set **, map **
runtime general_settings.vim
runtime keymaps.vim

" 1 vim-plug settings
runtime plug.vim
runtime plugins/nerdtree.vim
runtime plugins/indentline.vim
runtime plugins/rainbow.vim
runtime plugins/lightline.vim
runtime plugins/vim_gitgutter.vim
runtime plugins/fzf.vim
runtime plugins/vim_jsx_typescript.vim

" 2 coc.nvim settings
runtime plugins/coc.vim
runtime coc_plugins/prettier.vim

" 3 colorscheme settings
" This settings should be placed at last. Because 
" some coc-plugins may change highlight colors.
runtime themes/colorscheme.vim
