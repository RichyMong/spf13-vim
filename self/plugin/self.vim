function! SaveSession(...)
    if v:this_session == ''
        echoerr "You haven't opened any session."
    else
        :exec "mksession! ".v:this_session
    endif
endfunction

" Opens the according header or source files in the same directory.
" Needed to be improved if the files don't lie in the same directory.
function! <SID>EditHeaderSourceFile()
    let l:items = split(expand('%:t'), '\.')
    if len(items) != 2
        return
    endif

    let l:supported_ext = ['c', 'cpp', 'cc', 'h', 'hpp']
    let l:index = index(l:supported_ext, l:items[1])
    if l:index < 0
        return
    endif

    if l:index > 2
        let l:fpath = map(l:supported_ext[0:2], 'l:items[0] . "." . v:val')
    else
        let l:fpath = map(l:supported_ext[3:], 'l:items[0] . "." . v:val')
    endif

    for file in l:fpath
        if filereadable(file)
            silent execute 'edit ' . file
            break
        endif
    endfor
endfunction

" Make '\' align well after all but the last line of a macro
function! MacroLineConcatenate() range
    let l:maxlen = 0
    let l:lines = {}
    for i in range(a:firstline, a:lastline)
        let l:line = getline(i)
        let l:len = strlen(l:line)
        let l:lines[i] = l:line
        if l:len > l:maxlen
            let l:maxlen = l:len
        endif
    endfor
    for [l:lineno, l:line] in items(l:lines)
        let l:line = l:lines[l:lineno]
        let l:len = strlen(l:line)
        if l:line[l:len - 1] == '\'
            let l:line = strpart(l:line, 0, l:len - 1) . ' '
        endif
        let l:line .= repeat(' ', l:maxlen - l:len + 1) . '\'
        call setline(l:lineno, l:line)
    endfor
endfunction

function! InsertLeadingLineNumber() range
    let l:number = a:lastline - a:firstline + 1
    let l:align = strlen(l:number)
    let l:index = 1
    for i in range(a:firstline, a:lastline)
        let l:leading = l:index . repeat(' ', l:align - strlen(l:index) + 1)
        let l:line = l:leading . getline(i)
        call setline(i, l:line)
        let l:index += 1
    endfor
endfunction

command! EditAccordingFile call <SID>EditHeaderSourceFile()
nnoremap <Leader>ms :silent call SaveSession()<CR>
nnoremap <Leader>me :EditAccordingFile<CR>
vnoremap <Leader>mn :call InsertLeadingLineNumber()<CR>
vnoremap <Leader>ml :silent call MacroLineConcatenate()<CR>

" Default range is the whole buffer.
command! -range=% MLC  <line1>,<line2>call MacroLineConcatenate()
