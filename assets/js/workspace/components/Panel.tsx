import * as React from "react"
import * as PanelPrimitive from "react-resizable-panels"
import { cn } from "../helpers"

const PanelGroup = PanelPrimitive.PanelGroup
const Panel = PanelPrimitive.Panel

type PanelResizeHandleProps = React.ComponentPropsWithoutRef<
  typeof PanelPrimitive.PanelResizeHandle
>

const PanelResizeHandle = ({ className, ...props }: PanelResizeHandleProps) => (
  <div className="relative w-[1px]">
    <PanelPrimitive.PanelResizeHandle
      className={cn(
        "group absolute left-1/2 -translate-x-1/2 transform-gpu w-2 h-full",
        "focus:outline-none"
      )}
      {...props}
    >
      <div
        className={cn(
          "absolute left-1/2 -translate-x-1/2 transform-gpu h-full w-[1px] bg-border-ui",
          "group-hover:w-[3px] group-hover:bg-border-ui--hovered"
        )}
      />
    </PanelPrimitive.PanelResizeHandle>
  </div>
)

PanelResizeHandle.displayName = PanelPrimitive.PanelResizeHandle.displayName

export { Panel, PanelGroup, PanelResizeHandle }
