" Good Looking
syntax on
set background=dark
set ruler

"autocmd BufReadPost * :DetectIndent 
"let g:detectindent_preferred_expandtab = 1
"let g:detectindent_preferred_indent = 4

" I rather use vim
set nocompatible

" Tabs/spaces
set expandtab
set ts=4
set sw=4
set softtabstop=4
" set list listchars=tab:»·,trail:·  " A bit annoying with tab indentation
au FileType make setlocal noexpandtab " Use tabs in Makefiles
au FileType asm setlocal noexpandtab
au FileType asm setlocal ts=8
au FileType asm setlocal sw=8
au FileType asm setlocal softtabstop=8

" Indenting
" I like to do it myself...

" Show matching brace when closing it
set showmatch

" Highlight searches
set hlsearch

" Format comments
set formatoptions-=t
set formatoptions=
set textwidth=79
au! Syntax asciidoc set formatoptions=nwaroqt
au! Syntax tex set formatoptions=nwaroqt

" File completion mode
set wildmode=list:longest,full

" Undolevels increased, watch out memory footprint ;)
set undolevels=500

" Default s/// to s///g
set gdefault

" Show the best match
set incsearch

" Some mappings
map <F2> :TlistToggle<CR>:set number<CR><Esc>
map <F3> :make<CR><Esc>
map <S-F3> :w<CR>:make<CR><Esc>
map <F4> :cn<CR><Esc>
map <F12> :q<CR><Esc>
map <S-F12> :q!<CR><Esc>
map <C-F12> :qa<CR><Esc>

" Window management
map <F5> :split<CR><Esc>
map <S-F5> :vsplit<CR><Esc>
map <F6> :tab split<CR><Esc>
map <F7> <C-W>w
map <F8> gt

map <F9> :set ts=8<CR><Esc>
map <F11> @q

" Remove trailing whitespace
map <F10> :%s/[ \t]*$//<CR><Esc>

map <S-Up> :res +2<CR><Esc>
map <S-Down> :res -2<CR><Esc>
map <S-Right> :vertical res +4<CR><Esc>
map <S-Left> :vertical res -4<CR><Esc>

au BufRead *.txt call s:FTasciidoc()
"au BufNewFile,BufRead *.txt  setfiletype asciidoc

function! s:FTasciidoc()
  let in_comment_block = 0
  let n = 1
  while n < 50
    let line = getline(n)
    let n = n + 1
    if line =~ '^/\{4,}$'
      if ! in_comment_block
        let in_comment_block = 1
      else
        let in_comment_block = 0
      endif
      continue
    endif
    if in_comment_block
      continue
    endif
    if line !~ '\(^//\)\|\(^\s*$\)'
      break
    endif
  endwhile
  if line !~ '.\{3,}'
    return
  endif
  let len = len(line)
  let line = getline(n)
  if line !~ '[-=]\{3,}'
    return
  endif
  if len < len(line) - 3 || len > len(line) + 3
    return
  endif
  setfiletype asciidoc
endfunction

