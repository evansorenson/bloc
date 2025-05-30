defmodule Jirex.IssueLimitReportRequest do
  @moduledoc """
  Provides struct and type for a IssueLimitReportRequest
  """

  @type t :: %__MODULE__{
          issuesApproachingLimitParams:
            Jirex.IssueLimitReportRequestIssuesApproachingLimitParams.t() | nil
        }

  defstruct [:issuesApproachingLimitParams]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issuesApproachingLimitParams:
        {Jirex.IssueLimitReportRequestIssuesApproachingLimitParams, :t}
    ]
  end
end
