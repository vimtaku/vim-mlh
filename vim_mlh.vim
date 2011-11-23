" vim:set fen fdm=marker:

inoremap <silent> 8	<ESC>:call HookBackSlash('hira')<CR>
inoremap <silent> 9	<ESC>:call HookBackSlash('kana')<CR>
inoremap <silent> f/	<ESC>:call HookBackSlash('hira')<CR>
inoremap <silent> k/	<ESC>:call HookBackSlash('kana')<CR>

function! C2J(dict, c)
    if has_key(a:dict, a:c)
        return a:dict[a:c]
    endif
    return a:c
endf

function! HookBackSlash(dict_prefix)
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
        execute "normal i" . TranslateJapanese(dict, cword)
        startinsert!
    finally
        "" back
        execute "set iskeyword=" . tmp_iskeyword
        execute "set virtualedit=" . tmp_virtualedit
    endtry
endf


function! TranslateJapanese(dict, str)
    let i = 0
    let s:result = []
    let part = ""
    for e in ( range(0, strlen(a:str)) )
        let part = a:str[i : e]
        let hira = C2J(a:dict, part)
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


