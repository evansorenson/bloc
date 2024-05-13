defmodule Jira.ProjectComponents do
  @moduledoc """
  Provides API endpoints related to project components
  """

  @default_client Jira.Client

  @doc """
  Create component

  Creates a component. Use components to provide containers for issues within a project. Use components to provide containers for issues within a project.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project in which the component is created or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_component(Jira.ProjectComponent.t(), keyword) ::
          {:ok, Jira.ProjectComponent.t()} | :error
  def create_component(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.ProjectComponents, :create_component},
      url: "/rest/api/2/component",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.ProjectComponent, :t}}],
      response: [
        {201, {Jira.ProjectComponent, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete component

  Deletes a component.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the component or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `moveIssuesTo`: The ID of the component to replace the deleted component. If this value is null no replacement is made.

  """
  @spec delete_component(String.t(), keyword) :: :ok | :error
  def delete_component(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:moveIssuesTo])

    client.request(%{
      args: [id: id],
      call: {Jira.ProjectComponents, :delete_component},
      url: "/rest/api/2/component/#{id}",
      method: :delete,
      query: query,
      response: [{204, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Find components for projects

  Returns a [paginated](#pagination) list of all components in a project, including global (Compass) components when applicable.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `projectIdsOrKeys`: The project IDs and/or project keys (case sensitive).
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `orderBy`: [Order](#ordering) the results by a field:
      
       *  `description` Sorts by the component description.
       *  `name` Sorts by component name.
    * `query`: Filter the results using a literal string. Components with a matching `name` or `description` are returned (case insensitive).

  """
  @spec find_components_for_projects(keyword) ::
          {:ok, Jira.PageBean2ComponentJsonBean.t()} | :error
  def find_components_for_projects(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :orderBy, :projectIdsOrKeys, :query, :startAt])

    client.request(%{
      args: [],
      call: {Jira.ProjectComponents, :find_components_for_projects},
      url: "/rest/api/2/component",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBean2ComponentJsonBean, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get component

  Returns a component.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for project containing the component.
  """
  @spec get_component(String.t(), keyword) :: {:ok, Jira.ProjectComponent.t()} | :error
  def get_component(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.ProjectComponents, :get_component},
      url: "/rest/api/2/component/#{id}",
      method: :get,
      response: [{200, {Jira.ProjectComponent, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get component issues count

  Returns the counts of issues assigned to the component.

  This operation can be accessed anonymously.

  **Deprecation notice:** The required OAuth 2.0 scopes will be updated on June 15, 2024.

   *  **Classic**: `read:jira-work`
   *  **Granular**: `read:field:jira`, `read:project.component:jira`

  **[Permissions](#permissions) required:** None.
  """
  @spec get_component_related_issues(String.t(), keyword) ::
          {:ok, Jira.ComponentIssuesCount.t()} | :error
  def get_component_related_issues(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.ProjectComponents, :get_component_related_issues},
      url: "/rest/api/2/component/#{id}/relatedIssueCounts",
      method: :get,
      response: [{200, {Jira.ComponentIssuesCount, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project components

  Returns all components in a project. See the [Get project components paginated](#api-rest-api-2-project-projectIdOrKey-component-get) resource if you want to get a full list of components with pagination.

  If your project uses Compass components, this API will return a paginated list of Compass components that are linked to issues in that project.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `componentSource`: The source of the components to return. Can be `jira` (default), `compass` or `auto`. When `auto` is specified, the API will return connected Compass components if the project is opted into Compass, otherwise it will return Jira components. Defaults to `jira`.

  """
  @spec get_project_components(String.t(), keyword) :: {:ok, [Jira.ProjectComponent.t()]} | :error
  def get_project_components(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:componentSource])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.ProjectComponents, :get_project_components},
      url: "/rest/api/2/project/#{projectIdOrKey}/components",
      method: :get,
      query: query,
      response: [{200, [{Jira.ProjectComponent, :t}]}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project components paginated

  Returns a [paginated](#pagination) list of all components in a project. See the [Get project components](#api-rest-api-2-project-projectIdOrKey-components-get) resource if you want to get a full list of versions without pagination.

  If your project uses Compass components, this API will return a list of Compass components that are linked to issues in that project.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `orderBy`: [Order](#ordering) the results by a field:
      
       *  `description` Sorts by the component description.
       *  `issueCount` Sorts by the count of issues associated with the component.
       *  `lead` Sorts by the user key of the component's project lead.
       *  `name` Sorts by component name.
    * `componentSource`: The source of the components to return. Can be `jira` (default), `compass` or `auto`. When `auto` is specified, the API will return connected Compass components if the project is opted into Compass, otherwise it will return Jira components. Defaults to `jira`.
    * `query`: Filter the results using a literal string. Components with a matching `name` or `description` are returned (case insensitive).

  """
  @spec get_project_components_paginated(String.t(), keyword) ::
          {:ok, Jira.PageBeanComponentWithIssueCount.t()} | :error
  def get_project_components_paginated(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:componentSource, :maxResults, :orderBy, :query, :startAt])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.ProjectComponents, :get_project_components_paginated},
      url: "/rest/api/2/project/#{projectIdOrKey}/component",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanComponentWithIssueCount, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update component

  Updates a component. Any fields included in the request are overwritten. If `leadAccountId` is an empty string ("") the component lead is removed.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the component or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_component(String.t(), Jira.ProjectComponent.t(), keyword) ::
          {:ok, Jira.ProjectComponent.t()} | :error
  def update_component(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.ProjectComponents, :update_component},
      url: "/rest/api/2/component/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.ProjectComponent, :t}}],
      response: [
        {200, {Jira.ProjectComponent, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end
end
