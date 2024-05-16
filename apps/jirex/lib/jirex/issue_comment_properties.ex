defmodule Jirex.IssueCommentProperties do
  @moduledoc """
  Provides API endpoints related to issue comment properties
  """

  @default_client Jirex.Client

  @doc """
  Delete comment property

  Deletes a comment property.

  **[Permissions](#permissions) required:** either of:

   *  *Edit All Comments* [project permission](https://confluence.atlassian.com/x/yodKLg) to delete a property from any comment.
   *  *Edit Own Comments* [project permission](https://confluence.atlassian.com/x/yodKLg) to delete a property from a comment created by the user.

  Also, when the visibility of a comment is restricted to a role or group the user must be a member of that role or group.
  """
  @spec delete_comment_property(String.t(), String.t(), keyword) :: :ok | :error
  def delete_comment_property(commentId, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [commentId: commentId, propertyKey: propertyKey],
      call: {Jirex.IssueCommentProperties, :delete_comment_property},
      url: "/rest/api/2/comment/#{commentId}/properties/#{propertyKey}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get comment property

  Returns the value of a comment property.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the comment has visibility restrictions, belongs to the group or has the role visibility is restricted to.
  """
  @spec get_comment_property(String.t(), String.t(), keyword) ::
          {:ok, Jirex.EntityProperty.t()} | :error
  def get_comment_property(commentId, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [commentId: commentId, propertyKey: propertyKey],
      call: {Jirex.IssueCommentProperties, :get_comment_property},
      url: "/rest/api/2/comment/#{commentId}/properties/#{propertyKey}",
      method: :get,
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
  Get comment property keys

  Returns the keys of all the properties of a comment.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the comment has visibility restrictions, belongs to the group or has the role visibility is restricted to.
  """
  @spec get_comment_property_keys(String.t(), keyword) :: {:ok, Jirex.PropertyKeys.t()} | :error
  def get_comment_property_keys(commentId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [commentId: commentId],
      call: {Jirex.IssueCommentProperties, :get_comment_property_keys},
      url: "/rest/api/2/comment/#{commentId}/properties",
      method: :get,
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
  Set comment property

  Creates or updates the value of a property for a comment. Use this resource to store custom data against a comment.

  The value of the request body must be a [valid](http://tools.ietf.org/html/rfc4627), non-empty JSON blob. The maximum length is 32768 characters.

  **[Permissions](#permissions) required:** either of:

   *  *Edit All Comments* [project permission](https://confluence.atlassian.com/x/yodKLg) to create or update the value of a property on any comment.
   *  *Edit Own Comments* [project permission](https://confluence.atlassian.com/x/yodKLg) to create or update the value of a property on a comment created by the user.

  Also, when the visibility of a comment is restricted to a role or group the user must be a member of that role or group.
  """
  @spec set_comment_property(String.t(), String.t(), map, keyword) :: {:ok, map} | :error
  def set_comment_property(commentId, propertyKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [commentId: commentId, propertyKey: propertyKey, body: body],
      call: {Jirex.IssueCommentProperties, :set_comment_property},
      url: "/rest/api/2/comment/#{commentId}/properties/#{propertyKey}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {201, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
