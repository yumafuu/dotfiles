import {
  // hyperLayer,
  duoLayer,
  ifApp,
  // ifDevice,
  // ifDeviceExists,
  map,
  mapSimultaneous,
  // layer,
  // simlayer,
  mouseMotionToScroll,
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

import type { LayerKeyParam } from "karabiner.ts";

const left_option: LayerKeyParam = "left_option";
const right_option: LayerKeyParam = "right_option";

import { ObjectToHint, ReadYaml, toRaycast } from "./utils.ts";

import {
  Chrome,
  Discord,
  ReflectApp,
  Slack,
  Spark,
  Vivaldi,
  Wezterm,
} from "./app.ts";

import type { Setting, SettingKV } from "./types.ts";

const __dirname = new URL(".", import.meta.url).pathname;

const {
  apps,
  maps,
  links,
  snippets,
  raycasts,
} = ReadYaml(`${__dirname}/../setting.yaml`) as Setting;

// {
//   '⌘': 'command',
//   '⌥': 'option',
//   '⌃': 'control',
//   '⇧': 'shift',
//   '⇪': 'caps_lock',
// }

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

  duoLayer(left_option, "l")
    .description("Open Link")
    .leaderMode()
    .notification(ObjectToHint(links))
    .manipulators(withMapper(links)((k, v) => map(k).to$(`open ${v}`))),

  duoLayer(right_option, "r")
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
        ifApp(`^${Slack}|${Chrome}|${ReflectApp}|${Vivaldi}|${Spark}$`),
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
      map("h", ["left_option", "left_shift"]).to("open_bracket", [ "left_command" ]),
      map("l", ["left_option", "left_shift"]).to("up_arrow", [ "left_option", "left_shift", ]),
      map("j", ["left_option", "left_shift"]).toMouseKey({ vertical_wheel: 40, }),
      map("k", ["left_option", "left_shift"]).toMouseKey({ vertical_wheel: -40, }),
      map("open_bracket", ["left_option", "left_shift"]).to("escape"),
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
