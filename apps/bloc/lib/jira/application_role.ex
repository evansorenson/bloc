defmodule Jira.ApplicationRole do
  @moduledoc """
  Provides struct and type for a ApplicationRole
  """

  @type t :: %__MODULE__{
          defaultGroups: [String.t()] | nil,
          defaultGroupsDetails: [Jira.GroupName.t()] | nil,
          defined: boolean | nil,
          groupDetails: [Jira.GroupName.t()] | nil,
          groups: [String.t()] | nil,
          hasUnlimitedSeats: boolean | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          numberOfSeats: integer | nil,
          platform: boolean | nil,
          remainingSeats: integer | nil,
          selectedByDefault: boolean | nil,
          userCount: integer | nil,
          userCountDescription: String.t() | nil
        }

  defstruct [
    :defaultGroups,
    :defaultGroupsDetails,
    :defined,
    :groupDetails,
    :groups,
    :hasUnlimitedSeats,
    :key,
    :name,
    :numberOfSeats,
    :platform,
    :remainingSeats,
    :selectedByDefault,
    :userCount,
    :userCountDescription
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultGroups: [string: :generic],
      defaultGroupsDetails: [{Jira.GroupName, :t}],
      defined: :boolean,
      groupDetails: [{Jira.GroupName, :t}],
      groups: [string: :generic],
      hasUnlimitedSeats: :boolean,
      key: {:string, :generic},
      name: {:string, :generic},
      numberOfSeats: :integer,
      platform: :boolean,
      remainingSeats: :integer,
      selectedByDefault: :boolean,
      userCount: :integer,
      userCountDescription: {:string, :generic}
    ]
  end
end
