defmodule Auth0 do
  alias UserApìV3.Accounts.{Credentials, TokenResult}

  import Base #Data encoding and decoding 16, 32 and 64... https://hexdocs.pm/elixir/1.1.0/Base.html

  require Logger #is useful for tracking when an event of interest happens in the app... https://hexdocs.pm/logger/1.9.0/Logger.html#content

  @auth Application.fetch_env!(:auth0, :credentials)

  @spec sing_in(Credentials.t()) :: {:ok, TokenResult.t()} | {:error, String.t()}
  def sing_in(%Credentials{username: username, password: encoded_password})
    when is_binary(username) and is_binary(encoded_password) do
      password = encoded_password |> decode64!(ignore: :whitespace)

      body = build_payload(username, password)
      headers = build_headers()

      @auth0.url
      |> build_url()
      |> HTTPoison.post(body, headers)
      |> response
      |> parse
  end

  defp build_headers, do: ["Content-type": "application/json"]

  defp build_payload(username, password) do
    %{
      grant_type: "password",
      username: username,
      password: password,
      audience: @auth0.audience,
      scope: @auth0.scope,
      client_id: @auth0.client_id,
      client_secret: @auth0.client_secret
    }

    |> Jason.encode!()
  end

  defp response({:ok, %{status_code: 200, body: body}}), do: {:ok, body}
  defp response({:ok, %{status_code: 401}}), do: {:error, :unauthorized}
  defp response({:ok, %{status_code: 403}}), do: {:error, :forbiden}

  defp response({:error, %{reason: reason}}), do: {:error, reason}

  def parse({:ok, body}) do
    result =
      body
      |> Jason.decode!(keys: :atoms)
      |> Map.take([:access_token, :expires_in])

    {:ok, struct(TokenResult, result)}
  end

  defp parse({:error, :unauthorized}), do: {:error, :unauthorized}
  defp parse({:error, :forbiden}), do: {:error, :forbiden}

  defp parse({:error, error}) do
    _ = Logger.warn(fn -> "Failed to authenticate due to #{inspect(error)}" end)
    {:error, :unauthorized}
  end
end
