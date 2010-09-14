syn clear

syn keyword catapultRepeat          while endwhile
syn keyword catapultConditional     switch endswitch case endcase if else endif other
syn keyword catapultInclude         include
syn keyword catapultStatement       div

" Add more functions as needed
syn keyword catapultFunctions       sprint call wait start_itimer stop_itimer char substr
syn keyword catapultFunctions       hexstring hexval string str2num exists

syn match   catapultConditional     "exp switch"
syn match   catapultId              "&[a-zA-Z][a-zA-Z0-9_]*"
syn match   catapultIdArray         "%[a-zA-Z][a-zA-Z0-9_]*"
syn match   catapultNumbers         "[^a-zA-Z_]\d\+" contains=catapultNumber
syn match   catapultNumber          contained "\d\+"
syn region  catapultPort            start="{" end="}" contains=catapultId
syn region  catapultString          start="'" end="'"
syn region  catapultComment         start="//" end="$"
syn region  catapultComment         start="/\*" end="\*/"

hi def link catapultPort            SpecialChar
hi def link catapultRepeat          Repeat
hi def link catapultConditional     Conditional
hi def link catapultId              Identifier
hi def link catapultIdArray         Type
hi def link catapultString          String
hi def link catapultInclude         Include
hi def link catapultFunctions       Macro
hi def link catapultNumber          Number
hi def link catapultComment         Comment
hi def link catapultStatement       Statement

let b:current_syntax = "catapult"
