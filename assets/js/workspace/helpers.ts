import clsx from "clsx"

function pageTitle(title: string) {
  // return `${title} | ${window.__WORKSPACE__.displayName}`
  return title
}

function cn(...inputs: clsx.ClassValue[]) {
  return clsx(inputs)
}

export { cn, pageTitle }
