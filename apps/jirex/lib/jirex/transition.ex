defmodule Jirex.Transition do
  @moduledoc """
  Provides struct and type for a Transition
  """

  @type t :: %__MODULE__{
          description: String.t(),
          from: [String.t()],
          id: String.t(),
          name: String.t(),
          properties: Jirex.TransitionProperties.t() | nil,
          rules: Jirex.WorkflowRules.t() | nil,
          screen: Jirex.TransitionScreenDetails.t() | nil,
          to: String.t(),
          type: String.t()
        }

  defstruct [:description, :from, :id, :name, :properties, :rules, :screen, :to, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      from: [string: :generic],
      id: {:string, :generic},
      name: {:string, :generic},
      properties: {Jirex.TransitionProperties, :t},
      rules: {Jirex.WorkflowRules, :t},
      screen: {Jirex.TransitionScreenDetails, :t},
      to: {:string, :generic},
      type: {:enum, ["global", "initial", "directed"]}
    ]
  end
end
