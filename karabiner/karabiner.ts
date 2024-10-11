import {
  writeToProfile,
  rule,
  ifApp,
  map,
  mapSimultaneous,
  toKey,
  withCondition,
} from 'https://deno.land/x/karabinerts@1.30.0/deno.ts'

writeToProfile('Default', [

  rule('コロンとセミコロンを入れ替える').manipulators([
    // ; -> :
    map('semicolon', { optional: "caps_lock" }).to('semicolon', "left_shift"),
    // : -> ;
    map('semicolon', "shift", "caps_lock").to('semicolon'),
  ]),

  rule('左controlで英数字モードに変更').manipulators([
    map('left_control', 'optionalAny' )
      .toIfAlone(toKey('japanese_eisuu'))
      .toIfHeldDown(toKey('left_control'))
      .to({ key_code: 'left_control', lazy: true })
  ]),

  rule('migioptionキーで日本語モードに変更').manipulators([
    map('right_option', 'optionalAny')
      .toIfAlone(toKey('japanese_kana'))
      .toIfHeldDown(toKey('right_option'))
      .to({ key_code: 'right_option', lazy: true })
  ]),

  rule('[Vivaldi] ctrl + j,kで上下入力').manipulators([
    withCondition(ifApp('^com\\.vivaldi\\.Vivaldi'))([
      map('k', 'left_control').to('↑'),
      map('j', 'left_control').to('↓'),
    ])
  ]),

  rule('[Discord] Shift+Enterで送信').manipulators([
    withCondition(ifApp("^com\\.hnc\\.Discord"))([
      map("return_or_enter").to('return_or_enter', 'left_shift'),
      map("return_or_enter", "⌘").to('return_or_enter'),
    ])
  ])
])
