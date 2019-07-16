defmodule CmsWeb.HelloController do
  use CmsWeb, :controller

  plug :assign_default_message, "Hi! " when action in [:index, :show]

  def index(conn, _params) do
    conn
    |> assign(:message, "Welcome Back ") # assign or as third argument to render are the same
    |> assign(:name, "Dweezil")
    |> put_layout("admin.html")
    |> render("index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, "show.html", messenger: messenger)
  end

  defp assign_default_message(conn, msg) do
    assign(conn, :message, msg)
  end
end
