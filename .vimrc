" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2024/09/18 14:02:08 by jeportie          #+#    #+#              "
"    Updated: 2024/09/18 15:12:03 by jeportie         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"==============================================================================
"                                   VIM CONFIG
"==============================================================================

"----------------------------------- GENERAL ----------------------------------
filetype plugin indent on         " Enable file type detection and indentation
syntax enable                     " Enable syntax highlighting
colorscheme onehalfdark            " Set colorscheme

set nocompatible                   " Disable vi compatibility
set signcolumn=yes                 " Always show sign column
set noexpandtab                    " Use tabs instead of spaces
set tabstop=4                      " Set tab width to 4 spaces
set shiftwidth=4                   " Indent/outdent by 4 spaces
set mouse=a                        " Enable mouse support
set number                         " Show line numbers
set cursorline                     " Highlight the current line
set foldmethod=manual              " Enable manual code folding
set incsearch                      " Incremental search
set hlsearch                       " Highlight search matches
set splitbelow                     " Horizontal splits open below
set splitright                     " Vertical splits open to the right
set hidden                         " Allow background buffers
set history=200                    " Set command history limit
set scrolloff=8                    " Keep 8 lines above/below the cursor
set wildmenu                       " Enable command-line completion

"--------------------------------- 42 SETTINGS --------------------------------
let g:user42 = 'jeportie'          " 42 username
let g:mail42 = 'jeportie@student.42.fr'  " 42 email

"==============================================================================
"                                 MAPPINGS
"==============================================================================

"------------------------------- VIM SHORTCUTS -------------------------------
nnoremap <leader>u :NERDTreeRefreshRoot<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>s :split<CR>
nnoremap <leader>vs :vertical split<CR>
nnoremap <leader>t :terminal<CR>
nnoremap <leader>vt :vertical terminal<CR>
nnoremap <leader>r :set relativenumber<CR>
nnoremap <leader>nr :set norelativenumber<CR>
nnoremap <Leader>cc :set colorcolumn=80<CR>
nnoremap <Leader>ncc :set colorcolumn-=80<CR>
nnoremap <leader>L :set list!<CR> 
nnoremap <c-h> :set hlsearch!<CR>

"-------------------------------- PLUGIN MAPS ---------------------------------
nnoremap <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<CR>
nnoremap <F4> :Files<CR>
nnoremap <C-M> :bnext<CR>
nnoremap <C-N> :bprev<CR>
tnoremap <F5> <C-w>N

"==============================================================================
"                                 PLUGIN SETTINGS
"==============================================================================

"------------------------------ PLUGIN MANAGER -------------------------------
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged')
Plugin 'VundleVim/Vundle.vim'      " Let Vundle manage itself

"----------------------------- PLUGIN LIST ------------------------------------
Plugin 'vim-airline/vim-airline'
Plugin '42Paris/42header'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'
Plugin 'GuilloteauQ/vim-hgen'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'jeportie/NorminetteRun'
Plugin 'tyru/open-browser.vim'
Plugin 'aklt/plantuml-syntax'
Plugin 'scrooloose/vim-slumlord'
Plugin 'weirongxu/plantuml-previewer.vim'
Plugin 'itchyny/calendar.vim'      " Calendar plugin
Plugin 'sheerun/vim-polyglot'      " Language support
Plugin 'dense-analysis/ale'        " Linter
Plugin 'ap/vim-buftabline'         " Buffer tab line
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'          " FZF fuzzy finder
Plugin 'airblade/vim-rooter'       " Auto change working directory
Plugin 'jiangmiao/auto-pairs'      " Auto-closing pairs
let g:AutoPairsShortcutToggle = '<C-P>'  " Auto-pairs toggle shortcut
Plugin 'mattn/emmet-vim'           " Emmet for HTML/CSS
let g:user_emmet_leader_key=','     " Emmet leader key
Plugin 'preservim/nerdtree'        " NERDTree file explorer
Plugin 'preservim/tagbar'          " Tagbar for code navigation

call vundle#end()                  " Finish Vundle initialization

"==============================================================================
"                                 PLUGIN SETTINGS
"==============================================================================

"------------------------------- NERDTree CONFIG ------------------------------
let NERDTreeShowBookmarks = 1      " Show bookmarks in NERDTree
let NERDTreeShowHidden = 1         " Show hidden files in NERDTree
let NERDTreeShowLineNumbers = 0    " Hide line numbers in NERDTree
let NERDTreeMinimalMenu = 1        " Use minimal menu in NERDTree
let NERDTreeWinSize = 31           " Set NERDTree panel width

function! DisableNERDTreeForSpecificFiles()
  " Disable NERDTree for .todo.md files
  if expand('%:e') == 'md' && expand('%:t') =~ '\.todo\.md$'
    if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
      execute "NERDTreeClose"
    endif
    let g:NERDTreeHijackNetrw = 0
    let g:NERDTreeQuitOnOpen = 1
    return
  endif

  " Get the full path of the file relative to the current directory
  let file_path = expand('%:p')

  " Disable NERDTree for files inside a local ".calendar" directory
  if file_path =~# '\v/calendar/.*\.calendar$'
    if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
      execute "NERDTreeClose"
    endif
    let g:NERDTreeHijackNetrw = 0
    return
  endif

  " For all other files, enable NERDTree normally
  let g:NERDTreeHijackNetrw = 1
  let g:NERDTreeQuitOnOpen = 0
endfunction

" Call the function on entering the buffer to control NERDTree
autocmd BufEnter * call DisableNERDTreeForSpecificFiles()

" Start NERDTree only if no file is provided, and NERDTree is enabled
autocmd VimEnter * if argc() == 0 && g:NERDTreeHijackNetrw | NERDTree | endif

" Open the existing NERDTree on each new tab (if allowed)
autocmd BufWinEnter * if getcmdwintype() == '' && g:NERDTreeHijackNetrw | silent NERDTreeMirror | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"------------------------------ TAGBAR SETTINGS ------------------------------
let g:tagbar_autofocus = 1         " Auto-focus tagbar
let g:tagbar_autoshowtag = 1       " Highlight active tag
let g:tagbar_position = 'botright vertical'

autocmd BufReadPost,BufNewFile *.uml :PlantumlOpen
let g:plantuml_executable_script = "~/bin/plantuml.sh"

"==============================================================================
"                                 YOU COMPLETE ME
"==============================================================================

let g:ycm_global_ycm_extra_conf = "/home/jeportie/Documents/42_student/rank3/philo/ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0  " Automatically load the config without asking for confirmation
let g:ycm_clangd_binary_path = '~/Downloads/clangd_18.1.3/bin/clangd'

" Global flag to prevent running the function multiple times
let g:ycm_conf_linked = 0

" Check if the function SetYCMConfPath is already defined
if !exists('*SetYCMConfPath')

    " Function to recursively search for ycm_extra_conf.py
    function! FindYCMConf(start_dir)
        let l:dir = a:start_dir
        while l:dir != '/'
            " Check if ycm_extra_conf.py exists in this directory
            if filereadable(l:dir . "/ycm_extra_conf.py")
                " Found the file, return the path
                return l:dir . "/ycm_extra_conf.py"
            endif

            " Check for project root indicators (like .git or Makefile)
            if isdirectory(l:dir . "/.git") || filereadable(l:dir . "/Makefile")
                " Stop the search if we reach a project root
                return ""
            endif

            " Move up one directory
            let l:dir = fnamemodify(l:dir, ":h")
        endwhile

        " If we reached the root and didn't find the file, return empty
        return ""
    endfunction

    " Function to call external bash script for updating .vimrc
    function! SetYCMConfPath()
        " Check if the function already ran in this session
        if g:ycm_conf_linked
            return
        endif

        " Get the current directory
        let l:current_dir = getcwd()
        let l:ycm_conf_file = FindYCMConf(l:current_dir)

        " If we found the ycm_extra_conf.py file
        if l:ycm_conf_file != ""
            " Call the external bash script to update .vimrc
            let l:script_path = '~/ycm_update_vimrc.sh'  " Path to bash script
            let l:cmd = l:script_path . " '" . l:ycm_conf_file . "'"
            call system(l:cmd)

            " Set the global flag to prevent running again
            let g:ycm_conf_linked = 1

        else
            " Error message if not found
            echohl ErrorMsg | echo "Error: ycm_extra_conf.py not found in the project directories" | echohl None
        endif
    endfunction

endif

" Autocmd to run the function once when Vim starts (only for the first buffer)
augroup YcmAutoUpdate
    autocmd!
    autocmd VimEnter * if g:ycm_conf_linked == 0 | call SetYCMConfPath() | endif
augroup END

" Manual shortcut to trigger the function
command! SetYCMConf call SetYCMConfPath()

"==============================================================================
"                     VIMRC AUTO_SAVE AND UPDATE COMMANDS
"==============================================================================

augroup AutoGitCommitVimrc
    autocmd!
    autocmd BufWritePost ~/.vimrc call AutoGitCommitPush()
augroup END

function! AutoGitCommitPush()
    let l:git_dir = expand("~")
    let l:vimrc_path = expand("~/.vimrc")
    
    " Change to the directory where .vimrc is located
    execute 'silent! lcd' l:git_dir
    
    " Stage the .vimrc file
    call system('git add ' . shellescape(l:vimrc_path))

    " Commit with a message
    call system('git commit -m "Updated .vimrc on ' . strftime("%Y-%m-%d %H:%M:%S") . '"')

    " Push to the remote
    call system('git push origin master')
endfunction

function! GitPullVimrc()
    let l:flag_file = expand("~/.vimrc_pulled_flag")

    " Check if the flag file exists
    if !filereadable(l:flag_file)
        " Pull the latest changes if the flag doesn't exist
        let l:git_dir = expand("~")
        execute 'silent! lcd' l:git_dir
        call system('git pull origin master')

        " Create the flag file to mark that the pull has happened
        call writefile([], l:flag_file)
    endif
endfunction

nnoremap <leader>p :call GitPullVimrc()<CR>

"==============================================================================
"                            OTHER SETTINGS / AUTOCOMMANDS
"==============================================================================

" Norminette auto-load for 42 files
nnoremap <Leader>n :NorminetteRun<CR>
