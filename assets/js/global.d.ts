import { LiveSocket } from "phoenix_live_view"

export {}

declare global {
  interface Window {
    liveSocket: LiveSocket
  }
}
