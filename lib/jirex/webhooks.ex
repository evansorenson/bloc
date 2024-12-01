defmodule Jirex.Webhooks do
  @moduledoc """
  Provides API endpoints related to webhooks
  """

  @default_client Jirex.Client

  @doc """
  Delete webhooks by ID

  Removes webhooks by ID. Only webhooks registered by the calling app are removed. If webhooks created by other apps are specified, they are ignored.

  **[Permissions](#permissions) required:** Only [Connect](https://developer.atlassian.com/cloud/jira/platform/#connect-apps) and [OAuth 2.0](https://developer.atlassian.com/cloud/jira/platform/oauth-2-3lo-apps) apps can use this operation.
  """
  @spec delete_webhook_by_id(Jirex.ContainerForWebhookIDs.t(), keyword) ::
          :ok | {:error, Jirex.ErrorCollection.t()}
  def delete_webhook_by_id(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Webhooks, :delete_webhook_by_id},
      url: "/rest/api/2/webhook",
      body: body,
      method: :delete,
      request: [{"application/json", {Jirex.ContainerForWebhookIDs, :t}}],
      response: [
        {202, :null},
        {400, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get dynamic webhooks for app

  Returns a [paginated](#pagination) list of the webhooks registered by the calling app.

  **[Permissions](#permissions) required:** Only [Connect](https://developer.atlassian.com/cloud/jira/platform/#connect-apps) and [OAuth 2.0](https://developer.atlassian.com/cloud/jira/platform/oauth-2-3lo-apps) apps can use this operation.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_dynamic_webhooks_for_app(keyword) ::
          {:ok, Jirex.PageBeanWebhook.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_dynamic_webhooks_for_app(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.Webhooks, :get_dynamic_webhooks_for_app},
      url: "/rest/api/2/webhook",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanWebhook, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get failed webhooks

  Returns webhooks that have recently failed to be delivered to the requesting app after the maximum number of retries.

  After 72 hours the failure may no longer be returned by this operation.

  The oldest failure is returned first.

  This method uses a cursor-based pagination. To request the next page use the failure time of the last webhook on the list as the `failedAfter` value or use the URL provided in `next`.

  **[Permissions](#permissions) required:** Only [Connect apps](https://developer.atlassian.com/cloud/jira/platform/index/#connect-apps) can use this operation.

  ## Options

    * `maxResults`: The maximum number of webhooks to return per page. If obeying the maxResults directive would result in records with the same failure time being split across pages, the directive is ignored and all records with the same failure time included on the page.
    * `after`: The time after which any webhook failure must have occurred for the record to be returned, expressed as milliseconds since the UNIX epoch.

  """
  @spec get_failed_webhooks(keyword) ::
          {:ok, Jirex.FailedWebhooks.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_failed_webhooks(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:after, :maxResults])

    client.request(%{
      args: [],
      call: {Jirex.Webhooks, :get_failed_webhooks},
      url: "/rest/api/2/webhook/failed",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.FailedWebhooks, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Extend webhook life

  Extends the life of webhook. Webhooks registered through the REST API expire after 30 days. Call this operation to keep them alive.

  Unrecognized webhook IDs (those that are not found or belong to other apps) are ignored.

  **[Permissions](#permissions) required:** Only [Connect](https://developer.atlassian.com/cloud/jira/platform/#connect-apps) and [OAuth 2.0](https://developer.atlassian.com/cloud/jira/platform/oauth-2-3lo-apps) apps can use this operation.
  """
  @spec refresh_webhooks(Jirex.ContainerForWebhookIDs.t(), keyword) ::
          {:ok, Jirex.WebhooksExpirationDate.t()} | {:error, Jirex.ErrorCollection.t()}
  def refresh_webhooks(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Webhooks, :refresh_webhooks},
      url: "/rest/api/2/webhook/refresh",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.ContainerForWebhookIDs, :t}}],
      response: [
        {200, {Jirex.WebhooksExpirationDate, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Register dynamic webhooks

  Registers webhooks.

  **NOTE:** for non-public OAuth apps, webhooks are delivered only if there is a match between the app owner and the user who registered a dynamic webhook.

  **[Permissions](#permissions) required:** Only [Connect](https://developer.atlassian.com/cloud/jira/platform/#connect-apps) and [OAuth 2.0](https://developer.atlassian.com/cloud/jira/platform/oauth-2-3lo-apps) apps can use this operation.
  """
  @spec register_dynamic_webhooks(Jirex.WebhookRegistrationDetails.t(), keyword) ::
          {:ok, Jirex.ContainerForRegisteredWebhooks.t()} | {:error, Jirex.ErrorCollection.t()}
  def register_dynamic_webhooks(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Webhooks, :register_dynamic_webhooks},
      url: "/rest/api/2/webhook",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.WebhookRegistrationDetails, :t}}],
      response: [
        {200, {Jirex.ContainerForRegisteredWebhooks, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
