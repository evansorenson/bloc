defmodule Jirex.IssueEntityPropertiesForMultiUpdate do
  @moduledoc """
  Provides struct and type for a IssueEntityPropertiesForMultiUpdate
  """

  @type t :: %__MODULE__{
          issueID: integer | nil,
          properties: Jirex.IssueEntityPropertiesForMultiUpdateProperties.t() | nil
        }

  defstruct [:issueID, :properties]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueID: :integer, properties: {Jirex.IssueEntityPropertiesForMultiUpdateProperties, :t}]
  end
end
