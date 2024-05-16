defmodule Jirex.ProjectVersions do
  @moduledoc """
  Provides API endpoints related to project versions
  """

  @default_client Jirex.Client

  @doc """
  Create related work

  Creates a related work for the given version. You can only create a generic link type of related works via this API. relatedWorkId will be auto-generated UUID, that does not need to be provided.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Resolve issues:* and *Edit issues* [Managing project permissions](https://confluence.atlassian.com/adminjiraserver/managing-project-permissions-938847145.html) for the project that contains the version.
  """
  @spec create_related_work(String.t(), Jirex.VersionRelatedWork.t(), keyword) ::
          {:ok, Jirex.VersionRelatedWork.t()} | :error
  def create_related_work(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.ProjectVersions, :create_related_work},
      url: "/rest/api/2/version/#{id}/relatedwork",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.VersionRelatedWork, :t}}],
      response: [
        {201, {Jirex.VersionRelatedWork, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Create version

  Creates a project version.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project the version is added to.
  """
  @spec create_version(Jirex.Version.t(), keyword) :: {:ok, Jirex.Version.t()} | :error
  def create_version(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.ProjectVersions, :create_version},
      url: "/rest/api/2/version",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.Version, :t}}],
      response: [{201, {Jirex.Version, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete and replace version

  Deletes a project version.

  Alternative versions can be provided to update issues that use the deleted version in `fixVersion`, `affectedVersion`, or any version picker custom fields. If alternatives are not provided, occurrences of `fixVersion`, `affectedVersion`, and any version picker custom field, that contain the deleted version, are cleared. Any replacement version must be in the same project as the version being deleted and cannot be the version being deleted.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that contains the version.
  """
  @spec delete_and_replace_version(String.t(), Jirex.DeleteAndReplaceVersionBean.t(), keyword) ::
          {:ok, map} | :error
  def delete_and_replace_version(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.ProjectVersions, :delete_and_replace_version},
      url: "/rest/api/2/version/#{id}/removeAndSwap",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.DeleteAndReplaceVersionBean, :t}}],
      response: [{204, :map}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete related work

  Deletes the given related work for the given version.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Resolve issues:* and *Edit issues* [Managing project permissions](https://confluence.atlassian.com/adminjiraserver/managing-project-permissions-938847145.html) for the project that contains the version.
  """
  @spec delete_related_work(String.t(), String.t(), keyword) :: :ok | :error
  def delete_related_work(versionId, relatedWorkId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [versionId: versionId, relatedWorkId: relatedWorkId],
      call: {Jirex.ProjectVersions, :delete_related_work},
      url: "/rest/api/2/version/#{versionId}/relatedwork/#{relatedWorkId}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete version

  Deletes a project version.

  Deprecated, use [ Delete and replace version](#api-rest-api-2-version-id-removeAndSwap-post) that supports swapping version values in custom fields, in addition to the swapping for `fixVersion` and `affectedVersion` provided in this resource.

  Alternative versions can be provided to update issues that use the deleted version in `fixVersion` or `affectedVersion`. If alternatives are not provided, occurrences of `fixVersion` and `affectedVersion` that contain the deleted version are cleared.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that contains the version.

  ## Options

    * `moveFixIssuesTo`: The ID of the version to update `fixVersion` to when the field contains the deleted version. The replacement version must be in the same project as the version being deleted and cannot be the version being deleted.
    * `moveAffectedIssuesTo`: The ID of the version to update `affectedVersion` to when the field contains the deleted version. The replacement version must be in the same project as the version being deleted and cannot be the version being deleted.

  """
  @spec delete_version(String.t(), keyword) :: :ok | :error
  def delete_version(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:moveAffectedIssuesTo, :moveFixIssuesTo])

    client.request(%{
      args: [id: id],
      call: {Jirex.ProjectVersions, :delete_version},
      url: "/rest/api/2/version/#{id}",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project versions

  Returns all versions in a project. The response is not paginated. Use [Get project versions paginated](#api-rest-api-2-project-projectIdOrKey-version-get) if you want to get the versions in a project with pagination.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts `operations`, which returns actions that can be performed on the version.

  """
  @spec get_project_versions(String.t(), keyword) :: {:ok, [Jirex.Version.t()]} | :error
  def get_project_versions(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jirex.ProjectVersions, :get_project_versions},
      url: "/rest/api/2/project/#{projectIdOrKey}/versions",
      method: :get,
      query: query,
      response: [{200, [{Jirex.Version, :t}]}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project versions paginated

  Returns a [paginated](#pagination) list of all versions in a project. See the [Get project versions](#api-rest-api-2-project-projectIdOrKey-versions-get) resource if you want to get a full list of versions without pagination.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `orderBy`: [Order](#ordering) the results by a field:

       *  `description` Sorts by version description.
       *  `name` Sorts by version name.
       *  `releaseDate` Sorts by release date, starting with the oldest date. Versions with no release date are listed last.
       *  `sequence` Sorts by the order of appearance in the user interface.
       *  `startDate` Sorts by start date, starting with the oldest date. Versions with no start date are listed last.
    * `query`: Filter the results using a literal string. Versions with matching `name` or `description` are returned (case insensitive).
    * `status`: A list of status values used to filter the results by version status. This parameter accepts a comma-separated list. The status values are `released`, `unreleased`, and `archived`.
    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `issuesstatus` Returns the number of issues in each status category for each version.
       *  `operations` Returns actions that can be performed on the specified version.
       *  `driver` Returns the Atlassian account ID of the version driver.
       *  `approvers` Returns a list containing the approvers for this version.

  """
  @spec get_project_versions_paginated(String.t(), keyword) ::
          {:ok, Jirex.PageBeanVersion.t()} | :error
  def get_project_versions_paginated(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :maxResults, :orderBy, :query, :startAt, :status])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jirex.ProjectVersions, :get_project_versions_paginated},
      url: "/rest/api/2/project/#{projectIdOrKey}/version",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanVersion, :t}}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get related work

  Returns related work items for the given version id.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the version.
  """
  @spec get_related_work(String.t(), keyword) :: {:ok, [Jirex.VersionRelatedWork.t()]} | :error
  def get_related_work(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.ProjectVersions, :get_related_work},
      url: "/rest/api/2/version/#{id}/relatedwork",
      method: :get,
      response: [
        {200, [{Jirex.VersionRelatedWork, :t}]},
        {401, :null},
        {404, :null},
        {500, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get version

  Returns a project version.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the version.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about version in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `operations` Returns the list of operations available for this version.
       *  `issuesstatus` Returns the count of issues in this version for each of the status categories *to do*, *in progress*, *done*, and *unmapped*. The *unmapped* property represents the number of issues with a status other than *to do*, *in progress*, and *done*.
       *  `driver` Returns the Atlassian account ID of the version driver.
       *  `approvers` Returns a list containing the Atlassian account IDs of approvers for this version.

  """
  @spec get_version(String.t(), keyword) :: {:ok, Jirex.Version.t()} | :error
  def get_version(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [id: id],
      call: {Jirex.ProjectVersions, :get_version},
      url: "/rest/api/2/version/#{id}",
      method: :get,
      query: query,
      response: [{200, {Jirex.Version, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get version's related issues count

  Returns the following counts for a version:

   *  Number of issues where the `fixVersion` is set to the version.
   *  Number of issues where the `affectedVersion` is set to the version.
   *  Number of issues where a version custom field is set to the version.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* project permission for the project that contains the version.
  """
  @spec get_version_related_issues(String.t(), keyword) ::
          {:ok, Jirex.VersionIssueCounts.t()} | :error
  def get_version_related_issues(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.ProjectVersions, :get_version_related_issues},
      url: "/rest/api/2/version/#{id}/relatedIssueCounts",
      method: :get,
      response: [{200, {Jirex.VersionIssueCounts, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get version's unresolved issues count

  Returns counts of the issues and unresolved issues for the project version.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* project permission for the project that contains the version.
  """
  @spec get_version_unresolved_issues(String.t(), keyword) ::
          {:ok, Jirex.VersionUnresolvedIssuesCount.t()} | :error
  def get_version_unresolved_issues(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.ProjectVersions, :get_version_unresolved_issues},
      url: "/rest/api/2/version/#{id}/unresolvedIssueCount",
      method: :get,
      response: [{200, {Jirex.VersionUnresolvedIssuesCount, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Merge versions

  Merges two project versions. The merge is completed by deleting the version specified in `id` and replacing any occurrences of its ID in `fixVersion` with the version ID specified in `moveIssuesTo`.

  Consider using [ Delete and replace version](#api-rest-api-2-version-id-removeAndSwap-post) instead. This resource supports swapping version values in `fixVersion`, `affectedVersion`, and custom fields.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that contains the version.
  """
  @spec merge_versions(String.t(), String.t(), keyword) :: {:ok, map} | :error
  def merge_versions(id, moveIssuesTo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, moveIssuesTo: moveIssuesTo],
      call: {Jirex.ProjectVersions, :merge_versions},
      url: "/rest/api/2/version/#{id}/mergeto/#{moveIssuesTo}",
      method: :put,
      response: [{204, :map}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Move version

  Modifies the version's sequence within the project, which affects the display order of the versions in Jira.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* project permission for the project that contains the version.
  """
  @spec move_version(String.t(), Jirex.VersionMoveBean.t(), keyword) ::
          {:ok, Jirex.Version.t()} | :error
  def move_version(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.ProjectVersions, :move_version},
      url: "/rest/api/2/version/#{id}/move",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.VersionMoveBean, :t}}],
      response: [{200, {Jirex.Version, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update related work

  Updates the given related work. You can only update generic link related works via Rest APIs. Any archived version related works can't be edited.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Resolve issues:* and *Edit issues* [Managing project permissions](https://confluence.atlassian.com/adminjiraserver/managing-project-permissions-938847145.html) for the project that contains the version.
  """
  @spec update_related_work(String.t(), Jirex.VersionRelatedWork.t(), keyword) ::
          {:ok, Jirex.VersionRelatedWork.t()} | :error
  def update_related_work(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.ProjectVersions, :update_related_work},
      url: "/rest/api/2/version/#{id}/relatedwork",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.VersionRelatedWork, :t}}],
      response: [
        {200, {Jirex.VersionRelatedWork, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update version

  Updates a project version.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that contains the version.
  """
  @spec update_version(String.t(), Jirex.Version.t(), keyword) ::
          {:ok, Jirex.Version.t()} | :error
  def update_version(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.ProjectVersions, :update_version},
      url: "/rest/api/2/version/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.Version, :t}}],
      response: [{200, {Jirex.Version, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
