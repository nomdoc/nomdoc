defmodule WorkspaceWeb.ControllerHelpers do
  @moduledoc false

  import Plug.Conn
  import Phoenix.Controller

  @doc """
  Renders workspace client app.
  """
  def render_react_app(%Plug.Conn{} = conn, opts \\ []) do
    conn
    |> assign(:load_workspace_js, true)
    |> put_status(200)
    |> put_root_layout(html: {WorkspaceWeb.Layouts, :root})
    |> put_view(html: WorkspaceWeb.ReactAppHTML)
    |> render(:index, opts)
  end
end
