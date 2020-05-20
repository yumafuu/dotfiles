let mapleader=","
nnoremap <space>v :source ~/.vimrc<CR>

autocmd BufNewFile,BufRead *.rb set filetype=ruby
autocmd BufNewFile,BufRead *.go set filetype=go
autocmd BufNewFile,BufRead *.py set filetype=python

"vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_gocode_propose_source = 1
autocmd BufWritePost *.go silent! :GoBuild -i
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview
" sonictemplate
let g:sonictemplate_vim_template_dir = [ '~/vim/templates' ]

" insert lh
imap <C-e> <END>
imap <C-a> <HOME>
imap <C-l> <Right>
imap <C-h> <Left>
imap <C-u> <BS>
" omnifunc
imap <C-j> <C-x><C-o>

" fzf.vim
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>a :Ag <CR>
nnoremap <silent> <leader>n :Snippets <CR>
nnoremap <Leader>v :Fern . -drawer -toggle -reveal=%<CR>
inoremap <C-@> <ESC>
nnoremap <C-[><C-[> :nohlsearch<CR><Esc>
nnoremap <C-@><C-@> :nohlsearch<CR><Esc>

" ruby
autocmd BufNewFile,BufRead .pryrc     set filetype=ruby
au FileType ruby nnoremap <leader>l :RunSpecLine<CR>
au FileType ruby nnoremap <space>b obinding.pry<ESC>
au FileType python nnoremap <space>b oimport ipdb<ESC>oipdb.set_trace()<ESC>

" go
au FileType go nmap <leader>g :GoRun<CR>
au FileType go nmap <leader>e :GoIfErr<CR>


" * not to move next word
nnoremap <silent><expr> * v:count ? '*'
\ : ':sil exe "keepj norm! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'

let g:EasyMotion_do_mapping = 0
" <Leader>e{char} to move to {char}
nmap <Space>s <Plug>(easymotion-overwin-f)
"replece
nmap m <Plug>(operator-replace)
" tabs
au FileType go nmap <C-g> :tabe<CR>:Files<CR>
nmap <C-t> :tabe<CR>:Files<CR>
nmap <C-c> :vs<CR>:Files<CR>
nmap <C-y> :tabe<CR>:Ag<CR>
nmap <C-n> gt<CR>
nmap <C-p> gT<CR>
" {[(
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>
inoremap {{ {
inoremap [[ [
inoremap (( (
inoremap "" "
inoremap '' '
inoremap `` `
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>

nnoremap <Space><Space> :set relativenumber!<CR>
nnoremap <Space><Tab> :set nu!<CR>
autocmd InsertLeave * set nopaste


nnoremap <leader>t :bot term<Space>++rows=15<CR>
nnoremap <leader>T :rightbelow vert term<space>++cols=70<CR>


" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
set showtabline=2

" Tamp
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" ; => current dir
cnoremap <expr> ; getcmdtype() == ':' ? expand('%:h') : ';'

function! s:move_cursor_pos_mapping(str, ...)
    let left = get(a:, 1, "<Left>")
    let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
    return substitute(a:str, '<Cursor>', '', '') . lefts
endfunction

function! _(str)
    return s:move_cursor_pos_mapping(a:str, "\<Left>")
endfunction

" delete spaces
autocmd BufWritePre * :%s/\s\+$//e

" slack token
let g:yaasita_slack_token = $IS_SLACK_TOKEN

" vim rspec
" https://github.com/itmammoth/run-rspec.vim
let g:run_rspec_bin = 'bundle exec rspec'

" google search
function! s:search_by_google()
    let line = line(".")
    let col  = col(".")
    let searchWord = expand("<cword>")
    if searchWord  != ''
        execute 'read !open https://www.google.co.jp/search\?q\=' . searchWord
        execute 'call cursor(' . line . ',' . col . ')'
    endif
endfunction
command! SearchByGoogle call s:search_by_google()
nnoremap <silent> <Space>g :SearchByGoogle<CR>

" function! s:ag_by_current_word()
"     let searchWord = expand("<cword>")
"     if searchWord  != ''
"         execute 'Ag ' . searchWord
"     endif
" endfunction
"
" command! AgByCurrentWord call s:ag_by_current_word()
" nnoremap <silent> <Space>a :AgByCurrentWord<CR>

"comment out
function! s:multi_line_comment_out()
endfunction
command! MultiLineCommentOut call s:multi_line_comment_out()
nnoremap <silent> <Space>c :MultiLineCommentOut<CR>

" -------------------------------
" Basic
" -------------------------------
syntax on
colorscheme molokai
set helplang=ja
set nu
set relativenumber
set incsearch
set smartcase
set title
set list
set nobackup
set noswapfile
set cursorline
set cursorcolumn
set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest
set expandtab
set tabstop=2
set shell=/usr/local/bin/zsh
set shiftwidth=2
set list
set listchars=tab:\▸\-,trail:·,extends:»,precedes:«,nbsp:%
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis
set hlsearch
set ignorecase
set ruler
set nocompatible
set autoread
set clipboard=unnamed,autoselect
set backspace=indent,eol,start
set exrc
set secure
set wildmenu
set wildmode=full
language en_US
filetype plugin on

" -------------------------------
" Dein.vim
" -------------------------------
" Required:
set runtimepath+=/Users/yuma/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/yuma/.cache/dein')
  call dein#begin('/Users/yuma/.cache/dein')
  " Let dein manage dein
  " Required:
  call dein#add('/Users/yuma/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add("Shougo/neosnippet-snippets")
  call dein#add('Shougo/deoplete.nvim')
  " call dein#add('Shougo/deoplete-rct')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  let g:deoplete#enable_at_startup = 1
  " let g:LanguageClient_serverCommands = {
  "     \ 'ruby': ['solargraph', 'stdio'],
  " \}
  " editor
  call dein#add('Shougo/defx.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add("tpope/vim-endwise")
  call dein#add("mattn/vim-maketable")
  call dein#add("easymotion/vim-easymotion")
  call dein#add("tpope/vim-surround")
  call dein#add("tpope/vim-repeat")
  " textobj
  call dein#add("kana/vim-textobj-user")
  call dein#add("rhysd/vim-textobj-ruby")
  call dein#add("thinca/vim-textobj-between")
  " operator
  call dein#add("kana/vim-operator-user")
  call dein#add("kana/vim-operator-replace")
  " fzf
  call dein#add("junegunn/fzf", { "build": "./install --all", "merged": 0 })
  call dein#add("junegunn/fzf.vim", { "depends": "fzf" })
  call dein#add("monochromegane/the_platinum_searcher")
  " ruby
  call dein#add("vim-ruby/vim-ruby")
  call dein#add("vim-scripts/ruby-matchit")
  " call dein#add("todesking/ruby_hl_lvar.vim")
  call dein#add("marcus/rsense")
  call dein#add("itmammoth/run-rspec.vim")
  call dein#add("ruby-formatter/rufo-vim")
  call dein#add("tpope/vim-rails")
  " go
  call dein#add("fatih/vim-go")
  " color
  call dein#add("tomasr/molokai")
  " help
  call dein#add("vim-jp/vimdoc-ja")
  " window size
  call dein#add("simeji/winresizer")
  " filer
  " call dein#add("lambdalisue/fern.vim")
  " snipets
  call dein#add("SirVer/ultisnips")
  call dein#add("honza/vim-snippets")
  " lsp
  " call dein#add("prabirshrestha/async.vim")
  " call dein#add("prabirshrestha/vim-lsp")
  " call dein#add("prabirshrestha/asyncomplete.vim")
  " call dein#add('prabirshrestha/asyncomplete-lsp.vim')
  " call dein#add('yami-beta/asyncomplete-omni.vim')
  " call dein#add('natebosch/vim-lsc')
  " let g:lsp_async_completion = 1
  " let g:asyncomplete_auto_popup = 1
  " if executable('golsp')
  "   augroup LspGo
  "     au!
  "     autocmd User lsp_setup call lsp#register_server({
  "         \ 'name': 'go-lang',
  "         \ 'cmd': {server_info->['golsp', '-mode', 'stdio']},
  "         \ 'whitelist': ['go'],
  "         \ })
  "     autocmd FileType go setlocal omnifunc=lsp#complete
  "   augroup END
  " endif

  "call dein#add()
  call dein#add('terryma/vim-expand-region')
  "call dein#add()
  "call dein#add()
  "call dein#add()

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

let g:ag_working_path_mode="r"
let g:dein#auto_recache = 1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"End dein Scripts-------------------------
