" vim:set fen fdm=marker:

command! ToggleMlhKeymap :call <SID>toggle_vim_mlh_map()
inoremap <C-k> <C-R>=<SID>toggle_vim_mlh_map()<CR>
inoremap <silent> q/ q/


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
    inoremap <silent> f/  <C-R>=vim_mlh#hookBackSlash('hira')<CR>
    inoremap <silent> k/  <C-R>=vim_mlh#hookBackSlash('kana')<CR>
    inoremap <silent> / <C-R>=vim_mlh#completeTransliterate(vim_mlh#hookBackSlash('hira'))<CR>
endf

function! s:unmapMlh()
    let g:mlh_enable = 0
    try
        iunmap f/
        execute "iunmap k/"
        execute "iunmap /"
    catch
    endtry
endfun

let g:mlh_enable = 1
call <SID>mapMlh()

augroup Mlh4Unite
    autocmd!
    auto Filetype unite :call <SID>unmapMlh()
augroup END


