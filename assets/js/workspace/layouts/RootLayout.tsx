import cn from "clsx"
import { RouterProvider as AriaRouterProvider } from "react-aria-components"
import { Outlet, useNavigate } from "react-router-dom"

function RootLayout() {
  const navigate = useNavigate()
  const showGlobalBanner = false

  return (
    <AriaRouterProvider navigate={navigate}>
      <div
        role="main"
        id="main"
        className={cn(
          "relative",
          showGlobalBanner ? "h-[calc(100%-28px)]" : "h-full"
        )}
      >
        <Outlet />
      </div>
    </AriaRouterProvider>
  )
}

export { RootLayout }
