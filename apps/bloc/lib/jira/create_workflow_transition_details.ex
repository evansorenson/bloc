defmodule Jira.CreateWorkflowTransitionDetails do
  @moduledoc """
  Provides struct and type for a CreateWorkflowTransitionDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          from: [String.t()] | nil,
          name: String.t(),
          properties: Jira.CreateWorkflowTransitionDetailsProperties.t() | nil,
          rules: Jira.CreateWorkflowTransitionDetailsRules.t() | nil,
          screen: Jira.CreateWorkflowTransitionDetailsScreen.t() | nil,
          to: String.t(),
          type: String.t()
        }

  defstruct [:description, :from, :name, :properties, :rules, :screen, :to, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      from: [string: :generic],
      name: {:string, :generic},
      properties: {Jira.CreateWorkflowTransitionDetailsProperties, :t},
      rules: {Jira.CreateWorkflowTransitionDetailsRules, :t},
      screen: {Jira.CreateWorkflowTransitionDetailsScreen, :t},
      to: {:string, :generic},
      type: {:enum, ["global", "initial", "directed"]}
    ]
  end
end
