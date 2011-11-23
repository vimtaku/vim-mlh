" vim:set fen fdm=marker:

let s:hira_dict = hira_dict#get()
let s:kana_dict = kana_dict#get()

inoremap <silent> f/    <ESC>:call <SID>hookBackSlash('hira')<CR>
inoremap <silent> k/    <ESC>:call <SID>hookBackSlash('kana')<CR>

function! s:c2jc(dict, c)
    if has_key(a:dict, a:c)
        return a:dict[a:c]
    endif
    return a:c
endf

function! s:hookBackSlash(dict_prefix)
    let tmp_reg = @"
    let tmp_virtualedit = &virtualedit
    let tmp_iskeyword = &iskeyword
    execute("let dict=s:". a:dict_prefix ."_dict")

    try
        set virtualedit=all
        set iskeyword="@"
        normal vby
        let cword = expand("<cword>")

        execute 'normal!' '`['. 'v' .'`]"_d'
        execute "normal i" . s:translateJapanese(dict, cword)
        startinsert!
    finally
        "" back
        execute "set iskeyword=" . tmp_iskeyword
        execute "set virtualedit=" . tmp_virtualedit
    endtry
endf

function! s:translateJapanese(dict, str)
    let i = 0
    let s:result = []
    let part = ""
    for e in ( range(0, strlen(a:str)) )
        let part = a:str[i : e]
        let hira = s:c2jc(a:dict, part)
        if (part != hira)
            "" henkan succeed
            call add(s:result, hira)
            let i = i+ strlen(part)
            let part = ""
        endif
    endfor

    if (part != '')
        call add(s:result, part)
    endif

    return join(s:result, '')
endf


