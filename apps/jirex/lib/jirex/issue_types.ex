defmodule Jirex.IssueTypes do
  @moduledoc """
  Provides API endpoints related to issue types
  """

  @default_client Jirex.Client

  @doc """
  Create issue type

  Creates an issue type and adds it to the default issue type scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_issue_type(Jirex.IssueTypeCreateBean.t(), keyword) ::
          {:ok, Jirex.IssueTypeDetails.t()} | :error
  def create_issue_type(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueTypes, :create_issue_type},
      url: "/rest/api/2/issuetype",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssueTypeCreateBean, :t}}],
      response: [
        {201, {Jirex.IssueTypeDetails, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Load issue type avatar

  Loads an avatar for the issue type.

  Specify the avatar's local file location in the body of the request. Also, include the following headers:

   *  `X-Atlassian-Token: no-check` To prevent XSRF protection blocking the request, for more information see [Special Headers](#special-request-headers).
   *  `Content-Type: image/image type` Valid image types are JPEG, GIF, or PNG.

  For example:
  `curl --request POST \ --user email@example.com:<api_token> \ --header 'X-Atlassian-Token: no-check' \ --header 'Content-Type: image/< image_type>' \ --data-binary "<@/path/to/file/with/your/avatar>" \ --url 'https://your-domain.atlassian.net/rest/api/2/issuetype/{issueTypeId}'This`

  The avatar is cropped to a square. If no crop parameters are specified, the square originates at the top left of the image. The length of the square's sides is set to the smaller of the height or width of the image.

  The cropped image is then used to create avatars of 16x16, 24x24, 32x32, and 48x48 in size.

  After creating the avatar, use [ Update issue type](#api-rest-api-2-issuetype-id-put) to set it as the issue type's displayed avatar.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `x`: The X coordinate of the top-left corner of the crop region.
    * `y`: The Y coordinate of the top-left corner of the crop region.
    * `size`: The length of each side of the crop region.

  """
  @spec create_issue_type_avatar(String.t(), map, keyword) :: {:ok, Jirex.Avatar.t()} | :error
  def create_issue_type_avatar(id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:size, :x, :y])

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.IssueTypes, :create_issue_type_avatar},
      url: "/rest/api/2/issuetype/#{id}/avatar2",
      body: body,
      method: :post,
      query: query,
      request: [{"*/*", :map}],
      response: [
        {201, {Jirex.Avatar, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete issue type

  Deletes the issue type. If the issue type is in use, all uses are updated with the alternative issue type (`alternativeIssueTypeId`). A list of alternative issue types are obtained from the [Get alternative issue types](#api-rest-api-2-issuetype-id-alternatives-get) resource.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `alternativeIssueTypeId`: The ID of the replacement issue type.

  """
  @spec delete_issue_type(String.t(), keyword) :: :ok | :error
  def delete_issue_type(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:alternativeIssueTypeId])

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueTypes, :delete_issue_type},
      url: "/rest/api/2/issuetype/#{id}",
      method: :delete,
      query: query,
      response: [
        {204, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get alternative issue types

  Returns a list of issue types that can be used to replace the issue type. The alternative issue types are those assigned to the same workflow scheme, field configuration scheme, and screen scheme.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_alternative_issue_types(String.t(), keyword) ::
          {:ok, [Jirex.IssueTypeDetails.t()]} | :error
  def get_alternative_issue_types(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueTypes, :get_alternative_issue_types},
      url: "/rest/api/2/issuetype/#{id}/alternatives",
      method: :get,
      response: [{200, [{Jirex.IssueTypeDetails, :t}]}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get all issue types for user

  Returns all issue types.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Issue types are only returned as follows:

   *  if the user has the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), all issue types are returned.
   *  if the user has the *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for one or more projects, the issue types associated with the projects the user has permission to browse are returned.
  """
  @spec get_issue_all_types(keyword) :: {:ok, [Jirex.IssueTypeDetails.t()]} | :error
  def get_issue_all_types(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.IssueTypes, :get_issue_all_types},
      url: "/rest/api/2/issuetype",
      method: :get,
      response: [{200, [{Jirex.IssueTypeDetails, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue type

  Returns an issue type.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) in a project the issue type is associated with or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_issue_type(String.t(), keyword) :: {:ok, Jirex.IssueTypeDetails.t()} | :error
  def get_issue_type(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueTypes, :get_issue_type},
      url: "/rest/api/2/issuetype/#{id}",
      method: :get,
      response: [{200, {Jirex.IssueTypeDetails, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue types for project

  Returns issue types for a project.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) in the relevant project or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `projectId`: The ID of the project.
    * `level`: The level of the issue type to filter by. Use:

       *  `-1` for Subtask.
       *  `0` for Base.
       *  `1` for Epic.

  """
  @spec get_issue_types_for_project(keyword) :: {:ok, [Jirex.IssueTypeDetails.t()]} | :error
  def get_issue_types_for_project(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:level, :projectId])

    client.request(%{
      args: [],
      call: {Jirex.IssueTypes, :get_issue_types_for_project},
      url: "/rest/api/2/issuetype/project",
      method: :get,
      query: query,
      response: [{200, [{Jirex.IssueTypeDetails, :t}]}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update issue type

  Updates the issue type.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_issue_type(String.t(), Jirex.IssueTypeUpdateBean.t(), keyword) ::
          {:ok, Jirex.IssueTypeDetails.t()} | :error
  def update_issue_type(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.IssueTypes, :update_issue_type},
      url: "/rest/api/2/issuetype/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.IssueTypeUpdateBean, :t}}],
      response: [
        {200, {Jirex.IssueTypeDetails, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {409, :null}
      ],
      opts: opts
    })
  end
end
