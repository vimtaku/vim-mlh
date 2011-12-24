" vim:set fen fdm=marker:

let s:hira_dict = hira_dict#get()
let s:kana_dict = kana_dict#get()


function! vim_mlh#completeTransliterate(str)
    let str = s:chomp(a:str)
    if str =~ "^\s*$"
        return ""
    endif
    if str =~ "\n"
        return ""
    endif

    if matchend(str, '.*q/') != -1
        let no_trans = substitute(matchstr(str, '.*q/'), 'q/', '', 'g')
        let trans_tgt_str = str[matchend(str, '.*q/') : strlen(str)]
        let ary = g:GoogleTransliterate(trans_tgt_str)
        call insert(ary, [no_trans, [no_trans]], 0)
    else
        let ary = g:GoogleTransliterate(str)
    endif


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


function! vim_mlh#hookBackSlash(dict_prefix)
    if col(".") == 1
        return ""
    endif

    let tmp_reg = @"
    let tmp_virtualedit = &virtualedit
    let tmp_iskeyword = &l:iskeyword
    execute("let dict=s:". a:dict_prefix ."_dict")

    try
        set virtualedit=all
        setlocal iskeyword+=-
        setlocal iskeyword+=,
        setlocal iskeyword+=.
        setlocal iskeyword+=/


        normal! hvby
        execute 'normal!' '`['. 'v' .'`]'
        normal! d

        let cword = @"

        if matchend(cword, '.*q/') != -1
            let no_trans = matchstr(cword, '.*q/')
            let trans_tgt_str = cword[matchend(cword, '.*q/') : strlen(cword)]

            let jp_str = s:translateJapanese(dict, trans_tgt_str)
            return no_trans . jp_str
        else
            let jp_str = s:translateJapanese(dict, cword)
            return jp_str
        endif

    finally
        execute "setlocal iskeyword=" . tmp_iskeyword
        execute "set virtualedit=" . tmp_virtualedit
        let @" = tmp_reg
        if has('x11')
            let @* = tmp_reg
        endif
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

