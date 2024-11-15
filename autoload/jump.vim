function! jump#CurrentLine()
  " Prompt the user for a character
  let char = input('Enter a character to replace: ')

  " Validate input (ensure it's a single character)
  if len(char) != 1
    echo "Please enter a single character."
    return
  endif

  " Escape special characters for regex
  let escaped_char = escape(char, '\.*^$~[]')

  " Get the current line and initialize replacement variables
  let line_number = line('.')
  let line = getline('.')
  let result = ''
  let key_index = 0
  let jump_keys = g:jump_keys
  let highlight_positions = [] " To store positions of replaced characters

  " Iterate through the characters in the line
  for i in range(len(line))
    let c = line[i]
    if c ==# char
      " Replace with the current jump key
      let result .= jump_keys[key_index]
      " Add the position to the highlight list
      call add(highlight_positions, '\%' . line_number . 'l\%' . (i + 1) . 'c')
      " Increment the key index
      let key_index += 1
      " Wrap around or extend jump_keys if needed
      if key_index >= strlen(jump_keys)
        let key_index = 0
        let jump_keys .= g:jump_keys
      endif
    else
      " Keep the original character
      let result .= c
    endif
  endfor

  " Replace the current line with the modified result
  call setline('.', result)

  " Highlight the replaced characters
  if !empty(highlight_positions)
    " Combine positions into a single regex pattern
    let pattern = join(highlight_positions, '\|')
    " Clear existing matches and apply new highlight
    call clearmatches()
    call matchadd('Search', pattern)
  endif

  " Get jump key
  let selected_key = input('Enter jump key: ')

  " Check if the selected key is valid
  if has_key(highlight_positions, selected_key)
    " Get the position of selected key
    let pos = highlight_positions[selected_key]
    
    call cursor(pos[0], pos[1])
  else
    echo "Invalid selection"
  endif

  " Restore the original line and clear highlighting
  call setline('.', line)
  call clearmatches()
endfunction

" vim:set ft=vim sw=2 sts=2 et:
