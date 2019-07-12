defmodule CmsWeb.Router do
  use CmsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CmsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController do
      resources "/posts", PostController
    end
    resources "/comments", CommentController, except: [:delete]

    forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"
  end


  # Other scopes may use custom stacks.
  # scope "/api", CmsWeb do
  #   pipe_through :api
  # end
end
