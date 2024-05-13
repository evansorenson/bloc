defmodule Jira.ProjectClassificationLevels do
  @moduledoc """
  Provides API endpoints related to project classification levels
  """

  @default_client Jira.Client

  @doc """
  Get the default data classification level of a project

  Returns the default data classification for a project.

  **[Permissions](#permissions) required:**

   *  *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_default_project_classification(String.t(), keyword) :: {:ok, map} | :error
  def get_default_project_classification(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.ProjectClassificationLevels, :get_default_project_classification},
      url: "/rest/api/2/project/#{projectIdOrKey}/classification-level/default",
      method: :get,
      response: [{200, :map}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Remove the default data classification level from a project

  Remove the default data classification level for a project.

  **[Permissions](#permissions) required:**

   *  *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec remove_default_project_classification(String.t(), keyword) :: {:ok, map} | :error
  def remove_default_project_classification(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.ProjectClassificationLevels, :remove_default_project_classification},
      url: "/rest/api/2/project/#{projectIdOrKey}/classification-level/default",
      method: :delete,
      response: [{204, :map}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update the default data classification level of a project

  Updates the default data classification level for a project.

  **[Permissions](#permissions) required:**

   *  *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.
   *  *Administer jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_default_project_classification(
          String.t(),
          Jira.UpdateDefaultProjectClassificationBean.t(),
          keyword
        ) :: {:ok, map} | :error
  def update_default_project_classification(projectIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, body: body],
      call: {Jira.ProjectClassificationLevels, :update_default_project_classification},
      url: "/rest/api/2/project/#{projectIdOrKey}/classification-level/default",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.UpdateDefaultProjectClassificationBean, :t}}],
      response: [{204, :map}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
