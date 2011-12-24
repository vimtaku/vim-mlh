" vim:set fen fdm=marker:

function! hira_dict#get()
    return s:hira_dict
endf

" hira_dictionary {{{1
let s:hira_dict = {
\'a'    : "あ",
\'i'    : "い",
\'u'    : "う",
\'e'    : "え",
\'o'    : "お",
\'xa'   : "ぁ",
\'xi'   : "ぃ",
\'xu'   : "ぅ",
\'xe'   : "ぇ",
\'xo'   : "ぉ",
\'ka'   : "か",
\'ki'   : "き",
\'ku'   : "く",
\'ke'   : "け",
\'ko'   : "こ",
\'kya'  : "きゃ",
\'kyu'  : "きゅ",
\'kyo'  : "きょ",
\'ga'   : "が",
\'gi'   : "ぎ",
\'gu'   : "ぐ",
\'ge'   : "げ",
\'go'   : "ご",
\'gya'  : "ぎゃ",
\'gyu'  : "ぎゅ",
\'gyo'  : "ぎょ",
\'sa'   : "さ",
\'si'   : "し",
\'su'   : "す",
\'se'   : "せ",
\'so'   : "そ",
\'sya'  : "しゃ",
\'sha'  : "しゃ",
\'syu'  : "しゅ",
\'shu'  : "しゅ",
\'syo'  : "しょ",
\'sho'  : "しょ",
\'za'   : "ざ",
\'zi'   : "じ",
\'ji'   : "じ",
\'zu'   : "ず",
\'ze'   : "ぜ",
\'zo'   : "ぞ",
\'zya'  : "じゃ",
\'jya'  : "じゃ",
\'ja'   : "じゃ",
\'zyu'  : "じゅ",
\'jyu'  : "じゅ",
\'ju'   : "じゅ",
\'zye'  : "じぇ",
\'jye'  : "じぇ",
\'je'   : "じぇ",
\'zyo'  : "じょ",
\'jyo'  : "じょ",
\'jo'  : "じょ",
\'ta'   : "た",
\'ti'   : "ち",
\'chi'  : "ち",
\'tu'   : "つ",
\'tsu'  : "つ",
\'te'   : "て",
\'to'   : "と",
\'tya'  : "ちゃ",
\'cha'  : "ちゃ",
\'tyu'  : "ちゅ",
\'chu'  : "ちゅ",
\'tyo'  : "ちょ",
\'cho'  : "ちょ",
\'tye'  : "ちぇ",
\'che'  : "ちぇ",
\'da'   : "だ",
\'di'   : "ぢ",
\'du'   : "づ",
\'dsu'  : "づ",
\'de'   : "で",
\'do'   : "ど",
\'dya'  : "ぢゃ",
\'dyu'  : "ぢゅ",
\'dyo'  : "ぢょ",
\'xtu'  : "っ",
\'xtsu' : "っ",
\'na'   : "な",
\'ni'   : "に",
\'nu'   : "ぬ",
\'ne'   : "ね",
\'no'   : "の",
\'nya'  : "にゃ",
\'nyu'  : "にゅ",
\'nyo'  : "にょ",
\'ha'   : "は",
\'hi'   : "ひ",
\'hu'   : "ふ",
\'fa'   : "ふぁ",
\'fi'   : "ふぃ",
\'fu'   : "ふ",
\'fe'   : "ふぇ",
\'fo'   : "ふぉ",
\'he'   : "へ",
\'ho'   : "ほ",
\'hya'  : "ひゃ",
\'hyu'  : "ひゅ",
\'hyo'  : "ひょ",
\'ba'   : "ば",
\'bi'   : "び",
\'bu'   : "ぶ",
\'be'   : "べ",
\'bo'   : "ぼ",
\'bya'  : "びゃ",
\'byu'  : "びゅ",
\'byo'  : "びょ",
\'pa'   : "ぱ",
\'pi'   : "ぴ",
\'pu'   : "ぷ",
\'pe'   : "ぺ",
\'po'   : "ぽ",
\'pya'  : "ぴゃ",
\'pyu'  : "ぴゅ",
\'pyo'  : "ぴょ",
\'ma'   : "ま",
\'mi'   : "み",
\'mu'   : "む",
\'me'   : "め",
\'mo'   : "も",
\'mya'  : "みゃ",
\'myu'  : "みゅ",
\'myo'  : "みょ",
\'ya'   : "や",
\'yu'   : "ゆ",
\'yo'   : "よ",
\'xya'  : "ゃ",
\'xyu'  : "ゅ",
\'xyo'  : "ょ",
\'ra'   : "ら",
\'ri'   : "り",
\'ru'   : "る",
\'re'   : "れ",
\'ro'   : "ろ",
\'rya'  : "りゃ",
\'ryu'  : "りゅ",
\'ryo'  : "りょ",
\'wa'   : "わ",
\'wi'   : "ゐ",
\'we'   : "ゑ",
\'wo'   : "を",
\'nn'   : "ん",
\'xxa'  : "っぁ",
\'xxi'  : "っぃ",
\'xxu'  : "っぅ",
\'xxe'  : "っぇ",
\'xxo'  : "っぉ",
\'kka'  : "っか",
\'kki'  : "っき",
\'kku'  : "っく",
\'kke'  : "っけ",
\'kko'  : "っこ",
\'kkya' : "っきゃ",
\'kkyu' : "っきゅ",
\'kkyo' : "っきょ",
\'gga'  : "っが",
\'ggi'  : "っぎ",
\'ggu'  : "っぐ",
\'gge'  : "っげ",
\'ggo'  : "っご",
\'ggya' : "っぎゃ",
\'ggyu' : "っぎゅ",
\'ggyo' : "っぎょ",
\'ssa'  : "っさ",
\'ssi'  : "っし",
\'ssu'  : "っす",
\'sse'  : "っせ",
\'sso'  : "っそ",
\'ssya' : "っしゃ",
\'ssha' : "っしゃ",
\'ssyu' : "っしゅ",
\'sshu' : "っしゅ",
\'ssyo' : "っしょ",
\'ssho' : "っしょ",
\'zza'  : "っざ",
\'zzi'  : "っじ",
\'jji'  : "っじ",
\'zzu'  : "っず",
\'zze'  : "っぜ",
\'zzo'  : "っぞ",
\'zzya' : "っじゃ",
\'jjya' : "っじゃ",
\'zzyu' : "っじゅ",
\'jjyu' : "っじゅ",
\'zzyo' : "っじょ",
\'jjyo' : "っじょ",
\'tta'  : "った",
\'tti'  : "っち",
\'cchi' : "っち",
\'ttu'  : "っつ",
\'ttsu' : "っつ",
\'tte'  : "って",
\'tto'  : "っと",
\'ttya' : "っちゃ",
\'ccha' : "っちゃ",
\'ttyu' : "っちゅ",
\'cchu' : "っちゅ",
\'ttyo' : "っちょ",
\'ccho' : "っちょ",
\'dda'  : "っだ",
\'ddi'  : "っぢ",
\'ddu'  : "っづ",
\'ddsu' : "っづ",
\'dde'  : "っで",
\'ddo'  : "っど",
\'ddya' : "っぢゃ",
\'ddyu' : "っぢゅ",
\'ddyo' : "っぢょ",
\'xxtu' : "っっ",
\'xxtsu': "っっ",
\'hha'  : "っは",
\'hhi'  : "っひ",
\'hhu'  : "っふ",
\'hhe'  : "っへ",
\'hho'  : "っほ",
\'hhya' : "っひゃ",
\'hhyu' : "っひゅ",
\'hhyo' : "っひょ",
\'bba'  : "っば",
\'bbi'  : "っび",
\'bbu'  : "っぶ",
\'bbe'  : "っべ",
\'bbo'  : "っぼ",
\'bbya' : "っびゃ",
\'bbyu' : "っびゅ",
\'bbyo' : "っびょ",
\'ppa'  : "っぱ",
\'ppi'  : "っぴ",
\'ppu'  : "っぷ",
\'ppe'  : "っぺ",
\'ppo'  : "っぽ",
\'ppya' : "っぴゃ",
\'ppyu' : "っぴゅ",
\'ppyo' : "っぴょ",
\'mma'  : "っま",
\'mmi'  : "っみ",
\'mmu'  : "っむ",
\'mme'  : "っめ",
\'mmo'  : "っも",
\'mmya' : "っみゃ",
\'mmyu' : "っみゅ",
\'mmyo' : "っみょ",
\'yya'  : "っや",
\'yyu'  : "っゆ",
\'yyo'  : "っよ",
\'xxya' : "っゃ",
\'xxyu' : "っゅ",
\'xxyo' : "っょ",
\'rra'  : "っら",
\'rri'  : "っり",
\'rru'  : "っる",
\'rre'  : "っれ",
\'rro'  : "っろ",
\'rrya' : "っりゃ",
\'rryu' : "っりゅ",
\'rryo' : "っりょ",
\'wwa'  : "っわ",
\'wwi'  : "っゐ",
\'wwe'  : "っゑ",
\'wwo'  : "っを",
\'-': "ー",
\',': "、",
\'.': "。",
\'[': "「",
\']': "」",
\'thi'  : "てぃ",
\'dhi'  : "でぃ",
\}
" }}}1
