defmodule Jira.ProjectAvatars do
  @moduledoc """
  Provides API endpoints related to project avatars
  """

  @default_client Jira.Client

  @doc """
  Load project avatar

  Loads an avatar for a project.

  Specify the avatar's local file location in the body of the request. Also, include the following headers:

   *  `X-Atlassian-Token: no-check` To prevent XSRF protection blocking the request, for more information see [Special Headers](#special-request-headers).
   *  `Content-Type: image/image type` Valid image types are JPEG, GIF, or PNG.

  For example:  
  `curl --request POST `

  `--user email@example.com:<api_token> `

  `--header 'X-Atlassian-Token: no-check' `

  `--header 'Content-Type: image/< image_type>' `

  `--data-binary "<@/path/to/file/with/your/avatar>" `

  `--url 'https://your-domain.atlassian.net/rest/api/2/project/{projectIdOrKey}/avatar2'`

  The avatar is cropped to a square. If no crop parameters are specified, the square originates at the top left of the image. The length of the square's sides is set to the smaller of the height or width of the image.

  The cropped image is then used to create avatars of 16x16, 24x24, 32x32, and 48x48 in size.

  After creating the avatar use [Set project avatar](#api-rest-api-2-project-projectIdOrKey-avatar-put) to set it as the project's displayed avatar.

  **[Permissions](#permissions) required:** *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg).

  ## Options

    * `x`: The X coordinate of the top-left corner of the crop region.
    * `y`: The Y coordinate of the top-left corner of the crop region.
    * `size`: The length of each side of the crop region.

  """
  @spec create_project_avatar(String.t(), map, keyword) :: {:ok, Jira.Avatar.t()} | :error
  def create_project_avatar(projectIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:size, :x, :y])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, body: body],
      call: {Jira.ProjectAvatars, :create_project_avatar},
      url: "/rest/api/2/project/#{projectIdOrKey}/avatar2",
      body: body,
      method: :post,
      query: query,
      request: [{"*/*", :map}],
      response: [{201, {Jira.Avatar, :t}}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete project avatar

  Deletes a custom avatar from a project. Note that system avatars cannot be deleted.

  **[Permissions](#permissions) required:** *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg).
  """
  @spec delete_project_avatar(String.t(), integer, keyword) :: :ok | :error
  def delete_project_avatar(projectIdOrKey, id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, id: id],
      call: {Jira.ProjectAvatars, :delete_project_avatar},
      url: "/rest/api/2/project/#{projectIdOrKey}/avatar/#{id}",
      method: :delete,
      response: [{204, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get all project avatars

  Returns all project avatars, grouped by system and custom avatars.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
  """
  @spec get_all_project_avatars(String.t(), keyword) :: {:ok, map} | :error
  def get_all_project_avatars(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.ProjectAvatars, :get_all_project_avatars},
      url: "/rest/api/2/project/#{projectIdOrKey}/avatars",
      method: :get,
      response: [{200, {Jira.ProjectAvatars, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Set project avatar

  Sets the avatar displayed for a project.

  Use [Load project avatar](#api-rest-api-2-project-projectIdOrKey-avatar2-post) to store avatars against the project, before using this operation to set the displayed avatar.

  **[Permissions](#permissions) required:** *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg).
  """
  @spec update_project_avatar(String.t(), Jira.Avatar.t(), keyword) :: {:ok, map} | :error
  def update_project_avatar(projectIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, body: body],
      call: {Jira.ProjectAvatars, :update_project_avatar},
      url: "/rest/api/2/project/#{projectIdOrKey}/avatar",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.Avatar, :t}}],
      response: [{204, :map}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @type t :: %__MODULE__{custom: [Jira.Avatar.t()] | nil, system: [Jira.Avatar.t()] | nil}

  defstruct [:custom, :system]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [custom: [{Jira.Avatar, :t}], system: [{Jira.Avatar, :t}]]
  end
end
