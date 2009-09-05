" Taken from http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim
" 	Ian Tegebo <ian.tegebo@gmail.com>

augroup filetypedetect
au BufNewFile,BufRead *.wiki setf Wikipedia
au BufNewFile,BufRead *.s setf asm
au BufNewFile,BufRead *.S setf asm
au BufNewFile,BufRead *.asi setf asm
augroup END

