syn clear
hi clear

" Generic stuff {{{
"
" Ignore the issues with comments not being highlight correctly, `:help
" :comment` says it should be fine.

hi def link haskellComment Comment    "*any comment                           <- haskellLineComment, haskellBlockComment
hi def link haskellSpecial Special    "*any special symbol                    <- haskellPragma
hi def link haskellTodo    Todo       "*anything that needs extra attention   <- haskellTodo

" }}}

" Comments (haskellLineComent,haskellBlockComment,haskellTodo) {{{
"
" Not much else to say about this.

syn region  haskellLineComment start='--\+[-!-#$%&*+./<{}>?@\\^|~]\@!' end='\n' contains=haskellTodo
syn region  haskellBlockComment start='{-' end='-}' contains=haskellBlockComment,haskellTodo
syn keyword haskellTodo TODO FIXME XXX contained

hi def link haskellLineComment haskellComment
hi def link haskellBlockComment haskellComment

" }}}

" Pragmas (haskellPragma) {{{
"
" Anything between {-# and #-}.

syn region  haskellPragma start='{-#' end='#-}'

hi def link haskellPragma haskellSpecial

" }}}
