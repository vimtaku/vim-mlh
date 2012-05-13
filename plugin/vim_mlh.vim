" vim:set fen fdm=marker:

if exists('g:loaded_vim_mlh')
  finish
endif
let g:loaded_vim_mlh = 1


"" alias {{{2

vnoremap <Plug>(vim_mlh-v_transliterate)
        \ :<C-u>startinsert<CR><C-R>=<SID>visualTransliterate()<CR>
nnoremap <Plug>(vim_mlh-retransliterate)
        \ ua/<C-r>=vim_mlh#translate()<CR>
        "\ ua/<C-r>=vim_mlh#translate()<CR>
inoremap <Plug>(vim_mlh-i_retransliterate)
        \ <ESC>ua/<C-r>=vim_mlh#translate()<CR>

"" end alias }}}2

"" default command & mappings
command! ToggleVimMlhKeymap :call <SID>toggle_vim_mlh_map()
vmap /<Space> <Plug>(vim_mlh-v_transliterate)

"inoremap <C-k> <C-R>=<SID>toggle_vim_mlh_map()<CR>


function! s:visualTransliterate()
    let tmp_reg = @"
    let tmp_virtualedit = &virtualedit

    try
        set virtualedit=all
        normal! gv""y
        normal! gvd
        let cword = @"
        call vim_mlh#completeTransliterate( vim_mlh#roman2hira(cword) )
    finally
        execute "set virtualedit=" . tmp_virtualedit
        let @" = tmp_reg
        if has('x11')
            let @* = tmp_reg
        endif
    endtry

    return ""
endf

function! s:toggle_vim_mlh_map()
    if g:vim_mlh_enable == 0
        call s:mapMlh()
        echo "vim mlh enable!"
    else
        call s:unmapMlh()
        echo "vim mlh disable!"
    endif
    return ""
endfunction

function! s:mapMlh()
    let g:vim_mlh_enable = 1
    inoremap <silent> /<Space> <C-G>u<ESC>a/<C-r>=vim_mlh#translate()<CR>
    inoremap //<Space> //<Space>
endf

function! s:unmapMlh()
    let g:vim_mlh_enable = 0
    try
        iunmap /<Space>
        iunmap //<Space>
    catch
    endtry
endfun

let g:_vim_mlh_disabled_for_unite = 0
function! s:autoCmdToggleMlh()
    if &filetype == 'unite' && g:vim_mlh_enable != 0
        let g:_vim_mlh_disabled_for_unite = 1
        call <SID>unmapMlh()
    elseif g:_vim_mlh_disabled_for_unite != 0
        call <SID>mapMlh()
        let g:_vim_mlh_disabled_for_unite = 0
    endif
endf

"" Define augroup {{{2
augroup VimMlhForUniteBuffer
 au!
 auto InsertEnter * :call <SID>autoCmdToggleMlh()
augroup END
"" end Define augroup }}}


let g:vim_mlh_enable = 1
call <SID>mapMlh()

"" define private function {{{2

""" by thinca http://d.hatena.ne.jp/thinca/20111228/1325077104
"" Call a script local function.
"" Usage:
"" - S('local_func')
""   -> call s:local_func() in current file.
"" - S('plugin/hoge.vim:local_func', 'string', 10)
""   -> call s:local_func('string', 10) in *plugin/hoge.vim.
"" - S('plugin/hoge:local_func("string", 10)')
""   -> call s:local_func("string", 10) in *plugin/hoge(.vim)?.
function! s:S(f, ...)
 let [file, func] =a:f =~# ':' ?  split(a:f, ':') : [expand('%:p'), a:f]
 let fname = matchstr(func, '^\w*')

 " Get sourced scripts.
 redir =>slist
 silent scriptnames
 redir END

 let filepat = '\V' . substitute(file, '\\', '/', 'g') . '\v%(\.vim)?$'
 for s in split(slist, "\n")
   let p = matchlist(s, '^\s*\(\d\+\):\s*\(.*\)$')
   if empty(p)
     continue
   endif
   let [nr, sfile] = p[1 : 2]
   let sfile = fnamemodify(sfile, ':p:gs?\\?/?')
   if sfile =~# filepat &&
   \    exists(printf("*\<SNR>%d_%s", nr, fname))
     let cfunc = printf("\<SNR>%d_%s", nr, func)
     break
   endif
 endfor

 if !exists('nr')
   echoerr Not sourced: ' . file
   return
 elseif !exists('cfunc')
   let file = fnamemodify(file, ':p')
   echoerr printf(
   \    'File found, but function is not defined: %s: %s()', file, fname)
   return
 endif

 return 0 <= match(func, '^\w*\s*(.*)\s*$')
 \      ? eval(cfunc) : call(cfunc, a:000)
endfunction
"" end define private function }}}2



""" below script is dependent on skk.vim {{{2

if !exists('g:skk_large_jisyo')
    finish
endif
if !exists('g:skk_version')
    finish
endif

let s:jisyo_buf = s:S('plugin/skk.vim:SkkGetJisyoBuf', 'skk_large_jisyo')
let g:vim_mlh_has_jisyo_buf = 1

" arg
"  key: search target word
"  okuri: 0 or 1 # okuri is needed or not
" return
"  found -> dict line
"  not found -> ''
function! SearchFromJisyoBuf(key, okuri)
    let default_enc = &enc
    if a:okuri
        let i = s:jisyo_buf[0][0] + 1
    else
        let i = s:jisyo_buf[0][1] + 1
    endif
    let key = escape(a:key, '$.*\[]') . '\m\C'
    let converted_key = iconv(key, &enc, 'eucJP')
    set encoding=euc-jp
    let match_str = matchstr(s:jisyo_buf, converted_key, i)
    exec('set encoding='. default_enc)
    return match_str
endf

function! SearchFromSkkJisyo(key, okuri)
    let str = SearchFromJisyoBuf(a:key, a:okuri)
    let str_trimspace = substitute(str, ' ', '', 'g')
    return iconv(str_trimspace, 'eucJP', &enc)
endfu

"" key, okuri, remove_caption
function! SearchFromSkkJisyoAsList(...)
    if (a:3)
        let list = split(SearchFromSkkJisyo(a:1, a:2), '/')
        let remove_caption_list = []
        for candidate in (list)
            call add(remove_caption_list, substitute(candidate, ';.*$', '', 'g'))
        endfor
        return remove_caption_list
    else
        return split(SearchFromSkkJisyo(a:1, a:2), '/')
    endif
endfu

""" }}}2


