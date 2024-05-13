defmodule Jira.UpdatePriorityDetails do
  @moduledoc """
  Provides struct and type for a UpdatePriorityDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          iconUrl: String.t() | nil,
          name: String.t() | nil,
          statusColor: String.t() | nil
        }

  defstruct [:description, :iconUrl, :name, :statusColor]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      iconUrl:
        {:enum,
         [
           "/images/icons/priorities/blocker.png",
           "/images/icons/priorities/critical.png",
           "/images/icons/priorities/high.png",
           "/images/icons/priorities/highest.png",
           "/images/icons/priorities/low.png",
           "/images/icons/priorities/lowest.png",
           "/images/icons/priorities/major.png",
           "/images/icons/priorities/medium.png",
           "/images/icons/priorities/minor.png",
           "/images/icons/priorities/trivial.png"
         ]},
      name: {:string, :generic},
      statusColor: {:string, :generic}
    ]
  end
end
