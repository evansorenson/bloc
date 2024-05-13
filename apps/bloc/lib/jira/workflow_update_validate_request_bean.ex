defmodule Jira.WorkflowUpdateValidateRequestBean do
  @moduledoc """
  Provides struct and type for a WorkflowUpdateValidateRequestBean
  """

  @type t :: %__MODULE__{
          payload: Jira.WorkflowUpdateRequest.t(),
          validationOptions: Jira.ValidationOptionsForUpdate.t() | nil
        }

  defstruct [:payload, :validationOptions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      payload: {Jira.WorkflowUpdateRequest, :t},
      validationOptions: {Jira.ValidationOptionsForUpdate, :t}
    ]
  end
end
