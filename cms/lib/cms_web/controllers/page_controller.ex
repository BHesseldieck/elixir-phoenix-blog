defmodule CmsWeb.PageController do
  use CmsWeb, :controller

  def index(conn, _params) do
    conn
    # Normal page render
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> put_status(:ok)
    |> render("index.html")

    # Throw a 404
    # |> put_status(:not_found)
    # |> put_view(CmsWeb.ErrorView)
    # |> render("404.html")

    # Redirect
    # |> redirect(to: Routes.redirect_test_path(conn, :redirect_test))
    # |> redirect(external: "https://elixir-lang.org/") # redirecting to external page, can be also used internally but then use _url helper instead of _path
  end

  def redirect_test(conn, _params) do
    text(conn, "Redirect!")
  end

  def test(conn, _params) do
    render(conn, "test.html")
  end
end
