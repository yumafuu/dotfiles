import {
  writeToProfile,
  layer,
  simlayer,
  rule,
  ifApp,
  map,
  toKey,
  // withMapper,
  // hyperLayer,
  duoLayer,
  withCondition,
} from 'karabinerts'

writeToProfile('Default', [
  // links
  duoLayer("'", 'l').manipulators([
    map("g").to$("open https://github.com"),
    map("z").to$("open https://zenn.dev"),
    map("x").to$("open https://x.com"),
    map("y").to$("open https://youtube.com"),
    map("k").to$("open https://lms.keio.jp"),
  ]),

  // apps
  duoLayer("'", "a").manipulators([
    map("d").to$("open -a 'Discord.app'"),
    map("f").to$("open -a 'Vivaldi.app'"),
    map("r").to$("open -a 'Reflect.app'"),
    map("s").to$("open -a 'Slack.app'"),
    map("p").to$("open -a 'Spotify.app'"),
    map("k").to$("open -a 'Spotif.app'"),
  ]),

  // emoji
  duoLayer("'", 'e').manipulators([
    map('b').toPaste('🙇‍♂️'),
    map('g').toPaste('👍'),
  ]),

  // utils
  duoLayer("'", 'u').manipulators([
    map('p').to$('open raycast://extensions/thomas/color-picker/pick-color'),
    map('spacebar').to$('open raycast://extensions/raycast/raycast/confetti'),
    map('c').to$("open raycast://extensions/raycast/system/open-camera"),
    map('e').to$("open raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"),
  ]),

  rule('コロンとセミコロンを入れ替える').manipulators([
    // ; -> :
    map('semicolon', { optional: "caps_lock" }).to('semicolon', "left_shift"),
    // : -> ;
    map('semicolon', "shift", "caps_lock").to('semicolon'),
  ]),

  rule('`left_control`で英数字モードに変更').manipulators([
    map('left_control', 'optionalAny' )
      .toIfAlone(toKey('japanese_eisuu'))
      .toIfHeldDown(toKey('left_control'))
      .to({ key_code: 'left_control', lazy: true })
  ]),

  rule('`right_option`で日本語モードに変更').manipulators([
    map('right_option', 'optionalAny')
      .toIfAlone(toKey('japanese_kana'))
      .toIfHeldDown(toKey('right_option'))
      .to({ key_code: 'right_option', lazy: true })
  ]),

  rule('[!Wezterm]`left_control`+ `w`でcommand+delete').manipulators([
    withCondition(ifApp('^com\\.github\\.wez\\.wezterm').unless())([
      map('w', 'left_control')
        .to('delete_or_backspace', "command")
    ]),
  ]),

  rule('[Vivaldi][Slack] `left_control` + `j,k`で上下入力').manipulators([
    withCondition(ifApp('^com\\.vivaldi\\.Vivaldi|com\\.tinyspeck\\.slackmacgap'))([
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
