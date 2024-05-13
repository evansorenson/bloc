defmodule Jira.UpdateCustomFieldDetails do
  @moduledoc """
  Provides struct and type for a UpdateCustomFieldDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t() | nil,
          searcherKey: String.t() | nil
        }

  defstruct [:description, :name, :searcherKey]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      name: {:string, :generic},
      searcherKey:
        {:enum,
         [
           "com.atlassian.jira.plugin.system.customfieldtypes:cascadingselectsearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:daterange",
           "com.atlassian.jira.plugin.system.customfieldtypes:datetimerange",
           "com.atlassian.jira.plugin.system.customfieldtypes:exactnumber",
           "com.atlassian.jira.plugin.system.customfieldtypes:exacttextsearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:grouppickersearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:labelsearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:multiselectsearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:numberrange",
           "com.atlassian.jira.plugin.system.customfieldtypes:projectsearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:textsearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:userpickergroupsearcher",
           "com.atlassian.jira.plugin.system.customfieldtypes:versionsearcher"
         ]}
    ]
  end
end
