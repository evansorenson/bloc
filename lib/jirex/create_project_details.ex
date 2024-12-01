defmodule Jirex.CreateProjectDetails do
  @moduledoc """
  Provides struct and type for a CreateProjectDetails
  """

  @type t :: %__MODULE__{
          assigneeType: String.t() | nil,
          avatarId: integer | nil,
          categoryId: integer | nil,
          description: String.t() | nil,
          fieldConfigurationScheme: integer | nil,
          issueSecurityScheme: integer | nil,
          issueTypeScheme: integer | nil,
          issueTypeScreenScheme: integer | nil,
          key: String.t(),
          lead: String.t() | nil,
          leadAccountId: String.t() | nil,
          name: String.t(),
          notificationScheme: integer | nil,
          permissionScheme: integer | nil,
          projectTemplateKey: String.t() | nil,
          projectTypeKey: String.t() | nil,
          url: String.t() | nil,
          workflowScheme: integer | nil
        }

  defstruct [
    :assigneeType,
    :avatarId,
    :categoryId,
    :description,
    :fieldConfigurationScheme,
    :issueSecurityScheme,
    :issueTypeScheme,
    :issueTypeScreenScheme,
    :key,
    :lead,
    :leadAccountId,
    :name,
    :notificationScheme,
    :permissionScheme,
    :projectTemplateKey,
    :projectTypeKey,
    :url,
    :workflowScheme
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      assigneeType: {:enum, ["PROJECT_LEAD", "UNASSIGNED"]},
      avatarId: :integer,
      categoryId: :integer,
      description: {:string, :generic},
      fieldConfigurationScheme: :integer,
      issueSecurityScheme: :integer,
      issueTypeScheme: :integer,
      issueTypeScreenScheme: :integer,
      key: {:string, :generic},
      lead: {:string, :generic},
      leadAccountId: {:string, :generic},
      name: {:string, :generic},
      notificationScheme: :integer,
      permissionScheme: :integer,
      projectTemplateKey:
        {:enum,
         [
           "com.pyxis.greenhopper.jira:gh-simplified-agility-kanban",
           "com.pyxis.greenhopper.jira:gh-simplified-agility-scrum",
           "com.pyxis.greenhopper.jira:gh-simplified-basic",
           "com.pyxis.greenhopper.jira:gh-simplified-kanban-classic",
           "com.pyxis.greenhopper.jira:gh-simplified-scrum-classic",
           "com.pyxis.greenhopper.jira:gh-cross-team-template",
           "com.pyxis.greenhopper.jira:gh-cross-team-planning-template",
           "com.atlassian.servicedesk:simplified-it-service-management",
           "com.atlassian.servicedesk:simplified-general-service-desk",
           "com.atlassian.servicedesk:simplified-general-service-desk-it",
           "com.atlassian.servicedesk:simplified-general-service-desk-business",
           "com.atlassian.servicedesk:simplified-internal-service-desk",
           "com.atlassian.servicedesk:simplified-external-service-desk",
           "com.atlassian.servicedesk:simplified-hr-service-desk",
           "com.atlassian.servicedesk:simplified-facilities-service-desk",
           "com.atlassian.servicedesk:simplified-legal-service-desk",
           "com.atlassian.servicedesk:simplified-marketing-service-desk",
           "com.atlassian.servicedesk:simplified-finance-service-desk",
           "com.atlassian.servicedesk:simplified-analytics-service-desk",
           "com.atlassian.servicedesk:simplified-design-service-desk",
           "com.atlassian.servicedesk:simplified-sales-service-desk",
           "com.atlassian.servicedesk:simplified-halp-service-desk",
           "com.atlassian.servicedesk:simplified-blank-project-it",
           "com.atlassian.servicedesk:simplified-blank-project-business",
           "com.atlassian.servicedesk:next-gen-it-service-desk",
           "com.atlassian.servicedesk:next-gen-hr-service-desk",
           "com.atlassian.servicedesk:next-gen-legal-service-desk",
           "com.atlassian.servicedesk:next-gen-marketing-service-desk",
           "com.atlassian.servicedesk:next-gen-facilities-service-desk",
           "com.atlassian.servicedesk:next-gen-general-service-desk",
           "com.atlassian.servicedesk:next-gen-general-it-service-desk",
           "com.atlassian.servicedesk:next-gen-general-business-service-desk",
           "com.atlassian.servicedesk:next-gen-analytics-service-desk",
           "com.atlassian.servicedesk:next-gen-finance-service-desk",
           "com.atlassian.servicedesk:next-gen-design-service-desk",
           "com.atlassian.servicedesk:next-gen-sales-service-desk",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-content-management",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-document-approval",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-lead-tracking",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-process-control",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-procurement",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-project-management",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-recruitment",
           "com.atlassian.jira-core-project-templates:jira-core-simplified-task-"
         ]},
      projectTypeKey: {:enum, ["software", "service_desk", "business"]},
      url: {:string, :generic},
      workflowScheme: :integer
    ]
  end
end
