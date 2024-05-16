defmodule Jirex.Tasks do
  @moduledoc """
  Provides API endpoints related to tasks
  """

  @default_client Jirex.Client

  @doc """
  Cancel task

  Cancels a task.

  **[Permissions](#permissions) required:** either of:

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
   *  Creator of the task.
  """
  @spec cancel_task(String.t(), keyword) :: {:ok, map} | {:error, [String.t()]}
  def cancel_task(taskId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [taskId: taskId],
      call: {Jirex.Tasks, :cancel_task},
      url: "/rest/api/2/task/#{taskId}/cancel",
      method: :post,
      response: [
        {202, :map},
        {400, [string: :generic]},
        {401, [string: :generic]},
        {403, [string: :generic]},
        {404, [string: :generic]}
      ],
      opts: opts
    })
  end

  @doc """
  Get task

  Returns the status of a [long-running asynchronous task](#async).

  When a task has finished, this operation returns the JSON blob applicable to the task. See the documentation of the operation that created the task for details. Task details are not permanently retained. As of September 2019, details are retained for 14 days although this period may change without notice.

  **Deprecation notice:** The required OAuth 2.0 scopes will be updated on June 15, 2024.

   *  `read:jira-work`

  **[Permissions](#permissions) required:** either of:

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
   *  Creator of the task.
  """
  @spec get_task(String.t(), keyword) :: {:ok, Jirex.TaskProgressBeanObject.t()} | :error
  def get_task(taskId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [taskId: taskId],
      call: {Jirex.Tasks, :get_task},
      url: "/rest/api/2/task/#{taskId}",
      method: :get,
      response: [
        {200, {Jirex.TaskProgressBeanObject, :t}},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end
end
