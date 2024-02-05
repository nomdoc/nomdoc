import { DashboardLayout } from "./layouts/DashboardLayout"
import { RootLayout } from "./layouts/RootLayout"
import ErrorPage from "./pages/ErrorPage"
import InboxPage from "./pages/InboxPage"

const routes = [
  {
    path: "/",
    element: <RootLayout />,
    errorElement: <ErrorPage />,
    children: [
      {
        element: <DashboardLayout />,
        children: [
          {
            path: "inbox",
            element: <InboxPage />
          }
        ]
      }
    ]
  }
]

export { routes }
