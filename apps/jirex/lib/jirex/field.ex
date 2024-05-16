defmodule Jirex.Field do
  @moduledoc """
  Provides struct and type for a Field
  """

  @type t :: %__MODULE__{
          contextsCount: integer | nil,
          description: String.t() | nil,
          id: String.t(),
          isLocked: boolean | nil,
          isUnscreenable: boolean | nil,
          key: String.t() | nil,
          lastUsed: Jirex.FieldLastUsed.t() | nil,
          name: String.t(),
          projectsCount: integer | nil,
          schema: Jirex.JsonTypeBean.t(),
          screensCount: integer | nil,
          searcherKey: String.t() | nil,
          stableId: String.t() | nil
        }

  defstruct [
    :contextsCount,
    :description,
    :id,
    :isLocked,
    :isUnscreenable,
    :key,
    :lastUsed,
    :name,
    :projectsCount,
    :schema,
    :screensCount,
    :searcherKey,
    :stableId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contextsCount: :integer,
      description: {:string, :generic},
      id: {:string, :generic},
      isLocked: :boolean,
      isUnscreenable: :boolean,
      key: {:string, :generic},
      lastUsed: {Jirex.FieldLastUsed, :t},
      name: {:string, :generic},
      projectsCount: :integer,
      schema: {Jirex.JsonTypeBean, :t},
      screensCount: :integer,
      searcherKey: {:string, :generic},
      stableId: {:string, :generic}
    ]
  end
end
