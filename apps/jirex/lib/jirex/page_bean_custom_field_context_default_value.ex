defmodule Jirex.PageBeanCustomFieldContextDefaultValue do
  @moduledoc """
  Provides struct and type for a PageBeanCustomFieldContextDefaultValue
  """

  @type t :: %__MODULE__{
          isLast: boolean | nil,
          maxResults: integer | nil,
          nextPage: String.t() | nil,
          self: String.t() | nil,
          startAt: integer | nil,
          total: integer | nil,
          values:
            [
              Jirex.CustomFieldContextDefaultValueCascadingOption.t()
              | Jirex.CustomFieldContextDefaultValueDate.t()
              | Jirex.CustomFieldContextDefaultValueDateTime.t()
              | Jirex.CustomFieldContextDefaultValueFloat.t()
              | Jirex.CustomFieldContextDefaultValueForgeDateTimeField.t()
              | Jirex.CustomFieldContextDefaultValueForgeGroupField.t()
              | Jirex.CustomFieldContextDefaultValueForgeMultiGroupField.t()
              | Jirex.CustomFieldContextDefaultValueForgeMultiStringField.t()
              | Jirex.CustomFieldContextDefaultValueForgeMultiUserField.t()
              | Jirex.CustomFieldContextDefaultValueForgeNumberField.t()
              | Jirex.CustomFieldContextDefaultValueForgeObjectField.t()
              | Jirex.CustomFieldContextDefaultValueForgeStringField.t()
              | Jirex.CustomFieldContextDefaultValueForgeUserField.t()
              | Jirex.CustomFieldContextDefaultValueLabels.t()
              | Jirex.CustomFieldContextDefaultValueMultiUserPicker.t()
              | Jirex.CustomFieldContextDefaultValueMultipleGroupPicker.t()
              | Jirex.CustomFieldContextDefaultValueMultipleOption.t()
              | Jirex.CustomFieldContextDefaultValueMultipleVersionPicker.t()
              | Jirex.CustomFieldContextDefaultValueProject.t()
              | Jirex.CustomFieldContextDefaultValueReadOnly.t()
              | Jirex.CustomFieldContextDefaultValueSingleGroupPicker.t()
              | Jirex.CustomFieldContextDefaultValueSingleOption.t()
              | Jirex.CustomFieldContextDefaultValueSingleVersionPicker.t()
              | Jirex.CustomFieldContextDefaultValueTextArea.t()
              | Jirex.CustomFieldContextDefaultValueTextField.t()
              | Jirex.CustomFieldContextDefaultValueURL.t()
              | Jirex.CustomFieldContextSingleUserPickerDefaults.t()
            ]
            | nil
        }

  defstruct [:isLast, :maxResults, :nextPage, :self, :startAt, :total, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      isLast: :boolean,
      maxResults: :integer,
      nextPage: {:string, :uri},
      self: {:string, :uri},
      startAt: :integer,
      total: :integer,
      values: [
        union: [
          {Jirex.CustomFieldContextDefaultValueCascadingOption, :t},
          {Jirex.CustomFieldContextDefaultValueDate, :t},
          {Jirex.CustomFieldContextDefaultValueDateTime, :t},
          {Jirex.CustomFieldContextDefaultValueFloat, :t},
          {Jirex.CustomFieldContextDefaultValueForgeDateTimeField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeGroupField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeMultiGroupField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeMultiStringField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeMultiUserField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeNumberField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeObjectField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeStringField, :t},
          {Jirex.CustomFieldContextDefaultValueForgeUserField, :t},
          {Jirex.CustomFieldContextDefaultValueLabels, :t},
          {Jirex.CustomFieldContextDefaultValueMultiUserPicker, :t},
          {Jirex.CustomFieldContextDefaultValueMultipleGroupPicker, :t},
          {Jirex.CustomFieldContextDefaultValueMultipleOption, :t},
          {Jirex.CustomFieldContextDefaultValueMultipleVersionPicker, :t},
          {Jirex.CustomFieldContextDefaultValueProject, :t},
          {Jirex.CustomFieldContextDefaultValueReadOnly, :t},
          {Jirex.CustomFieldContextDefaultValueSingleGroupPicker, :t},
          {Jirex.CustomFieldContextDefaultValueSingleOption, :t},
          {Jirex.CustomFieldContextDefaultValueSingleVersionPicker, :t},
          {Jirex.CustomFieldContextDefaultValueTextArea, :t},
          {Jirex.CustomFieldContextDefaultValueTextField, :t},
          {Jirex.CustomFieldContextDefaultValueURL, :t},
          {Jirex.CustomFieldContextSingleUserPickerDefaults, :t}
        ]
      ]
    ]
  end
end
