defmodule Jira.IssueSecuritySchemes do
  @moduledoc """
  Provides API endpoints related to issue security schemes
  """

  @default_client Jira.Client

  @doc """
  Add issue security levels

  Adds levels and levels' members to the issue security scheme. You can add up to 100 levels per request.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_security_level(String.t(), Jira.AddSecuritySchemeLevelsRequestBean.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def add_security_level(schemeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId, body: body],
      call: {Jira.IssueSecuritySchemes, :add_security_level},
      url: "/rest/api/2/issuesecurityschemes/#{schemeId}/level",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.AddSecuritySchemeLevelsRequestBean, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add issue security level members

  Adds members to the issue security level. You can add up to 100 members per request.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_security_level_members(
          String.t(),
          String.t(),
          Jira.SecuritySchemeMembersRequest.t(),
          keyword
        ) :: {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def add_security_level_members(schemeId, levelId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId, levelId: levelId, body: body],
      call: {Jira.IssueSecuritySchemes, :add_security_level_members},
      url: "/rest/api/2/issuesecurityschemes/#{schemeId}/level/#{levelId}/member",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.SecuritySchemeMembersRequest, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Associate security scheme to project

  Associates an issue security scheme with a project and remaps security levels of issues to the new levels, if provided.

  This operation is [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec associate_schemes_to_projects(Jira.AssociateSecuritySchemeWithProjectDetails.t(), keyword) ::
          :ok | {:error, Jira.ErrorCollection.t()}
  def associate_schemes_to_projects(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueSecuritySchemes, :associate_schemes_to_projects},
      url: "/rest/api/2/issuesecurityschemes/project",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.AssociateSecuritySchemeWithProjectDetails, :t}}],
      response: [
        {303, {Jira.TaskProgressBeanObject, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}},
        {409, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create issue security scheme

  Creates a security scheme with security scheme levels and levels' members. You can create up to 100 security scheme levels and security scheme levels' members per request.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_issue_security_scheme(Jira.CreateIssueSecuritySchemeDetails.t(), keyword) ::
          {:ok, Jira.SecuritySchemeId.t()} | {:error, Jira.ErrorCollection.t()}
  def create_issue_security_scheme(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueSecuritySchemes, :create_issue_security_scheme},
      url: "/rest/api/2/issuesecurityschemes",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.CreateIssueSecuritySchemeDetails, :t}}],
      response: [
        {201, {Jira.SecuritySchemeId, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete issue security scheme

  Deletes an issue security scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_security_scheme(String.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def delete_security_scheme(schemeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId],
      call: {Jira.IssueSecuritySchemes, :delete_security_scheme},
      url: "/rest/api/2/issuesecurityschemes/#{schemeId}",
      method: :delete,
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get issue security scheme

  Returns an issue security scheme along with its security levels.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
   *  *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for a project that uses the requested issue security scheme.
  """
  @spec get_issue_security_scheme(integer, keyword) :: {:ok, Jira.SecurityScheme.t()} | :error
  def get_issue_security_scheme(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.IssueSecuritySchemes, :get_issue_security_scheme},
      url: "/rest/api/2/issuesecurityschemes/#{id}",
      method: :get,
      response: [{200, {Jira.SecurityScheme, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue security schemes

  Returns all [issue security schemes](https://confluence.atlassian.com/x/J4lKLg).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_issue_security_schemes(keyword) :: {:ok, Jira.SecuritySchemes.t()} | :error
  def get_issue_security_schemes(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.IssueSecuritySchemes, :get_issue_security_schemes},
      url: "/rest/api/2/issuesecurityschemes",
      method: :get,
      response: [{200, {Jira.SecuritySchemes, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue security level members

  Returns a [paginated](#pagination) list of issue security level members.

  Only issue security level members in the context of classic projects are returned.

  Filtering using parameters is inclusive: if you specify both security scheme IDs and level IDs, the result will include all issue security level members from the specified schemes and levels.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of issue security level member IDs. To include multiple issue security level members separate IDs with an ampersand: `id=10000&id=10001`.
    * `schemeId`: The list of issue security scheme IDs. To include multiple issue security schemes separate IDs with an ampersand: `schemeId=10000&schemeId=10001`.
    * `levelId`: The list of issue security level IDs. To include multiple issue security levels separate IDs with an ampersand: `levelId=10000&levelId=10001`.
    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `all` Returns all expandable information
       *  `field` Returns information about the custom field granted the permission
       *  `group` Returns information about the group that is granted the permission
       *  `projectRole` Returns information about the project role granted the permission
       *  `user` Returns information about the user who is granted the permission

  """
  @spec get_security_level_members(keyword) ::
          {:ok, Jira.PageBeanSecurityLevelMember.t()} | {:error, any}
  def get_security_level_members(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :id, :levelId, :maxResults, :schemeId, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueSecuritySchemes, :get_security_level_members},
      url: "/rest/api/2/issuesecurityschemes/level/member",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanSecurityLevelMember, :t}},
        {400, :null},
        {401, :null},
        {403, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Get issue security levels

  Returns a [paginated](#pagination) list of issue security levels.

  Only issue security levels in the context of classic projects are returned.

  Filtering using IDs is inclusive: if you specify both security scheme IDs and level IDs, the result will include both specified issue security levels and all issue security levels from the specified schemes.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of issue security scheme level IDs. To include multiple issue security levels, separate IDs with an ampersand: `id=10000&id=10001`.
    * `schemeId`: The list of issue security scheme IDs. To include multiple issue security schemes, separate IDs with an ampersand: `schemeId=10000&schemeId=10001`.
    * `onlyDefault`: When set to true, returns multiple default levels for each security scheme containing a default. If you provide scheme and level IDs not associated with the default, returns an empty page. The default value is false.

  """
  @spec get_security_levels(keyword) ::
          {:ok, Jira.PageBeanSecurityLevel.t()} | {:error, Jira.ErrorCollection.t()}
  def get_security_levels(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id, :maxResults, :onlyDefault, :schemeId, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueSecuritySchemes, :get_security_levels},
      url: "/rest/api/2/issuesecurityschemes/level",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanSecurityLevel, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove issue security level

  Deletes an issue security level.

  This operation is [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `replaceWith`: The ID of the issue security level that will replace the currently selected level.

  """
  @spec remove_level(String.t(), String.t(), keyword) :: :ok | {:error, Jira.ErrorCollection.t()}
  def remove_level(schemeId, levelId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:replaceWith])

    client.request(%{
      args: [schemeId: schemeId, levelId: levelId],
      call: {Jira.IssueSecuritySchemes, :remove_level},
      url: "/rest/api/2/issuesecurityschemes/#{schemeId}/level/#{levelId}",
      method: :delete,
      query: query,
      response: [
        {303, {Jira.TaskProgressBeanObject, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}},
        {409, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove member from issue security level

  Removes an issue security level member from an issue security scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec remove_member_from_security_level(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def remove_member_from_security_level(schemeId, levelId, memberId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId, levelId: levelId, memberId: memberId],
      call: {Jira.IssueSecuritySchemes, :remove_member_from_security_level},
      url: "/rest/api/2/issuesecurityschemes/#{schemeId}/level/#{levelId}/member/#{memberId}",
      method: :delete,
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get projects using issue security schemes

  Returns a [paginated](#pagination) mapping of projects that are using security schemes. You can provide either one or multiple security scheme IDs or project IDs to filter by. If you don't provide any, this will return a list of all mappings. Only issue security schemes in the context of classic projects are supported. **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `issueSecuritySchemeId`: The list of security scheme IDs to be filtered out.
    * `projectId`: The list of project IDs to be filtered out.

  """
  @spec search_projects_using_security_schemes(keyword) ::
          {:ok, Jira.PageBeanIssueSecuritySchemeToProjectMapping.t()}
          | {:error, Jira.ErrorCollection.t()}
  def search_projects_using_security_schemes(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:issueSecuritySchemeId, :maxResults, :projectId, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueSecuritySchemes, :search_projects_using_security_schemes},
      url: "/rest/api/2/issuesecurityschemes/project",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanIssueSecuritySchemeToProjectMapping, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Search issue security schemes

  Returns a [paginated](#pagination) list of issue security schemes.  
  If you specify the project ID parameter, the result will contain issue security schemes and related project IDs you filter by. Use \{@link IssueSecuritySchemeResource\#searchProjectsUsingSecuritySchemes(String, String, Set, Set)\} to obtain all projects related to scheme.

  Only issue security schemes in the context of classic projects are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of issue security scheme IDs. To include multiple issue security scheme IDs, separate IDs with an ampersand: `id=10000&id=10001`.
    * `projectId`: The list of project IDs. To include multiple project IDs, separate IDs with an ampersand: `projectId=10000&projectId=10001`.

  """
  @spec search_security_schemes(keyword) ::
          {:ok, Jira.PageBeanSecuritySchemeWithProjects.t()} | {:error, any}
  def search_security_schemes(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id, :maxResults, :projectId, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueSecuritySchemes, :search_security_schemes},
      url: "/rest/api/2/issuesecurityschemes/search",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanSecuritySchemeWithProjects, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Set default issue security levels

  Sets default issue security levels for schemes.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_default_levels(Jira.SetDefaultLevelsRequest.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def set_default_levels(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueSecuritySchemes, :set_default_levels},
      url: "/rest/api/2/issuesecurityschemes/level/default",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.SetDefaultLevelsRequest, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update issue security scheme

  Updates the issue security scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_issue_security_scheme(
          String.t(),
          Jira.UpdateIssueSecuritySchemeRequestBean.t(),
          keyword
        ) :: {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def update_issue_security_scheme(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.IssueSecuritySchemes, :update_issue_security_scheme},
      url: "/rest/api/2/issuesecurityschemes/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.UpdateIssueSecuritySchemeRequestBean, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update issue security level

  Updates the issue security level.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_security_level(
          String.t(),
          String.t(),
          Jira.UpdateIssueSecurityLevelDetails.t(),
          keyword
        ) :: {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def update_security_level(schemeId, levelId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId, levelId: levelId, body: body],
      call: {Jira.IssueSecuritySchemes, :update_security_level},
      url: "/rest/api/2/issuesecurityschemes/#{schemeId}/level/#{levelId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.UpdateIssueSecurityLevelDetails, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
