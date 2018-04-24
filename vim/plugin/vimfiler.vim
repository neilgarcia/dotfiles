" let g:loaded_netrwPlugin = 1
" let g:vimfiler_tree_leaf_icon = ""
" " let g:vimfiler_tree_opened_icon = "↳ "
" " let g:vimfiler_tree_closed_icon = " "
" let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_window_width = 40
" let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$', '^\.']

" nnoremap <silent><leader>t :VimFiler -explorer -winwidth=40<cr>
" nnoremap <silent><leader><space> :VimFilerBufferDir -explorer<cr>
" nnoremap <silent> <leader>e :call <SID>findInVimFiler()<CR>

" fun! s:executeVimFiler(...)
"   let options = a:0 ? ' ' . a:1 : ''
"   exe 'VimFiler -explorer -winwidth=' . g:vimfiler_window_width . options
" endf

" fun! s:findInVimFiler()
"   if &filetype ==# 'vimfiler'
"     exe 'wincmd w'
"   else
"     call <SID>executeVimFiler('-find')
"   endif
" endf

" call vimfiler#custom#profile('default', 'context', {
"           \ 'explorer' : 1,
"           \ 'winwidth' : 45,
"           \ 'winminwidth' : 45,
"           \ 'toggle' : 1,
"           \ 'columns' : 'type',
"           \ 'auto_expand': 1,
"           \ 'parent': 0,
"           \ 'status' : 1,
"           \ 'safe' : 0,
"           \ 'split' : 1,
"           \ 'hidden': 1,
"           \ 'no_quit' : 1,
"           \ 'force_hide' : 0,
"           \ })

" augroup ps_vimfiler
"   au!
"   au FileType vimfiler call s:vimfiler_settings()
"   autocmd FileType vimfiler nunmap <buffer> <C-l>
"   autocmd FileType vimfiler nunmap <buffer> h
"   autocmd FileType vimfiler nunmap <buffer> l
"   autocmd FileType vimfiler nunmap <buffer> H
"   autocmd FileType vimfiler nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map(
"   \ "\<Plug>(vimfiler_expand_tree)",
"   \ "\<Plug>(vimfiler_edit_file)")
" augroup END

" function! s:vimfiler_settings()
" 		nnoremap <silent><buffer><expr> v  vimfiler#do_switch_action('vsplit')
" 		nnoremap <silent><buffer><expr> s  vimfiler#do_switch_action('split')
" endfunction
