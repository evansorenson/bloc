defmodule Jira.WorkflowCreateValidateRequest do
  @moduledoc """
  Provides struct and type for a WorkflowCreateValidateRequest
  """

  @type t :: %__MODULE__{
          payload: Jira.WorkflowCreateRequest.t(),
          validationOptions: Jira.ValidationOptionsForCreate.t() | nil
        }

  defstruct [:payload, :validationOptions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      payload: {Jira.WorkflowCreateRequest, :t},
      validationOptions: {Jira.ValidationOptionsForCreate, :t}
    ]
  end
end
