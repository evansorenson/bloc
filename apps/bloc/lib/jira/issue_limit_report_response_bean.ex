defmodule Jira.IssueLimitReportResponseBean do
  @moduledoc """
  Provides struct and type for a IssueLimitReportResponseBean
  """

  @type t :: %__MODULE__{
          issuesApproachingLimit:
            Jira.IssueLimitReportResponseBeanIssuesApproachingLimit.t() | nil,
          issuesBreachingLimit: Jira.IssueLimitReportResponseBeanIssuesBreachingLimit.t() | nil,
          limits: Jira.IssueLimitReportResponseBeanLimits.t() | nil
        }

  defstruct [:issuesApproachingLimit, :issuesBreachingLimit, :limits]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issuesApproachingLimit: {Jira.IssueLimitReportResponseBeanIssuesApproachingLimit, :t},
      issuesBreachingLimit: {Jira.IssueLimitReportResponseBeanIssuesBreachingLimit, :t},
      limits: {Jira.IssueLimitReportResponseBeanLimits, :t}
    ]
  end
end
