defmodule Jira.Projects do
  @moduledoc """
  Provides API endpoints related to projects
  """

  @default_client Jira.Client

  @doc """
  Archive project

  Archives a project. You can't delete a project if it's archived. To delete an archived project, restore the project and then delete it. To restore a project, use the Jira UI.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec archive_project(String.t(), keyword) :: {:ok, map} | :error
  def archive_project(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.Projects, :archive_project},
      url: "/rest/api/2/project/#{projectIdOrKey}/archive",
      method: :post,
      response: [{204, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Create project

  Creates a project based on a project type template, as shown in the following table:

  | Project Type Key | Project Template Key |  
  |--|--|  
  | `business` | `com.atlassian.jira-core-project-templates:jira-core-simplified-content-management`, `com.atlassian.jira-core-project-templates:jira-core-simplified-document-approval`, `com.atlassian.jira-core-project-templates:jira-core-simplified-lead-tracking`, `com.atlassian.jira-core-project-templates:jira-core-simplified-process-control`, `com.atlassian.jira-core-project-templates:jira-core-simplified-procurement`, `com.atlassian.jira-core-project-templates:jira-core-simplified-project-management`, `com.atlassian.jira-core-project-templates:jira-core-simplified-recruitment`, `com.atlassian.jira-core-project-templates:jira-core-simplified-task-tracking` |  
  | `service_desk` | `com.atlassian.servicedesk:simplified-it-service-management`, `com.atlassian.servicedesk:simplified-general-service-desk-it`, `com.atlassian.servicedesk:simplified-general-service-desk-business`, `com.atlassian.servicedesk:simplified-external-service-desk`, `com.atlassian.servicedesk:simplified-hr-service-desk`, `com.atlassian.servicedesk:simplified-facilities-service-desk`, `com.atlassian.servicedesk:simplified-legal-service-desk`, `com.atlassian.servicedesk:simplified-analytics-service-desk`, `com.atlassian.servicedesk:simplified-marketing-service-desk`, `com.atlassian.servicedesk:simplified-design-service-desk`, `com.atlassian.servicedesk:simplified-sales-service-desk`, `com.atlassian.servicedesk:simplified-blank-project-business`, `com.atlassian.servicedesk:simplified-blank-project-it`, `com.atlassian.servicedesk:simplified-finance-service-desk`, `com.atlassian.servicedesk:next-gen-it-service-desk`, `com.atlassian.servicedesk:next-gen-hr-service-desk`, `com.atlassian.servicedesk:next-gen-legal-service-desk`, `com.atlassian.servicedesk:next-gen-marketing-service-desk`, `com.atlassian.servicedesk:next-gen-facilities-service-desk`, `com.atlassian.servicedesk:next-gen-general-it-service-desk`, `com.atlassian.servicedesk:next-gen-general-business-service-desk`, `com.atlassian.servicedesk:next-gen-analytics-service-desk`, `com.atlassian.servicedesk:next-gen-finance-service-desk`, `com.atlassian.servicedesk:next-gen-design-service-desk`, `com.atlassian.servicedesk:next-gen-sales-service-desk` |  
  | `software` | `com.pyxis.greenhopper.jira:gh-simplified-agility-kanban`, `com.pyxis.greenhopper.jira:gh-simplified-agility-scrum`, `com.pyxis.greenhopper.jira:gh-simplified-basic`, `com.pyxis.greenhopper.jira:gh-simplified-kanban-classic`, `com.pyxis.greenhopper.jira:gh-simplified-scrum-classic` |  
  The project types are available according to the installed Jira features as follows:

   *  Jira Core, the default, enables `business` projects.
   *  Jira Service Management enables `service_desk` projects.
   *  Jira Software enables `software` projects.

  To determine which features are installed, go to **Jira settings** > **Apps** > **Manage apps** and review the System Apps list. To add Jira Software or Jira Service Management into a JIRA instance, use **Jira settings** > **Apps** > **Finding new apps**. For more information, see [ Managing add-ons](https://confluence.atlassian.com/x/S31NLg).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_project(Jira.CreateProjectDetails.t(), keyword) ::
          {:ok, Jira.ProjectIdentifiers.t()} | :error
  def create_project(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.Projects, :create_project},
      url: "/rest/api/2/project",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.CreateProjectDetails, :t}}],
      response: [{201, {Jira.ProjectIdentifiers, :t}}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Delete project

  Deletes a project.

  You can't delete a project if it's archived. To delete an archived project, restore the project and then delete it. To restore a project, use the Jira UI.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `enableUndo`: Whether this project is placed in the Jira recycle bin where it will be available for restoration.

  """
  @spec delete_project(String.t(), keyword) :: :ok | :error
  def delete_project(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:enableUndo])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.Projects, :delete_project},
      url: "/rest/api/2/project/#{projectIdOrKey}",
      method: :delete,
      query: query,
      response: [{204, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete project asynchronously

  Deletes a project asynchronously.

  This operation is:

   *  transactional, that is, if part of the delete fails the project is not deleted.
   *  [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_project_asynchronously(String.t(), keyword) :: :ok | :error
  def delete_project_asynchronously(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.Projects, :delete_project_asynchronously},
      url: "/rest/api/2/project/#{projectIdOrKey}/delete",
      method: :post,
      response: [
        {303, {Jira.TaskProgressBeanObject, :t}},
        {400, :null},
        {401, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get all projects

  Returns all projects visible to the user. Deprecated, use [ Get projects paginated](#api-rest-api-2-project-search-get) that supports search and pagination.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Projects are returned only where the user has *Browse Projects* or *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expanded options include:
      
       *  `description` Returns the project description.
       *  `issueTypes` Returns all issue types associated with the project.
       *  `lead` Returns information about the project lead.
       *  `projectKeys` Returns all project keys associated with the project.
    * `recent`: Returns the user's most recently accessed projects. You may specify the number of results to return up to a maximum of 20. If access is anonymous, then the recently accessed projects are based on the current HTTP session.
    * `properties`: A list of project properties to return for the project. This parameter accepts a comma-separated list.

  """
  @spec get_all_projects(keyword) :: {:ok, [Jira.Project.t()]} | :error
  def get_all_projects(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :properties, :recent])

    client.request(%{
      args: [],
      call: {Jira.Projects, :get_all_projects},
      url: "/rest/api/2/project",
      method: :get,
      query: query,
      response: [{200, [{Jira.Project, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get all statuses for project

  Returns the valid statuses for a project. The statuses are grouped by issue type, as each project has a set of valid issue types and each issue type has a set of valid statuses.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
  """
  @spec get_all_statuses(String.t(), keyword) :: {:ok, [Jira.IssueTypeWithStatus.t()]} | :error
  def get_all_statuses(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.Projects, :get_all_statuses},
      url: "/rest/api/2/project/#{projectIdOrKey}/statuses",
      method: :get,
      response: [{200, [{Jira.IssueTypeWithStatus, :t}]}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project issue type hierarchy

  Get the issue type hierarchy for a next-gen project.

  The issue type hierarchy for a project consists of:

   *  *Epic* at level 1 (optional).
   *  One or more issue types at level 0 such as *Story*, *Task*, or *Bug*. Where the issue type *Epic* is defined, these issue types are used to break down the content of an epic.
   *  *Subtask* at level -1 (optional). This issue type enables level 0 issue types to be broken down into components. Issues based on a level -1 issue type must have a parent issue.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
  """
  @spec get_hierarchy(integer, keyword) :: {:ok, Jira.ProjectIssueTypeHierarchy.t()} | :error
  def get_hierarchy(projectId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectId: projectId],
      call: {Jira.Projects, :get_hierarchy},
      url: "/rest/api/2/project/#{projectId}/hierarchy",
      method: :get,
      response: [
        {200, {Jira.ProjectIssueTypeHierarchy, :t}},
        {400, :null},
        {401, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get project notification scheme

  Gets a [notification scheme](https://confluence.atlassian.com/x/8YdKLg) associated with the project.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg).

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `all` Returns all expandable information
       *  `field` Returns information about any custom fields assigned to receive an event
       *  `group` Returns information about any groups assigned to receive an event
       *  `notificationSchemeEvents` Returns a list of event associations. This list is returned for all expandable information
       *  `projectRole` Returns information about any project roles assigned to receive an event
       *  `user` Returns information about any users assigned to receive an event

  """
  @spec get_notification_scheme_for_project(String.t(), keyword) ::
          {:ok, Jira.NotificationScheme.t()} | :error
  def get_notification_scheme_for_project(projectKeyOrId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [projectKeyOrId: projectKeyOrId],
      call: {Jira.Projects, :get_notification_scheme_for_project},
      url: "/rest/api/2/project/#{projectKeyOrId}/notificationscheme",
      method: :get,
      query: query,
      response: [{200, {Jira.NotificationScheme, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project

  Returns the [project details](https://confluence.atlassian.com/x/ahLpNw) for a project.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Note that the project description, issue types, and project lead are included in all responses by default. Expand options include:
      
       *  `description` The project description.
       *  `issueTypes` The issue types associated with the project.
       *  `lead` The project lead.
       *  `projectKeys` All project keys associated with the project.
       *  `issueTypeHierarchy` The project issue type hierarchy.
    * `properties`: A list of project properties to return for the project. This parameter accepts a comma-separated list.

  """
  @spec get_project(String.t(), keyword) :: {:ok, Jira.Project.t()} | :error
  def get_project(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :properties])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.Projects, :get_project},
      url: "/rest/api/2/project/#{projectIdOrKey}",
      method: :get,
      query: query,
      response: [{200, {Jira.Project, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get recent projects

  Returns a list of up to 20 projects recently viewed by the user that are still visible to the user.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Projects are returned only where the user has one of:

   *  *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expanded options include:
      
       *  `description` Returns the project description.
       *  `projectKeys` Returns all project keys associated with a project.
       *  `lead` Returns information about the project lead.
       *  `issueTypes` Returns all issue types associated with the project.
       *  `url` Returns the URL associated with the project.
       *  `permissions` Returns the permissions associated with the project.
       *  `insight` EXPERIMENTAL. Returns the insight details of total issue count and last issue update time for the project.
       *  `*` Returns the project with all available expand options.
    * `properties`: EXPERIMENTAL. A list of project properties to return for the project. This parameter accepts a comma-separated list. Invalid property names are ignored.

  """
  @spec get_recent(keyword) :: {:ok, [Jira.Project.t()]} | :error
  def get_recent(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :properties])

    client.request(%{
      args: [],
      call: {Jira.Projects, :get_recent},
      url: "/rest/api/2/project/recent",
      method: :get,
      query: query,
      response: [{200, [{Jira.Project, :t}]}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Restore deleted or archived project

  Restores a project that has been archived or placed in the Jira recycle bin.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg)for Company managed projects.
   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project for Team managed projects.
  """
  @spec restore(String.t(), keyword) :: {:ok, Jira.Project.t()} | :error
  def restore(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.Projects, :restore},
      url: "/rest/api/2/project/#{projectIdOrKey}/restore",
      method: :post,
      response: [{200, {Jira.Project, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get projects paginated

  Returns a [paginated](#pagination) list of projects visible to the user.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Projects are returned only where the user has one of:

   *  *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `orderBy`: [Order](#ordering) the results by a field.
      
       *  `category` Sorts by project category. A complete list of category IDs is found using [Get all project categories](#api-rest-api-2-projectCategory-get).
       *  `issueCount` Sorts by the total number of issues in each project.
       *  `key` Sorts by project key.
       *  `lastIssueUpdatedTime` Sorts by the last issue update time.
       *  `name` Sorts by project name.
       *  `owner` Sorts by project lead.
       *  `archivedDate` EXPERIMENTAL. Sorts by project archived date.
       *  `deletedDate` EXPERIMENTAL. Sorts by project deleted date.
    * `id`: The project IDs to filter the results by. To include multiple IDs, provide an ampersand-separated list. For example, `id=10000&id=10001`. Up to 50 project IDs can be provided.
    * `keys`: The project keys to filter the results by. To include multiple keys, provide an ampersand-separated list. For example, `keys=PA&keys=PB`. Up to 50 project keys can be provided.
    * `query`: Filter the results using a literal string. Projects with a matching `key` or `name` are returned (case insensitive).
    * `typeKey`: Orders results by the [project type](https://confluence.atlassian.com/x/GwiiLQ#Jiraapplicationsoverview-Productfeaturesandprojecttypes). This parameter accepts a comma-separated list. Valid values are `business`, `service_desk`, and `software`.
    * `categoryId`: The ID of the project's category. A complete list of category IDs is found using the [Get all project categories](#api-rest-api-2-projectCategory-get) operation.
    * `action`: Filter results by projects for which the user can:
      
       *  `view` the project, meaning that they have one of the following permissions:
          
           *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
           *  *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
           *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
       *  `browse` the project, meaning that they have the *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
       *  `edit` the project, meaning that they have one of the following permissions:
          
           *  *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
           *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
       *  `create` the project, meaning that they have the *Create issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project in which the issue is created.
    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expanded options include:
      
       *  `description` Returns the project description.
       *  `projectKeys` Returns all project keys associated with a project.
       *  `lead` Returns information about the project lead.
       *  `issueTypes` Returns all issue types associated with the project.
       *  `url` Returns the URL associated with the project.
       *  `insight` EXPERIMENTAL. Returns the insight details of total issue count and last issue update time for the project.
    * `status`: EXPERIMENTAL. Filter results by project status:
      
       *  `live` Search live projects.
       *  `archived` Search archived projects.
       *  `deleted` Search deleted projects, those in the recycle bin.
    * `properties`: EXPERIMENTAL. A list of project properties to return for the project. This parameter accepts a comma-separated list.
    * `propertyQuery`: EXPERIMENTAL. A query string used to search properties. The query string cannot be specified using a JSON object. For example, to search for the value of `nested` from `{"something":{"nested":1,"other":2}}` use `[thepropertykey].something.nested=1`. Note that the propertyQuery key is enclosed in square brackets to enable searching where the propertyQuery key includes dot (.) or equals (=) characters. Note that `thepropertykey` is only returned when included in `properties`.

  """
  @spec search_projects(keyword) :: {:ok, Jira.PageBeanProject.t()} | :error
  def search_projects(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :action,
        :categoryId,
        :expand,
        :id,
        :keys,
        :maxResults,
        :orderBy,
        :properties,
        :propertyQuery,
        :query,
        :startAt,
        :status,
        :typeKey
      ])

    client.request(%{
      args: [],
      call: {Jira.Projects, :search_projects},
      url: "/rest/api/2/project/search",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanProject, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update project

  Updates the [project details](https://confluence.atlassian.com/x/ahLpNw) of a project.

  All parameters are optional in the body of the request. Schemes will only be updated if they are included in the request, any omitted schemes will be left unchanged.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). is only needed when changing the schemes or project key. Otherwise you will only need *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg)

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Note that the project description, issue types, and project lead are included in all responses by default. Expand options include:
      
       *  `description` The project description.
       *  `issueTypes` The issue types associated with the project.
       *  `lead` The project lead.
       *  `projectKeys` All project keys associated with the project.

  """
  @spec update_project(String.t(), Jira.UpdateProjectDetails.t(), keyword) ::
          {:ok, Jira.Project.t()} | :error
  def update_project(projectIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, body: body],
      call: {Jira.Projects, :update_project},
      url: "/rest/api/2/project/#{projectIdOrKey}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jira.UpdateProjectDetails, :t}}],
      response: [
        {200, {Jira.Project, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end
end
