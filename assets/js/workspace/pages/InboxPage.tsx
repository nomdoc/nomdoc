import { Helmet } from "react-helmet-async"
import { useTranslation } from "react-i18next"
import { Panel, PanelGroup, PanelResizeHandle } from "../components/Panel"
import { pageTitle } from "../helpers"

export default function InboxPage() {
  const { t } = useTranslation()

  return (
    <>
      <Helmet>
        <title>{pageTitle(t("Inbox"))}</title>
      </Helmet>
      <PanelGroup direction="horizontal">
        <Panel order={1}>
          <div>task list</div>
        </Panel>
        <PanelResizeHandle />
        <Panel order={2}>calendar</Panel>
      </PanelGroup>
    </>
  )
}
