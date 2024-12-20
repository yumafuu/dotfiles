import {
  // hyperLayer,
  duoLayer,
  ifApp,
  // ifDevice,
  // ifDeviceExists,
  map,
  mapDoubleTap,
  mapSimultaneous,
  // layer,
  // simlayer,
  rule,
  // to$,
  // toApp,
  toKey,
  // toPaste,
  withCondition,
  withMapper,
  withModifier,
  writeToProfile,
} from "karabiner.ts";

import { ObjectToHint, ReadYaml, toRaycast } from "./src/utils.ts";

import {
  Chrome,
  Discord,
  ReflectApp,
  Slack,
  Spark,
  Vivaldi,
  Wezterm,
} from "./src/app.ts";

import type { Setting, SettingKV } from "./src/types.ts";

const __dirname = new URL(".", import.meta.url).pathname;

const {
  apps,
  maps,
  links,
  snippets,
  raycasts,
} = ReadYaml(`${__dirname}/setting.yaml`) as Setting;

//  '⌘': 'command'
//  '⌥': 'option'
//  '⌃': 'control',
//  '⇧': 'shift',
//  '⇪': 'caps_lock',

const shared = [
  rule("Open App - shared").manipulators([
    withModifier("⌃⇧")([
      withMapper(apps.profiles.shared as SettingKV)((k, v) => map(k).toApp(v)),
    ]),
  ]),

  rule("Snippets").manipulators(
    Object.entries(snippets).map(([k, v]) => {
      return mapSimultaneous(
        `[${k}`.split(""),
        { key_down_order: "strict" },
        168,
      ).toPaste(v);
    }),
  ),

  rule("Remap").manipulators(
    Object.entries(maps).map(([k, v]) => {
      if (k.includes("-")) {
        const [modifier, key] = k.split("-");
        return map(key, modifier).toPaste(v);
      } else {
        return map(k).toPaste(v);
      }
    }),
  ),

  duoLayer("left_option", "l")
    .description("Open Link")
    .leaderMode()
    .notification(ObjectToHint(links))
    .manipulators(withMapper(links)((k, v) => map(k).to$(`open ${v}`))),

  duoLayer("right_option", "r")
    .description("Raycast Command")
    .leaderMode()
    .notification(ObjectToHint(raycasts))
    .manipulators(
      withMapper(raycasts)((k, v) => map(k).to$(toRaycast(v))),
    ),

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

  rule("[Slack] 爆速既読セット").manipulators([
    withCondition(ifApp(Slack))([
      map("h", ["left_command", "left_control"]).to("open_bracket", [
        "left_command",
      ]),
      map("l", ["left_command", "left_control"]).to("down_arrow", [
        "left_option",
        "left_shift",
      ]),
      map("j", ["left_command", "left_control"]).toMouseKey({
        vertical_wheel: 1000,
      }),
      map("k", ["left_command", "left_control"]).toMouseKey({
        vertical_wheel: -1000,
      }),
      map("i", ["left_command", "left_control"]).to("t", [
        "left_command",
        "left_shift",
      ]),
      map("k", "left_control").to("↑"),
      map("j", "left_control").to("↓"),
      map("h", "left_control").to("←"),
      map("l", "left_control").to("→"),
      map("spacebar", "left_control").to("1", "left_control"),

      map("o", ["left_command", "left_control"]).to$(`open "slack://channel?team=T0115RHBKBN&id=C0119U6TYHW"`),
      map("y", ["left_command", "left_control"]).to$(`open "slack://channel?team=T0115RHBKBN&id=C07SDSKJY73"`),
      map("g", ["left_command", "left_control"]).to$(`open "slack://channel?team=T0115RHBKBN&id=C07BTBXKE0H"`),
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

  rule("[Gyazo] left_option２回押しでスクリーンショット").manipulators([
    mapDoubleTap("g", "right_option").toApp("Gyazo"),
  ]),

  rule("left_control + right_shift + gでクリップボードの中を検索").manipulators([
    mapDoubleTap("g", "right_command").to$(`open "https://google.com/search?q=$(pbpaste)"`),
  ]),

  rule("[Notion] left_control + [,]でタブ移動").manipulators([
    withCondition(ifApp("Notion"))([
      map("open_bracket", "left_control").to("tab", [ "left_control", "right_shift", ]),
      map("close_bracket", "left_control").to("tab", ["left_control"]),
    ]),
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
