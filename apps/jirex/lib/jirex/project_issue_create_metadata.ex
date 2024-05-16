defmodule Jirex.ProjectIssueCreateMetadata do
  @moduledoc """
  Provides struct and type for a ProjectIssueCreateMetadata
  """

  @type t :: %__MODULE__{
          avatarUrls: Jirex.ProjectIssueCreateMetadataAvatarUrls.t() | nil,
          expand: String.t() | nil,
          id: String.t() | nil,
          issuetypes: [Jirex.IssueTypeIssueCreateMetadata.t()] | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:avatarUrls, :expand, :id, :issuetypes, :key, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      avatarUrls: {Jirex.ProjectIssueCreateMetadataAvatarUrls, :t},
      expand: {:string, :generic},
      id: {:string, :generic},
      issuetypes: [{Jirex.IssueTypeIssueCreateMetadata, :t}],
      key: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end
