import {
  // hyperLayer,
  duoLayer,
  ifApp,
  map,
  mapSimultaneous,
  // layer,
  // simlayer,
  rule,
  to$,
  toApp,
  toKey,
  toPaste,
  withCondition,
  withModifier,
  // withMapper,
  writeToProfile,
} from "karabiner.ts";

import {
  KvMap,
  ObjectToHint,
  ReadYaml,
  toRaycast,
} from "./utils.ts";

import {
  Slack,
  Discord,
  Vivaldi,
  ReflectApp,
  Spark,
  Wezterm,
} from "./app.ts"

const __dirname = new URL(".", import.meta.url).pathname

const {
  apps,
  links,
  emojis,
  phases,
  snippets,
  raycasts,
} = ReadYaml(`${__dirname}/setting.yaml`);

// {
//   '⌘': 'command',
//   '⌥': 'option',
//   '⌃': 'control',
//   '⇧': 'shift',
//   '⇪': 'caps_lock',
// }

writeToProfile("Default", [
  rule("Open App").manipulators([
    withModifier("⌃⇧")([
      KvMap(apps, (k, v) => toApp(v)),
    ]),
  ]),

  rule("Snippets").manipulators(
    Object.entries(snippets).map(([k,v]) => {
      return mapSimultaneous(`'${k}`.split(""), { key_down_order: 'strict' }, 300).toPaste(v)
    }),
  ),

  duoLayer("left_option", "l")
    .description("Open Link")
    .leaderMode()
    .notification(ObjectToHint(links))
    .manipulators(KvMap(links, (k, v) => to$(`open ${v}`))),

  duoLayer("right_option", "e")
    .description("Paste Emojis")
    .leaderMode()
    .notification(ObjectToHint(emojis))
    .manipulators(KvMap(emojis, (k, v) => toPaste(v))),

  duoLayer("left_option", "p")
    .description("Paste Phases")
    .leaderMode()
    .notification(ObjectToHint(phases))
    .manipulators(KvMap(phases, (k, v) => toPaste(v))),

  duoLayer("right_option", "r")
    .description("Raycast Command")
    .leaderMode()
    .notification(ObjectToHint(raycasts))
    .manipulators(KvMap(raycasts, (k, v) => toRaycast(v))),

  rule("コロンとセミコロンを入れ替える").manipulators([
    // ; -> :
    map("semicolon", { optional: "caps_lock" }).to("semicolon", "left_shift"),
    // : -> ;
    map("semicolon", "shift", "caps_lock").to("semicolon"),
  ]),

  rule("left_controlで英数字モードに変更").manipulators([
    map("left_control", "optionalAny")
      .toIfAlone(toKey("japanese_eisuu"))
      .toIfHeldDown(toKey("left_control"))
      .to({ key_code: "left_control", lazy: true }),
  ]),

  rule("caps_lockで英数字モードに変更").manipulators([
    map("caps_lock", "optionalAny")
      .toIfAlone(toKey("japanese_eisuu"))
      .toIfHeldDown(toKey("left_control"))
      .to({ key_code: "left_control", lazy: true }),
  ]),

  rule("right_optionで日本語モードに変更").manipulators([
    map("right_option", "optionalAny")
      .toIfAlone(toKey("japanese_kana"))
      .toIfHeldDown(toKey("right_option"))
      .to({ key_code: "right_option", lazy: true }),
  ]),

  rule("[!Wezterm]left_control+ w`でcommand+delete").manipulators([
    withCondition(ifApp(`${Wezterm}`).unless())([
      map("w", "left_control")
        .to("delete_or_backspace", "command"),
    ]),
  ]),

  rule("[Vivaldi][Slack][Reflect] `left_control` + `j,k`で上下入力").manipulators([
    withCondition(
      ifApp(`^${Slack}|${ReflectApp}|${Vivaldi}|${Spark}$`),
    )([
      map("k", "left_control").to("↑"),
      map("j", "left_control").to("↓"),
      map("h", "left_control").to("←"),
      map("l", "left_control").to("→"),
    ]),
  ]),

  rule("[Discord] Shift+Enterで送信").manipulators([
    withCondition(ifApp(`^${Discord}$`))([
      map("return_or_enter").to("return_or_enter", "left_shift"),
      map("return_or_enter", "⌘").to("return_or_enter"),
    ]),
  ]),
]);
