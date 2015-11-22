" Set nocompatible
set nocompatible

" Vundle
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
" original repos on github
Bundle 'aitjcize/vim-tomorrow-theme'
Bundle 'kien/ctrlp.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'taxilian/a.vim'
Bundle 'tpope/vim-rails.git'
Bundle 'benmills/vimux'
Bundle 'mxw/vim-jsx'

" vim-scripts repos
Bundle 'local_vimrc.vim'
Bundle 'gtk-vim-syntax'
Bundle 'matchit.zip'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

" Basic Settings
set background=dark
set backspace=indent,eol,start
set colorcolumn=81
set enc=utf8
set fileencodings=utf8,cp950,latin1
set formatoptions=tcrq
set hlsearch
set incsearch
set listchars=tab:>-,eol:$
set modeline
set ruler
set showcmd
set tenc=utf8
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
set t_Co=256
set tags+=./tags;/

syntax on
filetype plugin indent on
colorscheme Tomorrow-Night-Bright

" Set color scheme for GUI
if has("gui_running")
	color slate
endif

autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Highlight settings
highlight TabLine cterm=underline
highlight TabLine ctermfg=green
highlight ColorColumn ctermbg=lightblue
highlight Pmenu ctermfg=lightgrey
highlight PmenuSel ctermfg=lightgrey
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/

" Man Page
let $PAGER=''

" For c, cpp, sh
autocmd Filetype vim,c,cpp,cuda,sh,html,eruby,htmldjango,javascript,sql,scss,lex,ruby,xml,opencl set cindent softtabstop=2 shiftwidth=2 tabstop=2 expandtab textwidth=80

" GLSL
autocmd BufNewFile,BufRead *.vp,*.fp,*.vert,*.frag,*.shd,*.gls set filetype=gls cindent comments=sr:/*,mbl:*,ex:*/,:// cindent softtabstop=2 shiftwidth=2 expandtab textwidth=80

" For python, matlab
autocmd Filetype python,matlab,css,java,qml set cindent softtabstop=2 shiftwidth=2 expandtab textwidth=80

" For Go
autocmd Filetype go set shiftwidth=2 tabstop=2 textwidth=80 noexpandtab

" For QML
autocmd BufNewFile,BufRead *.qml set ft=qml softtabstop=4 shiftwidth=4 tabstop=2 expandtab

" For OpenCL
autocmd BufNewFile,BufRead *.cl set filetype=opencl

" For diff
autocmd Filetype diff nmap q :q!<CR>

" Load tags
function s:load_indexed_tags()
  let ntags = split(system("find ~/.vim/tags -name '*.tags'"), '\n')
  let &tags = join(split(&tags, ",") + ntags, ",")
endfunction
call s:load_indexed_tags()

" For ctags
function s:gen_tags()
  echo 'Generating ctags ...'
  let s:owd = getcwd()
  let s:found = 0

  while getcwd() != '/'
    for vcsdir in ['.git', '.hg', '.svn']
      if isdirectory(getcwd() . '/' . vcsdir)
        let s:found = 1
        break
      endif
    endfor
    if s:found
      break
    endif
    cd ..
  endwhile

  if !s:found
    cd `=s:owd`
  endif

  if &ft == 'cpp'
    call system('ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .')
  else
    call system('ctags -R .')
  endif
  echo 'done'
  cd `=s:owd`
endfunction
command GenTags :call s:gen_tags()

function s:load_tags()
  while getcwd() != '/'
    if filereadable('tags')
      let &tags = &tags . ',' . getcwd() . '/tags'
      break
    endif
    cd ..
  endwhile
endfunction
command LoadTags :call s:load_tags()

" For cscope
function s:gen_cscope()
  echo 'Generating cscope database ...'
  call system("find -regex '.*\\.[hcS]+' > cscope.files")
  call system('cscope -b -f cscope.out')
  echo 'done'
  cscope add cscope.out
endfunction
command GenCscope :call s:gen_cscope()

function s:load_cscope()
  while getcwd() != '/'
    if filereadable('cscope.out')
      cscope add cscope.out
      break
    endif
    cd ..
  endwhile
endfunction
command LoadCscope :call s:load_cscope()


" For CtrlP
set wildignore+=*.o
let g:ctrlp_max_files = 0

" Tabpage
"" Open new tab
nnoremap t :tabe 

"" Goto left/right tab
""" Normal mode
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>
""" Insert mode
inoremap <C-j> <ESC>:tabprevious<CR>
inoremap <C-k> <ESC>:tabnext<CR>

"" Alt-Num mapping
""" Normal mode
noremap <unique> <script> 1 :tabn 1<CR>
noremap <unique> <script> 2 :tabn 2<CR>
noremap <unique> <script> 3 :tabn 3<CR>
noremap <unique> <script> 4 :tabn 4<CR>
noremap <unique> <script> 5 :tabn 5<CR>
noremap <unique> <script> 6 :tabn 6<CR>
noremap <unique> <script> 7 :tabn 7<CR>
noremap <unique> <script> 8 :tabn 8<CR>
noremap <unique> <script> 9 :tabn 9<CR>
noremap <unique> <script> 0 :tabn 0<CR>
""" Insert mode
inoremap <unique> <script> 1 <ESC>:tabn 1<CR>
inoremap <unique> <script> 2 <ESC>:tabn 2<CR>
inoremap <unique> <script> 3 <ESC>:tabn 3<CR>
inoremap <unique> <script> 4 <ESC>:tabn 4<CR>
inoremap <unique> <script> 5 <ESC>:tabn 5<CR>
inoremap <unique> <script> 6 <ESC>:tabn 6<CR>
inoremap <unique> <script> 7 <ESC>:tabn 7<CR>
inoremap <unique> <script> 8 <ESC>:tabn 8<CR>
inoremap <unique> <script> 9 <ESC>:tabn 9<CR>
inoremap <unique> <script> 0 <ESC>:tabn 0<CR>

" Taglist
map <F6> <ESC>:TlistToggle<CR>
let Tlist_Auto_Highlight_Tag = 1

" A
" prevent a.vim from creating *.h when it doesn't exist
let g:alternateNoDefaultAlternate = 1

" OmniCppComplete
set completeopt=menu

" Vim-Latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
"set iskeyword+=:

" Local vimrc
let g:local_vimrc='.vimrc.local'

" SnipMate
let g:snips_author = 'Wei-Ning Huang (AZ)'

" ctrlp
let g:ctrlp_open_new_file = 't'
let g:ctrlp_open_multiple_files = 't'

" Python complete-dict
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

" Calendar
let calendar_diary = '~/Documents/Calendar'

" Vimux
noremap <F7> <ESC>:VimuxCloseRunner<CR>
noremap <F8> <ESC>:VimuxPromptCommand<CR>
noremap <F9> <ESC>:VimuxRunLastCommand<CR>
