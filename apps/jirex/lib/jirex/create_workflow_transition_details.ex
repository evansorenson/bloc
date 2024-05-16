defmodule Jirex.CreateWorkflowTransitionDetails do
  @moduledoc """
  Provides struct and type for a CreateWorkflowTransitionDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          from: [String.t()] | nil,
          name: String.t(),
          properties: Jirex.CreateWorkflowTransitionDetailsProperties.t() | nil,
          rules: Jirex.CreateWorkflowTransitionDetailsRules.t() | nil,
          screen: Jirex.CreateWorkflowTransitionDetailsScreen.t() | nil,
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
      properties: {Jirex.CreateWorkflowTransitionDetailsProperties, :t},
      rules: {Jirex.CreateWorkflowTransitionDetailsRules, :t},
      screen: {Jirex.CreateWorkflowTransitionDetailsScreen, :t},
      to: {:string, :generic},
      type: {:enum, ["global", "initial", "directed"]}
    ]
  end
end
