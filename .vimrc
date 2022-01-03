" Set nocompatible
set nocompatible

" Plugged
call plug#begin('~/.vim/plugged')

" original repos on github
Plug 'junegunn/fzf.vim'
" Plugin 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ycm-core/YouCompleteMe'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'aitjcize/vim-tomorrow-theme'
Plug 'benmills/vimux'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mxw/vim-jsx'
Plug 'mzlogin/vim-markdown-toc'
Plug 'plasticboy/vim-markdown'
Plug 'taxilian/a.vim'
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-fugitive'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'airblade/vim-gitgutter'
Plug 'dart-lang/dart-vim-plugin'
Plug 'isruslan/vim-es6'
Plug 'Quramy/tsuquyomi'
Plug 'prettier/vim-prettier'
Plug 'rust-lang/rust.vim'
Plug 'hsanson/vim-android'
Plug 'ngg/vim-gn'
Plug 'rubberduck203/aosp-vim'
" Plug 'vim-syntastic/syntastic'
Plug 'racer-rust/vim-racer'

" Nerd Tree
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-scripts repos
Plug 'vim-scripts/gtk-vim-syntax'
Plug 'vim-scripts/local_vimrc.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/hex.vim'

call plug#end()

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

" Cursor line
set cursorline
hi CursorLine cterm=underline ctermbg=NONE ctermfg=NONE

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

autocmd BufRead,BufNewFile *bot set filetype=json

" For c, cpp, sh
autocmd Filetype vim,c,cpp,proto,cuda,sh,html,eruby,htmldjango,javascript,typescript,typescript.tsx,sql,scss,lex,ruby,xml,opencl,json set cindent softtabstop=2 shiftwidth=2 tabstop=2 expandtab textwidth=80

" GLSL
autocmd BufNewFile,BufRead *.vp,*.fp,*.vert,*.frag,*.shd,*.gls set filetype=gls cindent comments=sr:/*,mbl:*,ex:*/,:// cindent softtabstop=2 shiftwidth=2 expandtab textwidth=80

" For python, matlab
autocmd Filetype python,matlab,css,java set cindent softtabstop=4 shiftwidth=4 expandtab textwidth=80

" For solidity.
autocmd Filetype python,matlab,css,java,solidity set cindent softtabstop=4 shiftwidth=4 expandtab textwidth=99 colorcolumn=101


" For Go
autocmd Filetype go set shiftwidth=2 tabstop=2 textwidth=80 noexpandtab

let g:go_fmt_command = "goimports"

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

" Python complete-dict
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

" Calendar
let calendar_diary = '~/Documents/Calendar'

" Vimux
noremap <F7> <ESC>:VimuxCloseRunner<CR>
noremap <F8> <ESC>:VimuxPromptCommand<CR>
noremap <F9> <ESC>:VimuxRunLastCommand<CR>

" vim-go
let g:go_fmt_command = "goimports"
autocmd QuickFixCmdPost *grep* cwindow

" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" YouCompleteMe
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']

" NERDTree
command! NT NERDTreeToggle

" Vim Gutter
set updatetime=100

set signcolumn=yes
let g:gitgutter_override_sign_column_highlight = 0

highlight SignColumn ctermbg=235
highlight GitGutterAdd    ctermfg=10 ctermbg=235
highlight GitGutterChange ctermfg=14 ctermbg=235
highlight GitGutterDelete ctermfg=9 ctermbg=235

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-o>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Fzf
set rtp+=~/.fzf
nnoremap <c-p> :GFiles<cr>

" Prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Racer
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END

let g:ycm_auto_hover=''
nmap <leader>D <plug>(YCMHover)
