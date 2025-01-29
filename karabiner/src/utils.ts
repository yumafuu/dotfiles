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
if [[ $text =~ KWS-[0-9]+ ]]; then
  # if text match https://knowledgework.atlassian.net/browse/KWS-{any} then
  # [KWS-{any}](https://knowledgework.atlassian.net/browse/KWS-{any})

  title=$\{BASH_REMATCH[0]\}
  url="https://knowledgework.atlassian.net/browse/$title"
  text=":jira: [$title]($url)"
elif [[ $text =~ https://github.com/knowledge-work/knowledgework/pull/[0-9]+ ]]; then
  # if text match https://github.com/knowledge-work/knowledgework/pull/{any}
  # then get the title of the PR and make it as [title](url)

  title=$(/opt/homebrew/bin/gh pr view $text --json title --jq .title | cut -d']' -f2)
  url=$text
  text=":github: [$title]($url)"
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
