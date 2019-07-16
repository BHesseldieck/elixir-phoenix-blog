defmodule CmsWeb.PageView do
  use CmsWeb, :view

  def message do
    "Hello from the PageView!"
  end

  def handler_info(conn) do
    "Request Handled By: #{controller_module(conn)}.#{action_name(conn)}"
  end

  def connection_keys(conn) do
    conn
    |> Map.from_struct()
    |> Map.keys()
  end
end
