import { Outlet } from "react-router-dom"
import { Panel, PanelGroup, PanelResizeHandle } from "../components/Panel"

function DashboardLayout() {
  const showSidebar = true

  return (
    <PanelGroup direction="horizontal">
      {showSidebar && (
        <>
          <Panel order={1}>
            <div>sidebar</div>
          </Panel>
          <PanelResizeHandle />
        </>
      )}
      <Panel order={2}>
        <Outlet />
      </Panel>
    </PanelGroup>
  )
}

export { DashboardLayout }
