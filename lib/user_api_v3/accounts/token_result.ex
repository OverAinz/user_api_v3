defmodule UserApiV3.Accounts.TokenResult do

  @enforce_keys [:access_token, :expires_in]
  defstruct access_token: "", expires_in: 0

  @type t :: %__MODULE__{
        access_token: String.t(),
        expires_in:   String.t()
      }
end
