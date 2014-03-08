if exists('g:loaded_operator_mdurl')
  finish
endif

call operator#user#define('mdurl', 'operator#mdurl#do')
call operator#user#define('mdurlp', 'operator#mdurl#do_p')

let g:loaded_operator_mdurl = 1
