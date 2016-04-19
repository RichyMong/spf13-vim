" self unplugin-related keymap. Thest start 's' is for self.
nmap <Leader>sp   :set paste!<CR>                  " toggle paste
nmap <Leader>sn   :set number! relativenumber!<CR> " toggle number options
nmap <Leader>rts :%s/ \+$//g<CR>                   " remove trailing spaces
nmap <Leader>s<Space> i <Esc>2li <Esc>
nmap ZA :qa<CR>
nmap <Leader>bu :buffers<CR>
nmap <Leader>bf :bfirst<CR>
nmap <Leader>bl :blast<CR>
nmap <Leader>bn :bnext<CR>
nmap <Leader>bp :bprevious<CR>
nmap <Leader>vc :vimgrep <cword> *.c
nmap <Leader>vp :vimgrep <cword> *.cpp
nmap <Leader>vh :vimgrep <cword> *.h
nmap <Leader>pd oimport pdb; pdb.set_trace()<Esc>:w<CR>
nmap <Leader>dw dd

imap <C-E> <End>
imap <C-A> <Home>
imap <C-j> <Up>
imap <C-k> <Down>
imap <C-B> <Left>
imap <C-F> <Right>
imap <C-I> <C-O>I
imap <C-Z> <C-O>u
