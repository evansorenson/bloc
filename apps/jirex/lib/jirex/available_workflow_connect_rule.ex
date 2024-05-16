defmodule Jirex.AvailableWorkflowConnectRule do
  @moduledoc """
  Provides struct and type for a AvailableWorkflowConnectRule
  """

  @type t :: %__MODULE__{
          addonKey: String.t() | nil,
          createUrl: String.t() | nil,
          description: String.t() | nil,
          editUrl: String.t() | nil,
          moduleKey: String.t() | nil,
          name: String.t() | nil,
          ruleKey: String.t() | nil,
          ruleType: String.t() | nil,
          viewUrl: String.t() | nil
        }

  defstruct [
    :addonKey,
    :createUrl,
    :description,
    :editUrl,
    :moduleKey,
    :name,
    :ruleKey,
    :ruleType,
    :viewUrl
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      addonKey: {:string, :generic},
      createUrl: {:string, :generic},
      description: {:string, :generic},
      editUrl: {:string, :generic},
      moduleKey: {:string, :generic},
      name: {:string, :generic},
      ruleKey: {:string, :generic},
      ruleType: {:enum, ["Condition", "Validator", "Function", "Screen"]},
      viewUrl: {:string, :generic}
    ]
  end
end
