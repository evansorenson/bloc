defmodule Jirex.UserProperties do
  @moduledoc """
  Provides API endpoints related to user properties
  """

  @default_client Jirex.Client

  @doc """
  Delete user property

  Deletes a property from a user.

  Note: This operation does not access the [user properties](https://confluence.atlassian.com/x/8YxjL) created and maintained in Jira.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), to delete a property from any user.
   *  Access to Jira, to delete a property from the calling user's record.

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `userKey`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `username`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec delete_user_property(String.t(), keyword) :: :ok | :error
  def delete_user_property(propertyKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :userKey, :username])

    client.request(%{
      args: [propertyKey: propertyKey],
      call: {Jirex.UserProperties, :delete_user_property},
      url: "/rest/api/2/user/properties/#{propertyKey}",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get user property

  Returns the value of a user's property. If no property key is provided [Get user property keys](#api-rest-api-2-user-properties-get) is called.

  Note: This operation does not access the [user properties](https://confluence.atlassian.com/x/8YxjL) created and maintained in Jira.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), to get a property from any user.
   *  Access to Jira, to get a property from the calling user's record.

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `userKey`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `username`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec get_user_property(String.t(), keyword) :: {:ok, Jirex.EntityProperty.t()} | :error
  def get_user_property(propertyKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :userKey, :username])

    client.request(%{
      args: [propertyKey: propertyKey],
      call: {Jirex.UserProperties, :get_user_property},
      url: "/rest/api/2/user/properties/#{propertyKey}",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.EntityProperty, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get user property keys

  Returns the keys of all properties for a user.

  Note: This operation does not access the [user properties](https://confluence.atlassian.com/x/8YxjL) created and maintained in Jira.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), to access the property keys on any user.
   *  Access to Jira, to access the calling user's property keys.

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `userKey`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `username`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec get_user_property_keys(keyword) :: {:ok, Jirex.PropertyKeys.t()} | :error
  def get_user_property_keys(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :userKey, :username])

    client.request(%{
      args: [],
      call: {Jirex.UserProperties, :get_user_property_keys},
      url: "/rest/api/2/user/properties",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PropertyKeys, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Set user property

  Sets the value of a user's property. Use this resource to store custom data against a user.

  Note: This operation does not access the [user properties](https://confluence.atlassian.com/x/8YxjL) created and maintained in Jira.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), to set a property on any user.
   *  Access to Jira, to set a property on the calling user's record.

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `userKey`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `username`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec set_user_property(String.t(), map, keyword) :: {:ok, map} | :error
  def set_user_property(propertyKey, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :userKey, :username])

    client.request(%{
      args: [propertyKey: propertyKey, body: body],
      call: {Jirex.UserProperties, :set_user_property},
      url: "/rest/api/2/user/properties/#{propertyKey}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {201, :map},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {405, :null}
      ],
      opts: opts
    })
  end
end
