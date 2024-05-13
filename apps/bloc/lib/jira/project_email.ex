defmodule Jira.ProjectEmail do
  @moduledoc """
  Provides API endpoints related to project email
  """

  @default_client Jira.Client

  @doc """
  Get project's sender email

  Returns the [project's sender email address](https://confluence.atlassian.com/x/dolKLg).

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
  """
  @spec get_project_email(integer, keyword) :: {:ok, Jira.ProjectEmailAddress.t()} | :error
  def get_project_email(projectId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectId: projectId],
      call: {Jira.ProjectEmail, :get_project_email},
      url: "/rest/api/2/project/#{projectId}/email",
      method: :get,
      response: [{200, {Jira.ProjectEmailAddress, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Set project's sender email

  Sets the [project's sender email address](https://confluence.atlassian.com/x/dolKLg).

  If `emailAddress` is an empty string, the default email address is restored.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer Projects* [project permission.](https://confluence.atlassian.com/x/yodKLg)
  """
  @spec update_project_email(integer, Jira.ProjectEmailAddress.t(), keyword) ::
          {:ok, map} | :error
  def update_project_email(projectId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectId: projectId, body: body],
      call: {Jira.ProjectEmail, :update_project_email},
      url: "/rest/api/2/project/#{projectId}/email",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.ProjectEmailAddress, :t}}],
      response: [{204, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
