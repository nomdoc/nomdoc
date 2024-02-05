defmodule ConsoleWeb.LoginLive do
  @moduledoc false

  use ConsoleWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div>
      <h1>Console login and counter</h1>
      <div>
        <h1 phx-click="boom">The count is: <%= @val %></h1>
        <button phx-click="dec">-</button>
        <button phx-click="inc">+</button>
      </div>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :val, 0)}
  end

  @impl Phoenix.LiveView
  def handle_event("inc", _session, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  @impl Phoenix.LiveView
  def handle_event("dec", _session, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end
end
