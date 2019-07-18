defmodule CmsWeb.Router do
  use CmsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CmsWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug CmsWeb.Plugs.Auth
  end

  scope "/", CmsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/test", PageController, :test
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    get "/redirect_test", PageController, :redirect_test, as: :redirect_test # as is required otherwise it uses controller for path helper e.g. page_path

    resources "/login", SessionController, only: [:new, :create, :delete], singleton: true

    resources "/users", UserController
    resources "/posts", PostController do
      resources "/comments", CommentController
    end
    resources "/reviews", ReviewController, except: [:delete]

    forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"
  end

  scope "/content", CmsWeb.Content, as: :content do
    pipe_through [:browser, :auth]

    resources "/pages", PageController
  end

  scope "/admin", CmsWeb.Admin, as: :admin do
    pipe_through [:browser, :auth]

    resources "/users",   CmsWeb.Admin.UserController
    resources "/images",  CmsWeb.Admin.ImageController
    resources "/reviews", CmsWeb.Admin.ReviewController
  end


  scope "/api", CmsWeb.Api, as: :api do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/images",  ImageController
      resources "/reviews", ReviewController
      resources "/users",   UserController
      resources "/comments", CommentController
    end
  end

  # App within app, separate app for admin and users
  # scope "/", AnotherAppWeb do
  #   pipe_through :browser

  #   resources "/posts", PostController
  # end
end
