defmodule Jirex.IssueTypeSchemeUpdateDetails do
  @moduledoc """
  Provides struct and type for a IssueTypeSchemeUpdateDetails
  """

  @type t :: %__MODULE__{
          defaultIssueTypeId: String.t() | nil,
          description: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:defaultIssueTypeId, :description, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultIssueTypeId: {:string, :generic},
      description: {:string, :generic},
      name: {:string, :generic}
    ]
  end
end
