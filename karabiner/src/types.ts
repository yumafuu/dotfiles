export type AppName =
  | "Slack"
  | "Wezterm"
  | "Reflect"
  | "Spotify"
  | "Notion"
  | "Discord"
  | "Vivaldi"
  | "Line"
  | "Rhino 8"
  | "Google Chrome"
  | "zoom.us"
  | "Toggl"
  | "GoogleCalendar"
  | "Gmail";

export type Profile = {
  [key: string]: AppName;
};

export type Apps = {
  profiles: {
    shared: Profile;
    yumaAir: Profile;
    kwPro: Profile;
  };
};

export type Setting = {
  apps: Apps;
};
