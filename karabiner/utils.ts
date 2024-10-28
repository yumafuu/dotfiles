import fs from "fs";
import { parse } from "jsr:@std/yaml";

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

export const ReadYaml = (filename: string) => {
  const yaml = fs.readFileSync(filename);
  return parse(yaml);
};

export const toRaycast = (path: string) => {
  return `open raycast://${path}`;
};
