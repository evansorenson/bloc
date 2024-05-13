defmodule Jira.CustomFieldContextDefaultValueUpdate do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueUpdate
  """

  @type t :: %__MODULE__{
          defaultValues:
            [
              Jira.CustomFieldContextDefaultValueCascadingOption.t()
              | Jira.CustomFieldContextDefaultValueDate.t()
              | Jira.CustomFieldContextDefaultValueDateTime.t()
              | Jira.CustomFieldContextDefaultValueFloat.t()
              | Jira.CustomFieldContextDefaultValueForgeDateTimeField.t()
              | Jira.CustomFieldContextDefaultValueForgeGroupField.t()
              | Jira.CustomFieldContextDefaultValueForgeMultiGroupField.t()
              | Jira.CustomFieldContextDefaultValueForgeMultiStringField.t()
              | Jira.CustomFieldContextDefaultValueForgeMultiUserField.t()
              | Jira.CustomFieldContextDefaultValueForgeNumberField.t()
              | Jira.CustomFieldContextDefaultValueForgeObjectField.t()
              | Jira.CustomFieldContextDefaultValueForgeStringField.t()
              | Jira.CustomFieldContextDefaultValueForgeUserField.t()
              | Jira.CustomFieldContextDefaultValueLabels.t()
              | Jira.CustomFieldContextDefaultValueMultiUserPicker.t()
              | Jira.CustomFieldContextDefaultValueMultipleGroupPicker.t()
              | Jira.CustomFieldContextDefaultValueMultipleOption.t()
              | Jira.CustomFieldContextDefaultValueMultipleVersionPicker.t()
              | Jira.CustomFieldContextDefaultValueProject.t()
              | Jira.CustomFieldContextDefaultValueReadOnly.t()
              | Jira.CustomFieldContextDefaultValueSingleGroupPicker.t()
              | Jira.CustomFieldContextDefaultValueSingleOption.t()
              | Jira.CustomFieldContextDefaultValueSingleVersionPicker.t()
              | Jira.CustomFieldContextDefaultValueTextArea.t()
              | Jira.CustomFieldContextDefaultValueTextField.t()
              | Jira.CustomFieldContextDefaultValueURL.t()
              | Jira.CustomFieldContextSingleUserPickerDefaults.t()
            ]
            | nil
        }

  defstruct [:defaultValues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultValues: [
        union: [
          {Jira.CustomFieldContextDefaultValueCascadingOption, :t},
          {Jira.CustomFieldContextDefaultValueDate, :t},
          {Jira.CustomFieldContextDefaultValueDateTime, :t},
          {Jira.CustomFieldContextDefaultValueFloat, :t},
          {Jira.CustomFieldContextDefaultValueForgeDateTimeField, :t},
          {Jira.CustomFieldContextDefaultValueForgeGroupField, :t},
          {Jira.CustomFieldContextDefaultValueForgeMultiGroupField, :t},
          {Jira.CustomFieldContextDefaultValueForgeMultiStringField, :t},
          {Jira.CustomFieldContextDefaultValueForgeMultiUserField, :t},
          {Jira.CustomFieldContextDefaultValueForgeNumberField, :t},
          {Jira.CustomFieldContextDefaultValueForgeObjectField, :t},
          {Jira.CustomFieldContextDefaultValueForgeStringField, :t},
          {Jira.CustomFieldContextDefaultValueForgeUserField, :t},
          {Jira.CustomFieldContextDefaultValueLabels, :t},
          {Jira.CustomFieldContextDefaultValueMultiUserPicker, :t},
          {Jira.CustomFieldContextDefaultValueMultipleGroupPicker, :t},
          {Jira.CustomFieldContextDefaultValueMultipleOption, :t},
          {Jira.CustomFieldContextDefaultValueMultipleVersionPicker, :t},
          {Jira.CustomFieldContextDefaultValueProject, :t},
          {Jira.CustomFieldContextDefaultValueReadOnly, :t},
          {Jira.CustomFieldContextDefaultValueSingleGroupPicker, :t},
          {Jira.CustomFieldContextDefaultValueSingleOption, :t},
          {Jira.CustomFieldContextDefaultValueSingleVersionPicker, :t},
          {Jira.CustomFieldContextDefaultValueTextArea, :t},
          {Jira.CustomFieldContextDefaultValueTextField, :t},
          {Jira.CustomFieldContextDefaultValueURL, :t},
          {Jira.CustomFieldContextSingleUserPickerDefaults, :t}
        ]
      ]
    ]
  end
end
