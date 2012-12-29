" vim:set fen fdm=marker:

function! hankana_dict#get()
    return s:hankana_dict
endf

" hankana_dictionary {{{1
let s:hankana_dict = {
\'a'    :'ｱ',
\'i'    :'ｲ',
\'u'    :'ｳ',
\'e'    :'ｴ',
\'o'    :'ｵ',
\'xa'   :'ｧ',
\'xi'   :'ｨ',
\'xu'   :'ｩ',
\'xe'   :'ｪ',
\'xo'   :'ｫ',
\'va'   :'ｳﾞｧ',
\'vi'   :'ｳﾞｨ',
\'vu'   :'ｳﾞ',
\'ve'   :'ｳﾞｪ',
\'vo'   :'ｳﾞｫ',
\'ka'   :'ｶ',
\'ki'   :'ｷ',
\'ku'   :'ｸ',
\'ke'   :'ｹ',
\'ko'   :'ｺ',
\'kya'  :'ｷｬ',
\'kyu'  :'ｷｭ',
\'kyo'  :'ｷｮ',
\'ga'   :'ｶﾞ',
\'gi'   :'ｷﾞ',
\'gu'   :'ｸﾞ',
\'ge'   :'ｹﾞ',
\'go'   :'ｺﾞ',
\'gya'  :'ｷﾞｬ',
\'gyu'  :'ｷﾞｭ',
\'gyo'  :'ｷﾞｮ',
\'sa'   :'ｻ',
\'si'   :'ｼ',
\'su'   :'ｽ',
\'se'   :'ｾ',
\'so'   :'ｿ',
\'sya'  :'ｼｬ',
\'sha'  :'ｼｬ',
\'syu'  :'ｼｭ',
\'shu'  :'ｼｭ',
\'syo'  :'ｼｮ',
\'sho'  :'ｼｮ',
\'za'   :'ｻﾞ',
\'zi'   :'ｼﾞ',
\'ji'   :'ｼﾞ',
\'zu'   :'ｽﾞ',
\'ze'   :'ｾﾞ',
\'zo'   :'ｿﾞ',
\'zya'  :'ｼﾞｬ',
\'jya'  :'ｼﾞｬ',
\'ja'   :'ｼﾞｬ',
\'zyu'  :'ｼﾞｭ',
\'jyu'  :'ｼﾞｭ',
\'ju'   :'ｼﾞｭ',
\'zye'  :'ｼﾞｪ',
\'je'   :'ｼﾞｪ',
\'zyo'  :'ｼﾞｮ',
\'jyo'  :'ｼﾞｮ',
\'jo'   :'ｼﾞｮ',
\'ta'   :'ﾀ',
\'ti'   :'ﾁ',
\'chi'  :'ﾁ',
\'tu'   :'ﾂ',
\'tsu'  :'ﾂ',
\'te'   :'ﾃ',
\'to'   :'ﾄ',
\'tya'  :'ﾁｬ',
\'cha'  :'ﾁｬ',
\'tyu'  :'ﾁｭ',
\'chu'  :'ﾁｭ',
\'tyo'  :'ﾁｮ',
\'cho'  :'ﾁｮ',
\'tye'  :'ﾁｪ',
\'che'  :'ﾁｪ',
\'da'   :'ﾀﾞ',
\'di'   :'ﾁﾞ',
\'du'   :'ﾂﾞ',
\'dsu'  :'ﾂﾞ',
\'de'   :'ﾃﾞ',
\'do'   :'ﾄﾞ',
\'dya'  :'ﾁﾞｬ',
\'dyu'  :'ﾁﾞｭ',
\'dyo'  :'ﾁﾞｮ',
\'xtu'  :'ｯ',
\'xtsu' :'ｯ',
\'na'   :'ﾅ',
\'ni'   :'ﾆ',
\'nu'   :'ﾇ',
\'ne'   :'ﾈ',
\'no'   :'ﾉ',
\'nya'  :'ﾆｬ',
\'nyu'  :'ﾆｭ',
\'nyo'  :'ﾆｮ',
\'ha'   :'ﾊ',
\'hi'   :'ﾋ',
\'hu'   :'ﾌ',
\'fa'   :'ﾌｧ',
\'fi'   :'ﾌｨ',
\'fu'   :'ﾌ',
\'fe'   :'ﾌｪ',
\'fo'   :'ﾌｫ',
\'he'   :'ﾍ',
\'ho'   :'ﾎ',
\'hya'  :'ﾋｬ',
\'hyu'  :'ﾋｭ',
\'hyo'  :'ﾋｮ',
\'ba'   :'ﾊﾞ',
\'bi'   :'ﾋﾞ',
\'bu'   :'ﾌﾞ',
\'be'   :'ﾍﾞ',
\'bo'   :'ﾎﾞ',
\'bya'  :'ﾋﾞｬ',
\'byu'  :'ﾋﾞｭ',
\'byo'  :'ﾋﾞｮ',
\'pa'   :'ﾊﾟ',
\'pi'   :'ﾋﾟ',
\'pu'   :'ﾌﾟ',
\'pe'   :'ﾍﾟ',
\'po'   :'ﾎﾟ',
\'pya'  :'ﾋﾟｬ',
\'pyu'  :'ﾋﾟｭ',
\'pyo'  :'ﾋﾟｮ',
\'ma'   :'ﾏ',
\'mi'   :'ﾐ',
\'mu'   :'ﾑ',
\'me'   :'ﾒ',
\'mo'   :'ﾓ',
\'mya'  :'ﾐｬ',
\'myu'  :'ﾐｭ',
\'myo'  :'ﾐｮ',
\'ya'   :'ﾔ',
\'yu'   :'ﾕ',
\'yo'   :'ﾖ',
\'xya'  :'ｬ',
\'xyu'  :'ｮ',
\'xyo'  :'ｮ',
\'ra'   :'ﾗ',
\'ri'   :'ﾘ',
\'ru'   :'ﾙ',
\'re'   :'ﾚ',
\'ro'   :'ﾛ',
\'rya'  :'ﾘｬ',
\'ryu'  :'ﾘｭ',
\'ryo'  :'ﾘｮ',
\'wa'   :'ﾜ',
\'wi'   :'ｲ',
\'we'   :'ｴ',
\'wo'   :'ｦ',
\'nn'   :'ﾝ',
\'xxa'  :'ｯｧ',
\'xxi'  :'ｯｨ',
\'xxu'  :'ｯｩ',
\'xxe'  :'ｯｪ',
\'xxo'  :'ｯｫ',
\'vva'  :'ｯｳﾞｧ',
\'vvi'  :'ｯｳﾞｨ',
\'vvu'  :'ｯｳﾞ',
\'vve'  :'ｯｳﾞｪ',
\'vvo'  :'ｯｳﾞｫ',
\'kka'  :'ｯｶ',
\'kki'  :'ｯｷ',
\'kku'  :'ｯｸ',
\'kke'  :'ｯｹ',
\'kko'  :'ｯｺ',
\'kkya' :'ｯｷｬ',
\'kkyu' :'ｯｷｭ',
\'kkyo' :'ｯｷｮ',
\'gga'  :'ｯｶﾞ',
\'ggi'  :'ｯｷﾞ',
\'ggu'  :'ｯｸﾞ',
\'gge'  :'ｯｹﾞ',
\'ggo'  :'ｯｺﾞ',
\'ggya' :'ｯｷﾞｬ',
\'ggyu' :'ｯｷﾞｭ',
\'ggyo' :'ｯｷﾞｮ',
\'ssa'  :'ｯｻ',
\'ssi'  :'ｯｼ',
\'ssu'  :'ｯｽ',
\'sse'  :'ｯｾ',
\'sso'  :'ｯｿ',
\'ssya' :'ｯｼｬ',
\'ssha' :'ｯｼｬ',
\'ssyu' :'ｯｼｭ',
\'sshu' :'ｯｼｭ',
\'ssyo' :'ｯｼｮ',
\'ssho' :'ｯｼｬ',
\'zza'  :'ｯｻﾞ',
\'zzi'  :'ｯｼﾞ',
\'zzu'  :'ｯｽﾞ',
\'zze'  :'ｯｾﾞ',
\'zzo'  :'ｯｿﾞ',
\'zzya' :'ｯｼﾞｬ',
\'zzyu' :'ｯｼﾞｭ',
\'zzyo' :'ｯｼﾞｮ',
\'tta'  :'ｯﾀ',
\'tti'  :'ｯﾁ',
\'cchi' :'ｯﾁ',
\'ttu'  :'ｯﾂ',
\'ttsu' :'ｯﾂ',
\'tte'  :'ｯﾃ',
\'tto'  :'ｯﾄ',
\'ttya' :'ｯﾁｬ',
\'ccha' :'ｯﾁｬ',
\'ttyu' :'ｯﾁｭ',
\'cchu' :'ｯﾁｭ',
\'ttyo' :'ｯﾁｮ',
\'ccho' :'ｯﾁｮ',
\'dda'  :'ｯﾀﾞ',
\'ddi'  :'ｯﾁﾞ',
\'ddu'  :'ｯﾂﾞ',
\'ddsu' :'ｯﾂﾞ',
\'dde'  :'ｯﾃﾞ',
\'ddo'  :'ｯﾄﾞ',
\'ddya' :'ｯﾁﾞｬ',
\'ddyu' :'ｯﾁﾞｭ',
\'ddyo' :'ｯﾁﾞｮ',
\'xxtu' :'ｯｯ',
\'xxtsu':'ｯｯ',
\'hha'  :'ｯﾊ',
\'hhi'  :'ｯﾋ',
\'hhu'  :'ｯﾌ',
\'hhe'  :'ｯﾍ',
\'hho'  :'ｯﾎ',
\'hhya' :'ｯﾋｬ',
\'hhyu' :'ｯﾋｭ',
\'hhyo' :'ｯﾋｮ',
\'bba'  :'ｯﾊﾞ',
\'bbi'  :'ｯﾋﾞ',
\'bbu'  :'ｯﾌﾞ',
\'bbe'  :'ｯﾍﾞ',
\'bbo'  :'ｯﾎﾞ',
\'bbya' :'ｯﾋﾞｬ',
\'bbyu' :'ｯﾋﾞｭ',
\'bbyo' :'ｯﾋﾞｮ',
\'ppa'  :'ｯﾊﾟ',
\'ppi'  :'ｯﾋﾟ',
\'ppu'  :'ｯﾌﾟ',
\'ppe'  :'ｯﾍﾟ',
\'ppo'  :'ｯﾎﾟ',
\'ppya' :'ｯﾋﾟｬ',
\'ppyu' :'ｯﾋﾟｭ',
\'ppyo' :'ｯﾋﾟｮ',
\'mma'  :'ｯﾏ',
\'mmi'  :'ｯﾐ',
\'mmu'  :'ｯﾑ',
\'mme'  :'ｯﾒ',
\'mmo'  :'ｯﾓ',
\'mmya' :'ｯﾐｬ',
\'mmyu' :'ｯﾐｭ',
\'mmyo' :'ｯﾐｮ',
\'yya'  :'ｯﾔ',
\'yyu'  :'ｯﾕ',
\'yyo'  :'ｯﾖ',
\'xxya' :'ｯｬ',
\'xxyu' :'ｯｮ',
\'xxyo' :'ｯｮ',
\'rra'  :'ｯﾗ',
\'rri'  :'ｯﾘ',
\'rru'  :'ｯﾙ',
\'rre'  :'ｯﾚ',
\'rro'  :'ｯﾛ',
\'rrya' :'ｯﾘｬ',
\'rryu' :'ｯﾘｭ',
\'rryo' :'ｯﾘｮ',
\'wwa'  :'ｯﾜ',
\'wwi'  :'ｯｲ',
\'wwe'  :'ｯｴ',
\'wwo'  :'ｯｦ',
\'-': 'ｰ',
\',': '､',
\'.': '｡',
\'[': '｢',
\']': '｣',
\'thi'  :'ﾃｨ',
\'dhi'  :'ﾃﾞｨ',
\}
" }}}1

