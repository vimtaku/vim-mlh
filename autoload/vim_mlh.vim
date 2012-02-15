" vim:set fen fdm=marker:fenc=utf8

let s:hira_dict = hira_dict#get()
let s:kana_dict = kana_dict#get()

function! vim_mlh#completeTransliterate(str)
    let str = s:chomp(a:str)

    let ary = g:GoogleTransliterate(str)
    for candidates in (ary)
        let key = candidates[0]
        let value = candidates[1]
        call complete(col('.'), value)
    endfor
    return ""
endfunction

function! s:chomp(str)
    return substitute(a:str, "\n", "", "g")
endfunction

function! s:nr2byte(nr)
  if a:nr < 0x80
    return nr2char(a:nr)
  elseif a:nr < 0x800
    return nr2char(a:nr/64+192).nr2char(a:nr%64+128)
  else
    return nr2char(a:nr/4096%16+224).nr2char(a:nr/64%64+128).nr2char(a:nr%64+128)
  endif
endfunction

function! s:nr2enc_char(charcode)
  if &encoding == 'utf-8'
    return nr2char(a:charcode)
  endif
  let char = s:nr2byte(a:charcode)
  if strlen(char) > 1
    let char = strtrans(iconv(char, 'utf-8', &encoding))
  endif
  return char
endfunction

function! g:GoogleTransliterate(word)
    let word = substitute(a:word, '\s', ',', 'g')
    let url = "http://www.google.com/transliterate"
    let res = http#get(url, { "langpair": "ja-Hira|ja", "text": word }, {})
    let str = iconv(res.content, "utf-8", &encoding)
    let str = substitute(str, '\\u\(\x\x\x\x\)', '\=s:nr2enc_char("0x".submatch(1))', 'g')
    let str = substitute(str, "\n", "", "g")
    let arr = eval(str)
    return arr
endfunction

function! s:c2jc(dict, c)
    if has_key(a:dict, a:c)
        return a:dict[a:c]
    endif
    return a:c
endf

function! vim_mlh#translate()
    let save_line    = line(".")
    let save_tailcut = s:tailcut()
    let strendpos    = col('.')
    let strstartpos  = s:getConvertStartPos()
    if (strstartpos >= strendpos)
        return ""
    endif


    let prevpos = 999999
    let keep_visual_mode = 0
    while (line('.') == save_line)
        let prevpos = col('.')
        if keep_visual_mode == 0
            normal! v
        endif
        normal! f/
        if prevpos == col('.')
            break
        endif

        let l = getline('.')
        let char = l[col('.')-2]
        if has_key(s:map_trans_method_dict, char)
           let str = vim_mlh#getTranslateRegion()
           let Method = s:map_trans_method_dict[ char ]
           let ret =  Method( str[0:-3] )
           execute("normal! i". ret)
           call feedkeys("\<C-g>u", 'n')
           normal! l
           let keep_visual_mode = 0
        elseif (col('.') == col('$')-1)
           let str = vim_mlh#getTranslateRegion()
           call vim_mlh#completeTransliterate( vim_mlh#roman2hira(str[0:-2]) )
        else
           let keep_visual_mode = 1
        endif
    endwhile


    if mode() == 'v'
        normal! v
    endif

    let tmp_reg = @"
    let tmp_virtualedit = &virtualedit
    try
        set virtualedit=all
        normal! $
        let @" = (save_tailcut == ' ') ? '' : save_tailcut
        let save_cursor = getpos(".")
        normal! ""p
        call setpos('.', save_cursor)
        normal! l
    finally
        execute "set virtualedit=" . tmp_virtualedit
        let @" = tmp_reg
        if has('x11')
            let @* = tmp_reg
        endif
    endtry

    return ""
endf


function! s:tailcut()
    let tmp_reg = @"
    let tmp_virtualedit = &virtualedit
    try
        set virtualedit=all
        normal! D
        let cword = @"
        return cword
    finally
        execute "set virtualedit=" . tmp_virtualedit
        let @" = tmp_reg
        if has('x11')
            let @* = tmp_reg
        endif
    endtry
endf


function! s:getConvertStartPos()
    let tmp_virtualedit = &virtualedit
    let tmp_iskeyword = &l:iskeyword

    try
        set virtualedit=all
        setlocal iskeyword+=-
        setlocal iskeyword+=,
        setlocal iskeyword+=.
        setlocal iskeyword+=/

        normal! hb
        return col('.')
    finally
        execute "setlocal iskeyword=" . tmp_iskeyword
        execute "set virtualedit=" . tmp_virtualedit
    endtry
endfu

function! vim_mlh#getTranslateRegion()
    let tmp_reg = @"
    let tmp_virtualedit = &virtualedit
    let tmp_iskeyword = &l:iskeyword

    try
        set virtualedit=all
        setlocal iskeyword+=-
        setlocal iskeyword+=,
        setlocal iskeyword+=.
        setlocal iskeyword+=/

        normal! d
        let cword = @"
        return cword
    finally
        execute "setlocal iskeyword=" . tmp_iskeyword
        execute "set virtualedit=" . tmp_virtualedit
        let @" = tmp_reg
        if has('x11')
            let @* = tmp_reg
        endif
    endtry
endf


function! vim_mlh#roman2hira(str)
    return s:translateJapanese(s:hira_dict, a:str)
endf
function! vim_mlh#roman2kana(str)
    return s:translateJapanese(s:kana_dict, a:str)
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


function! s:const(str)
    return a:str
endf

let s:map_trans_method_dict = {
\'f' : function('vim_mlh#roman2hira'),
\'q' : function('s:const'),
\'k' : function('vim_mlh#roman2kana')
\}

