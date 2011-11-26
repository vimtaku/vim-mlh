" vim:set fen fdm=marker:

let s:hira_dict = hira_dict#get()
let s:kana_dict = kana_dict#get()

inoremap <silent> f/  <C-R>=<SID>hookBackSlash('hira')<CR>
inoremap <silent> k/  <C-R>=<SID>hookBackSlash('kana')<CR>
inoremap <silent> / <C-R>=<SID>completeTransliterate(<SID>hookBackSlash('hira'))<CR>

""TODO
" bug fix
" vim とのシームレス感半端じゃないと思うんですよ。
" - 文中の中のローマ字を上手いこと対応する。
" - ,っていたときに何故かうまいこと変換できなくなる点を修正する


"" 日本語を受けてコンプリート出す
function! s:completeTransliterate(str)
    let ary = g:GoogleTransliterate(a:str)
    for candidates in (ary)
        let key = candidates[0]
        let value = candidates[1]
        call complete(col('.'), value)
    endfor
    return ""
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
        let jp_str = s:translateJapanese(dict, cword)

        return jp_str
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

