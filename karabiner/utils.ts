import fs from "fs"
import { parse, stringify } from "jsr:@std/yaml";
import { to$ } from "karabinerts";

export const KvMap = <T, U>(
  obj: { [key: string]: T },
  callback: (key: string, value: T) => U,
): { [key: string]: U } => {
  return Object.entries(obj).reduce((acc, [key, value]) => {
    acc[key] = callback(key, value);
    return acc;
  }, {} as { [key: string]: U });
};

export const ObjectToHint = (obj: { [key: string]: any }): string => {
  return Object.entries(obj)
    .map(([key, value]) => `${key}: ${value}`)
    .join("\n");
};

export const ReadYaml = (filename: string) => {
  const yaml = fs.readFileSync(filename)
  return parse(yaml);
};

export const toRaycast = (path: string) => {
  return to$(`open raycast://${path}`);
};
