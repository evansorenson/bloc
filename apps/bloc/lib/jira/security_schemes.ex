defmodule Jira.SecuritySchemes do
  @moduledoc """
  Provides struct and type for a SecuritySchemes
  """

  @type t :: %__MODULE__{issueSecuritySchemes: [Jira.SecurityScheme.t()] | nil}

  defstruct [:issueSecuritySchemes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueSecuritySchemes: [{Jira.SecurityScheme, :t}]]
  end
end
