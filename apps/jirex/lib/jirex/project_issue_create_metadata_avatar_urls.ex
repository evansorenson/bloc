defmodule Jirex.ProjectIssueCreateMetadataAvatarUrls do
  @moduledoc """
  Provides struct and type for a ProjectIssueCreateMetadataAvatarUrls
  """

  @type t :: %__MODULE__{
          "16x16": String.t() | nil,
          "24x24": String.t() | nil,
          "32x32": String.t() | nil,
          "48x48": String.t() | nil
        }

  defstruct [:"16x16", :"24x24", :"32x32", :"48x48"]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      "16x16": {:string, :uri},
      "24x24": {:string, :uri},
      "32x32": {:string, :uri},
      "48x48": {:string, :uri}
    ]
  end
end
