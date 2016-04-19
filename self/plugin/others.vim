if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif


function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
    let f = expand("%:p")
    let cwd = expand("%:p:h")
    let root = "/home/richy/work/personal/std/cprog"
    while cwd != root
        let tagfilename = cwd . "/tags"
        if filereadable(tagfilename)
            let cmd = 'ctags -a -f ' . tagfilename . '  --fields=+l --extra=+q ' . '"' . f . '"'
            call DelTagOfFile(f)
            let resp = system(cmd)
            break
        endif
        let cwd = fnamemodify(cwd, ':h')
    endwhile
endfunction

autocmd BufWritePost *.h,*.c call UpdateTags()
