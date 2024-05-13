defmodule Jira.IssueTypeScreenSchemes do
  @moduledoc """
  Provides API endpoints related to issue type screen schemes
  """

  @default_client Jira.Client

  @doc """
  Append mappings to issue type screen scheme

  Appends issue type to screen scheme mappings to an issue type screen scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec append_mappings_for_issue_type_screen_scheme(
          String.t(),
          Jira.IssueTypeScreenSchemeMappingDetails.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def append_mappings_for_issue_type_screen_scheme(issueTypeScreenSchemeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueTypeScreenSchemeId: issueTypeScreenSchemeId, body: body],
      call: {Jira.IssueTypeScreenSchemes, :append_mappings_for_issue_type_screen_scheme},
      url: "/rest/api/2/issuetypescreenscheme/#{issueTypeScreenSchemeId}/mapping",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.IssueTypeScreenSchemeMappingDetails, :t}}],
      response: [
        {204, :map},
        {400, :unknown},
        {401, :null},
        {403, :null},
        {404, :unknown},
        {409, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Assign issue type screen scheme to project

  Assigns an issue type screen scheme to a project.

  Issue type screen schemes can only be assigned to classic projects.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec assign_issue_type_screen_scheme_to_project(
          Jira.IssueTypeScreenSchemeProjectAssociation.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def assign_issue_type_screen_scheme_to_project(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueTypeScreenSchemes, :assign_issue_type_screen_scheme_to_project},
      url: "/rest/api/2/issuetypescreenscheme/project",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.IssueTypeScreenSchemeProjectAssociation, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Create issue type screen scheme

  Creates an issue type screen scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_issue_type_screen_scheme(Jira.IssueTypeScreenSchemeDetails.t(), keyword) ::
          {:ok, Jira.IssueTypeScreenSchemeId.t()} | {:error, any}
  def create_issue_type_screen_scheme(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueTypeScreenSchemes, :create_issue_type_screen_scheme},
      url: "/rest/api/2/issuetypescreenscheme",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.IssueTypeScreenSchemeDetails, :t}}],
      response: [
        {201, {Jira.IssueTypeScreenSchemeId, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown},
        {409, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Delete issue type screen scheme

  Deletes an issue type screen scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_issue_type_screen_scheme(String.t(), keyword) :: {:ok, map} | {:error, any}
  def delete_issue_type_screen_scheme(issueTypeScreenSchemeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueTypeScreenSchemeId: issueTypeScreenSchemeId],
      call: {Jira.IssueTypeScreenSchemes, :delete_issue_type_screen_scheme},
      url: "/rest/api/2/issuetypescreenscheme/#{issueTypeScreenSchemeId}",
      method: :delete,
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :null}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get issue type screen scheme items

  Returns a [paginated](#pagination) list of issue type screen scheme items.

  Only issue type screen schemes used in classic projects are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `issueTypeScreenSchemeId`: The list of issue type screen scheme IDs. To include multiple issue type screen schemes, separate IDs with ampersand: `issueTypeScreenSchemeId=10000&issueTypeScreenSchemeId=10001`.

  """
  @spec get_issue_type_screen_scheme_mappings(keyword) ::
          {:ok, Jira.PageBeanIssueTypeScreenSchemeItem.t()} | :error
  def get_issue_type_screen_scheme_mappings(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:issueTypeScreenSchemeId, :maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueTypeScreenSchemes, :get_issue_type_screen_scheme_mappings},
      url: "/rest/api/2/issuetypescreenscheme/mapping",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanIssueTypeScreenSchemeItem, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get issue type screen schemes for projects

  Returns a [paginated](#pagination) list of issue type screen schemes and, for each issue type screen scheme, a list of the projects that use it.

  Only issue type screen schemes used in classic projects are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `projectId`: The list of project IDs. To include multiple projects, separate IDs with ampersand: `projectId=10000&projectId=10001`.

  """
  @spec get_issue_type_screen_scheme_project_associations(keyword) ::
          {:ok, Jira.PageBeanIssueTypeScreenSchemesProjects.t()} | :error
  def get_issue_type_screen_scheme_project_associations(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :projectId, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueTypeScreenSchemes, :get_issue_type_screen_scheme_project_associations},
      url: "/rest/api/2/issuetypescreenscheme/project",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanIssueTypeScreenSchemesProjects, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get issue type screen schemes

  Returns a [paginated](#pagination) list of issue type screen schemes.

  Only issue type screen schemes used in classic projects are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of issue type screen scheme IDs. To include multiple IDs, provide an ampersand-separated list. For example, `id=10000&id=10001`.
    * `queryString`: String used to perform a case-insensitive partial match with issue type screen scheme name.
    * `orderBy`: [Order](#ordering) the results by a field:
      
       *  `name` Sorts by issue type screen scheme name.
       *  `id` Sorts by issue type screen scheme ID.
    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts `projects` that, for each issue type screen schemes, returns information about the projects the issue type screen scheme is assigned to.

  """
  @spec get_issue_type_screen_schemes(keyword) ::
          {:ok, Jira.PageBeanIssueTypeScreenScheme.t()} | :error
  def get_issue_type_screen_schemes(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :id, :maxResults, :orderBy, :queryString, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueTypeScreenSchemes, :get_issue_type_screen_schemes},
      url: "/rest/api/2/issuetypescreenscheme",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanIssueTypeScreenScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get issue type screen scheme projects

  Returns a [paginated](#pagination) list of projects associated with an issue type screen scheme.

  Only company-managed projects associated with an issue type screen scheme are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `query`

  """
  @spec get_projects_for_issue_type_screen_scheme(integer, keyword) ::
          {:ok, Jira.PageBeanProjectDetails.t()} | :error
  def get_projects_for_issue_type_screen_scheme(issueTypeScreenSchemeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :query, :startAt])

    client.request(%{
      args: [issueTypeScreenSchemeId: issueTypeScreenSchemeId],
      call: {Jira.IssueTypeScreenSchemes, :get_projects_for_issue_type_screen_scheme},
      url: "/rest/api/2/issuetypescreenscheme/#{issueTypeScreenSchemeId}/project",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanProjectDetails, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Remove mappings from issue type screen scheme

  Removes issue type to screen scheme mappings from an issue type screen scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec remove_mappings_from_issue_type_screen_scheme(String.t(), Jira.IssueTypeIds.t(), keyword) ::
          {:ok, map} | {:error, any}
  def remove_mappings_from_issue_type_screen_scheme(issueTypeScreenSchemeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueTypeScreenSchemeId: issueTypeScreenSchemeId, body: body],
      call: {Jira.IssueTypeScreenSchemes, :remove_mappings_from_issue_type_screen_scheme},
      url: "/rest/api/2/issuetypescreenscheme/#{issueTypeScreenSchemeId}/mapping/remove",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.IssueTypeIds, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update issue type screen scheme default screen scheme

  Updates the default screen scheme of an issue type screen scheme. The default screen scheme is used for all unmapped issue types.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_default_screen_scheme(String.t(), Jira.UpdateDefaultScreenScheme.t(), keyword) ::
          {:ok, map} | {:error, any}
  def update_default_screen_scheme(issueTypeScreenSchemeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueTypeScreenSchemeId: issueTypeScreenSchemeId, body: body],
      call: {Jira.IssueTypeScreenSchemes, :update_default_screen_scheme},
      url: "/rest/api/2/issuetypescreenscheme/#{issueTypeScreenSchemeId}/mapping/default",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.UpdateDefaultScreenScheme, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update issue type screen scheme

  Updates an issue type screen scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_issue_type_screen_scheme(
          String.t(),
          Jira.IssueTypeScreenSchemeUpdateDetails.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def update_issue_type_screen_scheme(issueTypeScreenSchemeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueTypeScreenSchemeId: issueTypeScreenSchemeId, body: body],
      call: {Jira.IssueTypeScreenSchemes, :update_issue_type_screen_scheme},
      url: "/rest/api/2/issuetypescreenscheme/#{issueTypeScreenSchemeId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.IssueTypeScreenSchemeUpdateDetails, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end
end
