" Good Looking
syntax on
set background=dark
set ruler

"autocmd BufReadPost * :DetectIndent 
"let g:detectindent_preferred_expandtab = 1
"let g:detectindent_preferred_indent = 4

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 

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

" File in the titlebar
set title

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
"au! Syntax asciidoc set formatoptions=nwaroqt
au! Syntax tex set formatoptions=nwaroqt
au! BufNewFile,BufRead *.d set syntax=catapult

set modeline
set modelines=4

" File completion mode
set wildmode=list:longest,full

" Undolevels increased, watch out memory footprint ;)
set undolevels=500

" Default s/// to s///g
set gdefault

" Show the best match
set incsearch
set tags=$CTAGS_DB

function Toogle_ts()
    if &ts == 8
        set ts=4
    else
        set ts=8
    endif
endfunction

" Some mappings
map <F2> :TlistToggle<CR>:set number!<CR><Esc>
map <F1> :NERDTreeToggle<CR><Esc>
" map <F3> :make<CR><Esc>
" map <S-F3> :w<CR>:make<CR><Esc>
" map <F4> :cn<CR><Esc>
" map <F12> :q<CR><Esc>
" map <S-F12> :q!<CR><Esc>
" map <C-F12> :qa<CR><Esc>

" Window management
map <F5> :split<CR><Esc>
map <S-F5> :vsplit<CR><Esc>
map <F6> :tab split<CR><Esc>
"map <F7> <C-W>w
"map <F8> gt

map <F9> :call Toogle_ts()<CR><Esc>
map <F11> :A<CR><Esc>

" Remove trailing whitespace
map <F10> :%s/[ \t]*$//<CR><Esc>

map <S-Up> :res +2<CR><Esc>
map <S-Down> :res -2<CR><Esc>
map <S-Right> :vertical res +4<CR><Esc>
map <S-Left> :vertical res -4<CR><Esc>

"au BufNewFile,BufRead *.txt  setfiletype asciidoc

let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

autocmd FileType c set omnifunc=ccomplete#Complete
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.o$', '\.a$', '\.so$', '^\.git$' ]

nmap <silent> <esc><esc> :nohlsearch<cr>
