import { load } from "js-yaml";
import { to$ } from "karabiner.ts";

export const ObjectToHint = (obj: { [key: string]: any }): string => {
  const raycastHint = (str: string) => {
    if (str.includes("extensions/")) {
      return str.split("/").at(-1);
    } else {
      return str;
    }
  };
  return Object.entries(obj)
    .map(([key, value]) => `${key}: ${raycastHint(value)}`)
    .join("\n");
};

export const ReadYaml = async (filename: string) => {
  const yaml = await (Bun.file(filename)).text();
  return load(yaml);
};

export const toRaycast = (path: string) => {
  return to$(`open raycast://extensions/${path}`)
};

export const toSuperPaste = () => {
  return to$(`
text=$(pbpaste)
# if text match https://knowledgework.atlassian.net/browse/KWS-{any} then make markdown link
# [KWS-{any}](https://knowledgework.atlassian.net/browse/KWS-{any})
if [[ $text =~ KWS-[0-9]+ ]]; then
  text="[$\{BASH_REMATCH[0]\}](https://knowledgework.atlassian.net/browse/$\{BASH_REMATCH[0]\})"
else
  text="[]($text)"
fi


osascript -e '
set prev to the clipboard
set the clipboard to "'"$text"'"
tell application "System Events"
  keystroke "v" using command down
  delay 0.1
end tell
set the clipboard to prev'

`);
}
