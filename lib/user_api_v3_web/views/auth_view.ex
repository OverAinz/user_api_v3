defmodule UserApiV3Web.AuthView do
  use UserApiV3, :view

  def render("show.json", %{token_result: token_result}) do
    %{
      accessToken: token_result.access_token,
      expiresIn: token_result.expires_in
    }
  end

end
