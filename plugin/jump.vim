" jump.vim - Jump
" Author: Callum Speirs <https://spei.rs>
" Version: 0.1.0


if exists("g:loaded_jump")
  finish
endif
let g:loaded_jump = 1

command! -nargs=0 JumpCurrentLine call jump#CurrentLine()

if !exists("g:jump_no_mappings") || ! g:jump_no_mappings
  nmap <leader>j <cmd>JumpCurrentLine<cr>
endif

if !exists("g:jump_keys") || !g:jump_keys
  let g:jump_keys = "etovxqpdygfblzhckisuran"
endif

" vim:set ft=vim sw=2 sts=2 et:
