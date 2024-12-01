defmodule Jirex.VersionUsageInCustomField do
  @moduledoc """
  Provides struct and type for a VersionUsageInCustomField
  """

  @type t :: %__MODULE__{
          customFieldId: integer | nil,
          fieldName: String.t() | nil,
          issueCountWithVersionInCustomField: integer | nil
        }

  defstruct [:customFieldId, :fieldName, :issueCountWithVersionInCustomField]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      customFieldId: :integer,
      fieldName: {:string, :generic},
      issueCountWithVersionInCustomField: :integer
    ]
  end
end
