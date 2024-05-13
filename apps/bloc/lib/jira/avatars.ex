defmodule Jira.Avatars do
  @moduledoc """
  Provides API endpoints related to avatars
  """

  @default_client Jira.Client

  @doc """
  Delete avatar

  Deletes an avatar from a project or issue type.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_avatar(String.t(), String.t(), integer, keyword) :: :ok | :error
  def delete_avatar(type, owningObjectId, id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [type: type, owningObjectId: owningObjectId, id: id],
      call: {Jira.Avatars, :delete_avatar},
      url: "/rest/api/2/universal_avatar/type/#{type}/owner/#{owningObjectId}/avatar/#{id}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get system avatars by type

  Returns a list of system avatar details by owner type, where the owner types are issue type, project, or user.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_all_system_avatars(String.t(), keyword) :: {:ok, Jira.SystemAvatars.t()} | :error
  def get_all_system_avatars(type, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [type: type],
      call: {Jira.Avatars, :get_all_system_avatars},
      url: "/rest/api/2/avatar/#{type}/system",
      method: :get,
      response: [{200, {Jira.SystemAvatars, :t}}, {401, :null}, {500, :null}],
      opts: opts
    })
  end

  @doc """
  Get avatar image by ID

  Returns a project or issue type avatar image by ID.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  For system avatars, none.
   *  For custom project avatars, *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project the avatar belongs to.
   *  For custom issue type avatars, *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for at least one project the issue type is used in.

  ## Options

    * `size`: The size of the avatar image. If not provided the default size is returned.
    * `format`: The format to return the avatar image in. If not provided the original content format is returned.

  """
  @spec get_avatar_image_by_id(String.t(), integer, keyword) ::
          {:ok, any | Jira.StreamingResponseBody.t()} | {:error, any | Jira.ErrorCollection.t()}
  def get_avatar_image_by_id(type, id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:format, :size])

    client.request(%{
      args: [type: type, id: id],
      call: {Jira.Avatars, :get_avatar_image_by_id},
      url: "/rest/api/2/universal_avatar/view/type/#{type}/avatar/#{id}",
      method: :get,
      query: query,
      response: [
        {200, {:union, [:unknown, {Jira.StreamingResponseBody, :t}]}},
        {400, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {401, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {403, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {404, {:union, [:unknown, {Jira.ErrorCollection, :t}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Get avatar image by owner

  Returns the avatar image for a project or issue type.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  For system avatars, none.
   *  For custom project avatars, *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project the avatar belongs to.
   *  For custom issue type avatars, *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for at least one project the issue type is used in.

  ## Options

    * `size`: The size of the avatar image. If not provided the default size is returned.
    * `format`: The format to return the avatar image in. If not provided the original content format is returned.

  """
  @spec get_avatar_image_by_owner(String.t(), String.t(), keyword) ::
          {:ok, any | Jira.StreamingResponseBody.t()} | {:error, any | Jira.ErrorCollection.t()}
  def get_avatar_image_by_owner(type, entityId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:format, :size])

    client.request(%{
      args: [type: type, entityId: entityId],
      call: {Jira.Avatars, :get_avatar_image_by_owner},
      url: "/rest/api/2/universal_avatar/view/type/#{type}/owner/#{entityId}",
      method: :get,
      query: query,
      response: [
        {200, {:union, [:unknown, {Jira.StreamingResponseBody, :t}]}},
        {400, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {401, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {403, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {404, {:union, [:unknown, {Jira.ErrorCollection, :t}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Get avatar image by type

  Returns the default project or issue type avatar image.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `size`: The size of the avatar image. If not provided the default size is returned.
    * `format`: The format to return the avatar image in. If not provided the original content format is returned.

  """
  @spec get_avatar_image_by_type(String.t(), keyword) ::
          {:ok, any | Jira.StreamingResponseBody.t()} | {:error, any | Jira.ErrorCollection.t()}
  def get_avatar_image_by_type(type, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:format, :size])

    client.request(%{
      args: [type: type],
      call: {Jira.Avatars, :get_avatar_image_by_type},
      url: "/rest/api/2/universal_avatar/view/type/#{type}",
      method: :get,
      query: query,
      response: [
        {200, {:union, [:unknown, {Jira.StreamingResponseBody, :t}]}},
        {401, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {403, {:union, [:unknown, {Jira.ErrorCollection, :t}]}},
        {404, {:union, [:unknown, {Jira.ErrorCollection, :t}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Get avatars

  Returns the system and custom avatars for a project or issue type.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  for custom project avatars, *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project the avatar belongs to.
   *  for custom issue type avatars, *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for at least one project the issue type is used in.
   *  for system avatars, none.
  """
  @spec get_avatars(String.t(), String.t(), keyword) :: {:ok, map} | :error
  def get_avatars(type, entityId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [type: type, entityId: entityId],
      call: {Jira.Avatars, :get_avatars},
      url: "/rest/api/2/universal_avatar/type/#{type}/owner/#{entityId}",
      method: :get,
      response: [{200, {Jira.Avatars, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Load avatar

  Loads a custom avatar for a project or issue type.

  Specify the avatar's local file location in the body of the request. Also, include the following headers:

   *  `X-Atlassian-Token: no-check` To prevent XSRF protection blocking the request, for more information see [Special Headers](#special-request-headers).
   *  `Content-Type: image/image type` Valid image types are JPEG, GIF, or PNG.

  For example:  
  `curl --request POST `

  `--user email@example.com:<api_token> `

  `--header 'X-Atlassian-Token: no-check' `

  `--header 'Content-Type: image/< image_type>' `

  `--data-binary "<@/path/to/file/with/your/avatar>" `

  `--url 'https://your-domain.atlassian.net/rest/api/2/universal_avatar/type/{type}/owner/{entityId}'`

  The avatar is cropped to a square. If no crop parameters are specified, the square originates at the top left of the image. The length of the square's sides is set to the smaller of the height or width of the image.

  The cropped image is then used to create avatars of 16x16, 24x24, 32x32, and 48x48 in size.

  After creating the avatar use:

   *  [Update issue type](#api-rest-api-2-issuetype-id-put) to set it as the issue type's displayed avatar.
   *  [Set project avatar](#api-rest-api-2-project-projectIdOrKey-avatar-put) to set it as the project's displayed avatar.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `x`: The X coordinate of the top-left corner of the crop region.
    * `y`: The Y coordinate of the top-left corner of the crop region.
    * `size`: The length of each side of the crop region.

  """
  @spec store_avatar(String.t(), String.t(), map, keyword) :: {:ok, Jira.Avatar.t()} | :error
  def store_avatar(type, entityId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:size, :x, :y])

    client.request(%{
      args: [type: type, entityId: entityId, body: body],
      call: {Jira.Avatars, :store_avatar},
      url: "/rest/api/2/universal_avatar/type/#{type}/owner/#{entityId}",
      body: body,
      method: :post,
      query: query,
      request: [{"*/*", :map}],
      response: [{201, {Jira.Avatar, :t}}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
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
