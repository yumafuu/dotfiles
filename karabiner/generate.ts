import {
  duoLayer,
  ifApp,
  map,
  mapDoubleTap,
  mapSimultaneous,
  layer,
  simlayer,
  rule,
  // to$,
  // toApp,
  toKey,
  toPaste,
  withCondition,
  withMapper,
  withModifier,
  writeToProfile,
  toRemoveNotificationMessage,
  toUnsetVar,
  ifVar,
} from "karabiner.ts";

import {
  ReadYaml,
  toRaycast,
  toSuperPaste,
} from "./src/utils.ts";

import {
  Chrome,
  Discord,
  ReflectApp,
  Slack,
  Spark,
  Vivaldi,
  Wezterm,
  Alacritty,
} from "./src/app.ts";

import type { Setting } from "./src/types.ts";

const __dirname = new URL(".", import.meta.url).pathname;

const { apps } = await ReadYaml(`${__dirname}/setting.yaml`) as Setting;

//  '⌘': 'command'
//  '⌥': 'option'
//  '⌃': 'control',
//  '⇧': 'shift',
//  '⇪': 'caps_lock',
let raycastEmoji = 'raycast/emoji-symbols/search-emoji-symbols'
let escape = [toUnsetVar('leader'), toRemoveNotificationMessage('leader')]

const shared = [
  // ========================================================================
  rule('Hyper').manipulators([
    map('spacebar', 'left_control').toHyper()
  ]),
  // -------
  // nested
  // -------
   rule('Leader Key').manipulators([
    withCondition(ifVar('leader', 0))([
      map('l', 'Hyper')
        .toVar('leader', 1)
        .toNotificationMessage('leader', 'Leader Key: Open, Raycast, ...'),
    ]),

    withCondition(ifVar('leader', 0).unless())([
      map('escape').to(escape),
    ]),

    withCondition(ifVar('leader', 1))([
      withMapper(['o', 'r', 't'])((x) =>
        map(x)
          .toVar('leader', x)
          .toNotificationMessage('leader', `leader ${x}`),
      ),
    ]),

    withCondition(ifVar('leader', 't'))(
      [
        map('a').toPaste('ありがとうございます！'),
        map('s').toPaste('承知です！'),
        map('y').toPaste('よろしくお願いします！'),
      ].map((x) => x.to(escape)),
    ),

    withCondition(ifVar('leader', 'o'))(
      [
        map('f').toApp('Finder'),
      ].map((x) => x.to(escape)),
    ),

    withCondition(ifVar('leader', 'r'))(
      [
        map('e').to$(`open raycast://extensions/${raycastEmoji}`),
      ].map((x) => x.to(escape)),
    ),
  ]),
  // ========================================================================

  rule("Open App - shared").manipulators([
    withModifier("⌃⇧")([
      withMapper(apps.profiles.shared)((k, v) => map(k).toApp(v)),
    ]),
  ]),

  layer('/').manipulators({
    n: toPaste("石川湧馬"),
    t: toPaste("09041209240"),
    m: toPaste("yuma.fuu05@gmail.com"),
    k: toPaste("yuma.ishikawa@knowledgework.com"),
  }),
  layer('\\').manipulators({
    v: toSuperPaste(),
    c: toRaycast("raycast/system/open-camera"),
    e: toRaycast("raycast/emoji-symbols/search-emoji-symbols"),
  }),
  layer(']').manipulators({
    r: toPaste("🙏"),
    b: toPaste("👍"),
    t: toPaste("🎉"),
    n: toPaste('【社内】'),
    k: toPaste('【個人】'),
  }),

  rule("Shottr").manipulators([
    map("o", ["left_control", "left_command"]).to$(`open -g "shottr://ocr"`),
  ]),

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
    withCondition(ifApp(`${Wezterm}|${Alacritty}`).unless())([
      map("w", "left_control")
        .to("delete_or_backspace", "command"),
    ]),
  ]),

  rule("[Vivaldi][Chrome][Slack][Reflect] `left_control` + `j,k`で上下入力")
    .manipulators([
      withCondition(
        ifApp(`^${Chrome}|${ReflectApp}|${Vivaldi}|${Spark}$`),
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

  rule("[Chrome] left_control + [,]でタブ移動").manipulators([
    withCondition(ifApp(Chrome))([
      map("open_bracket", "left_control").to("tab", [
        "left_control",
        "right_shift",
      ]),
      map("close_bracket", "left_control").to("tab", ["left_control"]),
    ]),
  ]),

  rule("[Slack] 既読セット").manipulators([
    withCondition(ifApp(Slack))([
      map("h", ["left_command", "left_control"]).to("open_bracket", [
        "left_command",
      ]),
      map("l", ["left_command", "left_control"]).to("down_arrow", [
        "left_option",
        "left_shift",
      ]),
      map("j", ["left_command", "left_control"]).toMouseKey({ vertical_wheel: 1000, }),
      map("k", ["left_command", "left_control"]).toMouseKey({ vertical_wheel: -1000, }),
      map("i", ["left_command", "left_control"]).to("t", [
        "left_command",
        "left_shift",
      ]),
      map("k", "left_control").to("↑"),
      map("j", "left_control").to("↓"),
      map("h", "left_control").to("←"),
      map("l", "left_control").to("→"),
      map("spacebar", "left_control").to("1", "left_control"),

      map("d", ["left_command", "left_control"]).to$(`open "slack://channel?team=T0115RHBKBN&id=D07RLKKB8BZ"`) ,
      map("y", ["left_command", "left_control"]).to$(`open "slack://channel?team=T0115RHBKBN&id=C07SDSKJY73"`),
      map("g", ["left_command", "left_control"]).to$(`open "slack://channel?team=T0115RHBKBN&id=C09HTNGD7JT"`),
    ]),
  ]),

  rule("[Slack] ecs").manipulators([
    withCondition(ifApp(Slack))([
      map("open_bracket", ["left_option", "left_shift"]).to("escape"),
      map("open_bracket", "left_option").to("escape"),
    ]),
  ]),

  rule("[Slack] 検索remap").manipulators([
    withCondition(ifApp(Slack))([
      map("k", "left_command").to("g", ["left_command"]),
    ]),
  ]),

  rule("[Notion] left_control + [,]でタブ移動").manipulators([
    withCondition(ifApp("Notion"))([
      map("open_bracket", "left_control").to("tab", [ "left_control", "right_shift", ]),
      map("close_bracket", "left_control").to("tab", ["left_control"]),
    ]),
  ]),

  rule("left_control + left_command + g でクリップボードの中を検索").manipulators([
    map("g", ["left_control", "left_command"]).to$(`open "https://google.com/search?q=$(pbpaste)"`),
  ]),
];

const yumaAir = [
  rule("Open App - yumaAir").manipulators([
    withModifier("⌃⇧")(
      withMapper(apps.profiles.yumaAir)((k, v) => map(k).toApp(v)),
    ),
  ]),
];

const kwPro = [
  rule("Open App - kwPro").manipulators([
    withModifier("⌃⇧")(
      withMapper(apps.profiles.kwPro)((k, v) => map(k).toApp(v)),
    ),
  ]),
];

writeToProfile("Yuma-Air", [...shared, ...yumaAir]);
writeToProfile("KW-Pro", [...shared, ...kwPro]);
