defmodule UserApiV3Web.Router do
  use UserApiV3Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UserApiV3Web do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end
end
