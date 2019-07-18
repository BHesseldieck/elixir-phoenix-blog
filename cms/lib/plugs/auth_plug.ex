defmodule CmsWeb.Plugs.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Cms.Accounts.get_user!(user_id))
    end
  end
end