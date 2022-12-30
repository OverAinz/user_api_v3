defmodule UserApiV3Web.Auth0Controller do
  use UserApiV3, :controller

  alias UserApiV3.Accounts
  alias UserApiV3.Accounts.{Credentials, TokenResult}

  require Logger

  action_fallback UserApiV3Web.FallbackController

  def create(conn, credentials) do
    _ = Logger.debug(fn -> "Login attempt with user #{credentials.username}" end)

    with  {:ok, credentials} <- Credentials.validate(credentials),
          {:ok, %TokenResult{} = result} <- Auth.sing_in(credentials) do

        conn
        |> put_status(:ok)
        |> render(:show, token_result: result)
    end
  end

end
