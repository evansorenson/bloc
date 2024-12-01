defmodule Jirex.IssueLimitReportResponseBean do
  @moduledoc """
  Provides struct and type for a IssueLimitReportResponseBean
  """

  @type t :: %__MODULE__{
          issuesApproachingLimit:
            Jirex.IssueLimitReportResponseBeanIssuesApproachingLimit.t() | nil,
          issuesBreachingLimit: Jirex.IssueLimitReportResponseBeanIssuesBreachingLimit.t() | nil,
          limits: Jirex.IssueLimitReportResponseBeanLimits.t() | nil
        }

  defstruct [:issuesApproachingLimit, :issuesBreachingLimit, :limits]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issuesApproachingLimit: {Jirex.IssueLimitReportResponseBeanIssuesApproachingLimit, :t},
      issuesBreachingLimit: {Jirex.IssueLimitReportResponseBeanIssuesBreachingLimit, :t},
      limits: {Jirex.IssueLimitReportResponseBeanLimits, :t}
    ]
  end
end
