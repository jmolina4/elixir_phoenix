defmodule Dogfamily.Helpers.LinkHelper do
  def active_link(conn, controllers) do
    active_link(conn, controllers, "active")
  end

  def active_link(conn, controllers, class) when is_list(controllers) do
    if Enum.member?(controllers, Phoenix.Controller.controller_module(conn)) do
      class
    else
      ""
    end
  end

  def active_link(conn, controller, class) do
    active_link(conn, [controller], class)
  end
end
