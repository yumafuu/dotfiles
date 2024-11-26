export const TeamID = Deno.env.get("SLACK_TEAM_ID")
export const HelloChannel = Deno.env.get("SLACK_HELLO_CHANNEL") ?? "general";
