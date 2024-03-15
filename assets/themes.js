// Flexoki is an inky color scheme for prose and code. Flexoki is designed for
// reading and writing on digital screens.
// Reference: https://stephango.com/flexoki
const flexoki = {
  base: {
    black: "#100f0f",
    paper: "#fffcf0",
    950: "#1c1b1a",
    900: "#282726",
    850: "#343331",
    800: "#403e3c",
    700: "#575653",
    600: "#6f6e69",
    500: "#878580",
    300: "#b7b5ac",
    200: "#cecdc3",
    150: "#dad8ce",
    100: "#e6e4d9",
    50: "#f2f0e5"
  },
  red: {
    600: "#af3029",
    400: "#d14d41"
  },
  orange: {
    600: "#bc5215",
    400: "#dA702c"
  },
  yellow: {
    900: "#4d3a0b",
    600: "#ad8301",
    400: "#d0a215",
    100: "#fceeb8"
  },
  green: {
    600: "#66800b",
    400: "#879a39"
  },
  cyan: {
    950: "#142625",
    600: "#24837b",
    400: "#3aa99f",
    50: "#ebf2e7"
  },
  blue: {
    950: "#12243f",
    900: "#1b395f",
    800: "#1a4272",
    700: "#1b4c89",
    600: "#205ea6",
    500: "#307ac7",
    400: "#4385be",
    300: "#91bbe8",
    200: "#c4daf3",
    100: "#e5edf9",
    50: "#f2f7fd"
  },
  purple: {
    600: "#5e409d",
    400: "#8b7ec8"
  },
  magenta: {
    600: "#a02f6f",
    400: "#ce5d97"
  }
}

const base = {
  backgroundColor: {
    "ui-primary": flexoki.base.paper
  },
  textColor: {
    "ui-primary": flexoki.base.black,
    "ui-muted": flexoki.base[600],
    "ui-faint": flexoki.base[300],
    "ui-error": flexoki.red[600],
    "ui-warning": flexoki.orange[600],
    "ui-success": flexoki.green[600],
    "ui-active": flexoki.cyan[600]
  }
}

export { base }
