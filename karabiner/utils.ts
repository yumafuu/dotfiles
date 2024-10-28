import fs from "fs";
import { parse } from "jsr:@std/yaml";

export const ObjectToHint = (obj: { [key: string]: any }): string => {
  return Object.entries(obj)
    .map(([key, value]) => `${key}: ${value}`)
    .join("\n");
};

export const ReadYaml = (filename: string) => {
  const yaml = fs.readFileSync(filename);
  return parse(yaml);
};

export const toRaycast = (path: string) => {
  return `open raycast://${path}`;
};
