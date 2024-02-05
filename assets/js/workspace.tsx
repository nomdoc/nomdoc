import i18n from "i18next"
import { StrictMode } from "react"
import { createRoot } from "react-dom/client"
import { HelmetProvider } from "react-helmet-async"
import { HotkeysProvider } from "react-hotkeys-hook"
import { initReactI18next } from "react-i18next"
import { RouterProvider, createBrowserRouter } from "react-router-dom"
import { routes } from "./workspace/routes"

function App() {
  const router = createBrowserRouter(routes)

  return (
    <StrictMode>
      <HelmetProvider>
        <HotkeysProvider>
          <RouterProvider router={router} />
        </HotkeysProvider>
      </HelmetProvider>
    </StrictMode>
  )
}

const rootNode = document.getElementById("app")

if (rootNode) {
  i18n.use(initReactI18next).init({
    lng: "en-US",
    fallbackLng: "en-US",
    debug: false
  })

  const root = createRoot(rootNode)

  root.render(<App />)
}
