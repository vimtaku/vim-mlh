" vim:set fen fdm=marker:
" Basic {{{1


"" alias {{{2
vnoremap <Plug>(vim_mlh-visualTransliterate)
\ :<C-u>startinsert<CR><C-R>=<SID>visualTransliterate()<CR>
"" end alias }}}2

"" mappings
command! ToggleMlhKeymap :call <SID>toggle_vim_mlh_map()
inoremap <C-k> <C-R>=<SID>toggle_vim_mlh_map()<CR>
vmap /<Space> <Plug>(vim_mlh-visualTransliterate)


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
    if g:mlh_enable == 0
        call s:mapMlh()
        echo "mlh enable!"
    else
        call s:unmapMlh()
        echo "mlh disable!"
    endif
    return ""
endfunction

function! s:mapMlh()
    let g:mlh_enable = 1
    inoremap <silent> /<Space> <ESC>a/<C-r>=vim_mlh#translate()<CR>
    inoremap //<Space> //<Space>
endf

function! s:unmapMlh()
    let g:mlh_enable = 0
    try
        iunmap /<Space>
        iunmap //<Space> //<Space>
    catch
    endtry
endfun


function! s:autoCmdToggleMlh()
    if &filetype == 'unite'
        call <SID>unmapMlh()
        return
    endif
    call <SID>mapMlh()
endf

augroup VimMlhForUniteBuffer
 au!
 auto InsertEnter * :call <SID>autoCmdToggleMlh()
augroup END


let g:mlh_enable = 1
call <SID>mapMlh()

