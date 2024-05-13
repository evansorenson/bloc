defmodule Jira.Resource do
  @moduledoc """
  Provides struct and type for a Resource
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          file: String.t() | nil,
          filename: String.t() | nil,
          inputStream: map | nil,
          open: boolean | nil,
          readable: boolean | nil,
          uri: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:description, :file, :filename, :inputStream, :open, :readable, :uri, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      file: {:string, :generic},
      filename: {:string, :generic},
      inputStream: :map,
      open: :boolean,
      readable: :boolean,
      uri: {:string, :uri},
      url: {:string, :generic}
    ]
  end
end
