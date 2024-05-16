defmodule Jirex.NewUserDetails do
  @moduledoc """
  Provides struct and type for a NewUserDetails
  """

  @type t :: %__MODULE__{
          applicationKeys: [String.t()] | nil,
          displayName: String.t() | nil,
          emailAddress: String.t(),
          key: String.t() | nil,
          name: String.t() | nil,
          password: String.t() | nil,
          products: [String.t()],
          self: String.t() | nil
        }

  defstruct [
    :applicationKeys,
    :displayName,
    :emailAddress,
    :key,
    :name,
    :password,
    :products,
    :self
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      applicationKeys: [string: :generic],
      displayName: {:string, :generic},
      emailAddress: {:string, :generic},
      key: {:string, :generic},
      name: {:string, :generic},
      password: {:string, :generic},
      products: [string: :generic],
      self: {:string, :generic}
    ]
  end
end
