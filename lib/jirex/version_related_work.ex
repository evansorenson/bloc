defmodule Jirex.VersionRelatedWork do
  @moduledoc """
  Provides struct and type for a VersionRelatedWork
  """

  @type t :: %__MODULE__{
          category: String.t(),
          issueId: integer | nil,
          relatedWorkId: String.t() | nil,
          title: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:category, :issueId, :relatedWorkId, :title, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      category: {:string, :generic},
      issueId: :integer,
      relatedWorkId: {:string, :generic},
      title: {:string, :generic},
      url: {:string, :uri}
    ]
  end
end
