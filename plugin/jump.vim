" jump.vim - Jump
" Author: Callum Speirs <https://spei.rs>
" Version: 0.1.0


if exists("g:loaded_jump")
  finish
endif
let g:loaded_jump = 1

command! -nargs=0 DisplayTime call jump#DisplayTime()
command! -nargs=0 JumpCurrentLine call jump#JumpCurrentLine()

if !exists("g:jump_no_mappings") || ! g:jump_no_mappings
  nmap <leader>j <cmd>JumpCurrentLine<cr>
endif

" vim:set ft=vim sw=2 sts=2 et:
