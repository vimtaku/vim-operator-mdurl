function! operator#mdurl#do(motion_wise)
  let visual_command = s:visual_command_from_wise_name(a:motion_wise)
  let tmp_reg = @"
  try
    execute 'normal!' '`['.visual_command.'`]d'
    execute 'normal! a[' . @" . ']('. @" .')'
  finally
    call s:restore_tmp_register(tmp_reg)
  endtry
endfunction

function! operator#mdurl#do_p(motion_wise)
  let visual_command = s:visual_command_from_wise_name(a:motion_wise)
  let paste = @"
  let tmp_reg = @"
  try
    execute 'normal!' '`['.visual_command.'`]d'
    execute 'normal! a[' . @" . ']('. paste .')'
  finally
    call s:restore_tmp_register(tmp_reg)
  endtry
endfunction


function! s:restore_tmp_register(tmp_reg)
    let @" = a:tmp_reg
    if &clipboard =~ 'unnamed'
        let @* = a:tmp_reg
    endif
    if has('x11')
        let @* = a:tmp_reg
    endif
endfun
function! s:visual_command_from_wise_name(wise_name)  "{{{2()
  if a:wise_name ==# 'char'
    return 'v'
  elseif a:wise_name ==# 'line'
    return 'V'
  elseif a:wise_name ==# 'block'
    return "\<C-v>"
  else
    echoerr 'E1: Invalid wise name:' string(a:wise_name)
    return 'v'  " fallback
  endif
endfunction
