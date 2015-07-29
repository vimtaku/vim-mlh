" vim:set fen fdm=marker:fenc=utf8

"" constants
let s:hira_dict    = hira_dict#get()
let s:kana_dict    = kana_dict#get()
let s:hankana_dict = hankana_dict#get()
let s:zen_ascii_dict = zen_ascii_dict#get()
let s:map_trans_method_dict = {
\'q' : function('vim_mlh#const'),
\'f' : function('vim_mlh#roman2hira_with_complete'),
\'k' : function('vim_mlh#roman2kana_with_complete'),
\'h' : function('vim_mlh#roman2hankana_with_complete'),
\'z' : function('vim_mlh#roman2zenascii_with_complete'),
\}
let s:roman_to_translates = ["hira", "kana", "hankana", "zen_ascii"]



"" public

function! vim_mlh#completeTransliterate(str)
    let str = s:chomp(a:str)
    let ary = s:GoogleTransliterate(str)
    for candidates in (ary)
        let key = candidates[0]
        let candidate_list = candidates[1]
        let candidate_list = s:AddCandidateFromSkk(key, candidate_list)
        call complete(col('.'), candidate_list)
    endfor
    return ""
endfunction

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
    let memo_virtualedit = s:set_virtual_edit_and_return_current('all')
    try
        normal! $
        let @" = (save_tailcut == ' ') ? '' : save_tailcut
        let save_cursor = getpos(".")
        normal! ""p
        call setpos('.', save_cursor)
        normal! l
    finally
        call s:restore_virtualedit(memo_virtualedit)
        call s:restore_tmp_register(tmp_reg)
    endtry

    return ""
endf

function! vim_mlh#restore_tmp_register(tmp_reg)
    call s:restore_tmp_register(a:tmp_reg)
endfu

function! vim_mlh#getTranslateRegion()
    let tmp_reg = @"
    let memo_virtualedit = s:set_virtual_edit_and_return_current('all')
    let tmp_iskeyword = &l:iskeyword

    try
        call s:set_local_iskeywords('-,./')

        normal! d
        let cword = @"
        return cword
    finally
        execute "setlocal iskeyword=" . tmp_iskeyword
        call s:restore_virtualedit(memo_virtualedit)
        call s:restore_tmp_register(tmp_reg)
    endtry
endf


function! s:_translate_roman_to(str, translate)
    let candidates = []
    call add(candidates, s:translateJapanese(eval("s:". a:translate ."_dict"), a:str))
    for t in s:roman_to_translates
      if a:translate == t
        continue
      endif
      call add(candidates, eval("s:translateJapanese(s:" . t . "_dict, a:str)"))
    endfor
    call complete(col('.'), candidates )
endf


function! vim_mlh#roman2hira_with_complete(str)
  call s:_translate_roman_to(a:str, "hira")
endf
function! vim_mlh#roman2kana_with_complete(str)
  call s:_translate_roman_to(a:str, "kana")
endf
function! vim_mlh#roman2hankana_with_complete(str)
  call s:_translate_roman_to(a:str, "hankana")
endf
function! vim_mlh#roman2zenascii_with_complete(str)
  call s:_translate_roman_to(a:str, "zen_ascii")
endf


function! vim_mlh#roman2hira(str)
    return s:translateJapanese(s:hira_dict, a:str)
endf
function! vim_mlh#roman2kana(str)
    return s:translateJapanese(s:kana_dict, a:str)
endf
function! vim_mlh#roman2hankana(str)
    return s:translateJapanese(s:hankana_dict, a:str)
endf
function! vim_mlh#roman2zenascii(str)
    return s:translateJapanese(s:zen_ascii_dict, a:str)
endf
function! vim_mlh#const(str)
    return a:str
endf

"" search from skk
function! s:AddCandidateFromSkk(key, candidate_list)
    if (!exists('g:vim_mlh_has_jisyo_buf'))
        return a:candidate_list
    endif

    let candidates_from_skk = SearchFromSkkJisyoAsList('^'. a:key, 0, 1)
    if len(candidates_from_skk) > 0
        for cand_skk in (candidates_from_skk[1:-1])
            call add(a:candidate_list, cand_skk)
        endfor
    endif

    return a:candidate_list
endfunction


"" private libraries

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

function! s:get_key_by_dictionary(dict, key)
    if has_key(a:dict, a:key)
        return a:dict[a:key]
    endif
    return a:key
endf

function! s:tailcut()
    let tmp_reg = @"
    let memo_virtualedit = s:set_virtual_edit_and_return_current('all')
    try
        normal! D
        let cword = @"
        return cword
    finally
        call s:restore_virtualedit(memo_virtualedit)
        call s:restore_tmp_register(tmp_reg)
    endtry
endf

function! s:set_local_iskeywords(chars)
    for idx in ( range(0, strlen(a:chars)) )
        let char = a:chars[ idx ]
        execute "setlocal iskeyword+=" . char
    endfor
endfun


"" useful functions
"" set virtualedit and return previous virtualedit
function! s:set_virtual_edit_and_return_current(newvirtualedit)
    let tmp_virtualedit = &virtualedit
    execute "set virtualedit=" . a:newvirtualedit
    return tmp_virtualedit
endfu

function! s:restore_virtualedit(tmp_virtualedit)
    execute "set virtualedit=" . a:tmp_virtualedit
endfu

function! s:restore_tmp_register(tmp_reg)
    let @" = a:tmp_reg
    if &clipboard =~ 'unnamed'
        let @* = a:tmp_reg
    endif
    if has('x11')
        let @* = a:tmp_reg
    endif
endfun







function! s:getConvertStartPos()
    let memo_virtualedit = s:set_virtual_edit_and_return_current('all')
    let tmp_iskeyword = &l:iskeyword
    try
        call s:set_local_iskeywords('-,./')

        normal! hb
        return col('.')
    finally
        execute "setlocal iskeyword=" . tmp_iskeyword
        call s:restore_virtualedit(memo_virtualedit)
    endtry
endfu

function! s:translateJapanese(dict, str)
    let i = 0
    let s:result = []
    let part = ""
    for idx in ( range(0, strlen(a:str)) )
        let part = a:str[i : idx]
        let value = s:get_key_by_dictionary(a:dict, part)
        if (part != value)
            "" henkan succeed
            call add(s:result, value)
            let i = i + strlen(part)
            let part = ""
        endif
    endfor

    if (part != '')
        call add(s:result, part)
    endif

    return join(s:result, '')
endf

function! s:GoogleTransliterate(word)
    let word = substitute(a:word, '\s', ',', 'g')
    let url = "http://www.google.com/transliterate"
    let res = webapi#http#get(url, { "langpair": "ja-Hira|ja", "text": word }, {})
    let str = iconv(res.content, "utf-8", &encoding)
    let str = substitute(str, '\\u\(\x\x\x\x\)', '\=s:nr2enc_char("0x".submatch(1))', 'g')
    let str = substitute(str, "\n", "", "g")
    let arr = eval(str)
    return arr
endfunction


