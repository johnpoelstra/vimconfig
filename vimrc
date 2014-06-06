call pathogen#infect()
syntax on

set ignorecase
set linebreak
set tw=0
imap jj <Esc>

set wrapmargin=0
set tw=0
set ic
set cinoptions+={2
set cindent shiftwidth=4
"colorscheme koehler
set noautoindent
set softtabstop=4
set expandtab
set incsearch

" navigate split window with ctrl+{j,k}
map <C-J> <C-W>j
map <C-K> <C-W>k

" turn off auto-indent for annoying comment pasting
" http://amix.dk/blog/post/19083
:set pastetoggle=<F3> 

" original source: http://cromwell-intl.com/linux/vim-word-count.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Here begins my automated wordcount addition.
" This combines several ideas from:
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim

" Display a status-bar.
set laststatus=2

let g:word_count="<unknown>"
function WordCount()
        return g:word_count
endfunction
function UpdateWordCount()
        let lnum = 1
        let n = 0
        while lnum <= line('$')
                let n = n + len(split(getline(lnum)))
                let lnum = lnum + 1
        endwhile
        let g:word_count = n
endfunction

" Update the count when cursor is idle in command or insert mode.
" Update when idle for 1000 msec (default is 4000 msec).

set updatetime=1000
augroup WordCounter
        au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END

" Set statusline, shown here a piece at a time
highlight User1 ctermbg=green guibg=green ctermfg=black guifg=black
set statusline=%1*                      " Switch to User1 color highlight
set statusline+=%<%F                    " file name, cut if needed at start
set statusline+=%M                      " modified flag
set statusline+=%y                      " file type
set statusline+=%=                      " separator from left to right justified
set statusline+=\ %{WordCount()}\ words,
set statusline+=\ %l/%L\ lines,\ %P     " percentage through the file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
