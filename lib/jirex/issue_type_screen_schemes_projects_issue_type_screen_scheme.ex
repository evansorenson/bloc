defmodule Jirex.IssueTypeScreenSchemesProjectsIssueTypeScreenScheme do
  @moduledoc """
  Provides struct and type for a IssueTypeScreenSchemesProjectsIssueTypeScreenScheme
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:description, :id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: {:string, :generic}, id: {:string, :generic}, name: {:string, :generic}]
  end
end
