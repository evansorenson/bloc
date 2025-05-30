defmodule Jirex.JiraExpressions do
  @moduledoc """
  Provides API endpoints related to jira expressions
  """

  @default_client Jirex.Client

  @doc """
  Analyse Jira expression

  Analyses and validates Jira expressions.

  As an experimental feature, this operation can also attempt to type-check the expressions.

  Learn more about Jira expressions in the [documentation](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/).

  **[Permissions](#permissions) required**: None.

  ## Options

    * `check`: The check to perform:

       *  `syntax` Each expression's syntax is checked to ensure the expression can be parsed. Also, syntactic limits are validated. For example, the expression's length.
       *  `type` EXPERIMENTAL. Each expression is type checked and the final type of the expression inferred. Any type errors that would result in the expression failure at runtime are reported. For example, accessing properties that don't exist or passing the wrong number of arguments to functions. Also performs the syntax check.
       *  `complexity` EXPERIMENTAL. Determines the formulae for how many [expensive operations](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/#expensive-operations) each expression may execute.

  """
  @spec analyse_expression(Jirex.JiraExpressionForAnalysis.t(), keyword) ::
          {:ok, Jirex.JiraExpressionsAnalysis.t()} | {:error, Jirex.ErrorCollection.t()}
  def analyse_expression(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:check])

    client.request(%{
      args: [body: body],
      call: {Jirex.JiraExpressions, :analyse_expression},
      url: "/rest/api/2/expression/analyse",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.JiraExpressionForAnalysis, :t}}],
      response: [
        {200, {Jirex.JiraExpressionsAnalysis, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, :null},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Evaluate Jira expression

  Evaluates a Jira expression and returns its value.

  This resource can be used to test Jira expressions that you plan to use elsewhere, or to fetch data in a flexible way. Consult the [Jira expressions documentation](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/) for more details.

  #### Context variables ####

  The following context variables are available to Jira expressions evaluated by this resource. Their presence depends on various factors; usually you need to manually request them in the context object sent in the payload, but some of them are added automatically under certain conditions.

   *  `user` ([User](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#user)): The current user. Always available and equal to `null` if the request is anonymous.
   *  `app` ([App](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#app)): The [Connect app](https://developer.atlassian.com/cloud/jira/platform/index/#connect-apps) that made the request. Available only for authenticated requests made by Connect Apps (read more here: [Authentication for Connect apps](https://developer.atlassian.com/cloud/jira/platform/security-for-connect-apps/)).
   *  `issue` ([Issue](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#issue)): The current issue. Available only when the issue is provided in the request context object.
   *  `issues` ([List](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#list) of [Issues](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#issue)): A collection of issues matching a JQL query. Available only when JQL is provided in the request context object.
   *  `project` ([Project](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#project)): The current project. Available only when the project is provided in the request context object.
   *  `sprint` ([Sprint](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#sprint)): The current sprint. Available only when the sprint is provided in the request context object.
   *  `board` ([Board](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#board)): The current board. Available only when the board is provided in the request context object.
   *  `serviceDesk` ([ServiceDesk](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#servicedesk)): The current service desk. Available only when the service desk is provided in the request context object.
   *  `customerRequest` ([CustomerRequest](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#customerrequest)): The current customer request. Available only when the customer request is provided in the request context object.

  Also, custom context variables can be passed in the request with their types. Those variables can be accessed by key in the Jira expression. These variable types are available for use in a custom context:

   *  `user`: A [user](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#user) specified as an Atlassian account ID.
   *  `issue`: An [issue](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference#issue) specified by ID or key. All the fields of the issue object are available in the Jira expression.
   *  `json`: A JSON object containing custom content.
   *  `list`: A JSON list of `user`, `issue`, or `json` variable types.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required**: None. However, an expression may return different results for different users depending on their permissions. For example, different users may see different comments on the same issue.
  Permission to access Jira Software is required to access Jira Software context variables (`board` and `sprint`) or fields (for example, `issue.sprint`).

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts `meta.complexity` that returns information about the expression complexity. For example, the number of expensive operations used by the expression and how close the expression is to reaching the [complexity limit](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/#restrictions). Useful when designing and debugging your expressions.

  """
  @spec evaluate_jira_expression(Jirex.JiraExpressionEvalRequestBean.t(), keyword) ::
          {:ok, Jirex.JiraExpressionResult.t()} | {:error, Jirex.ErrorCollection.t()}
  def evaluate_jira_expression(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [body: body],
      call: {Jirex.JiraExpressions, :evaluate_jira_expression},
      url: "/rest/api/2/expression/eval",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.JiraExpressionEvalRequestBean, :t}}],
      response: [
        {200, {Jirex.JiraExpressionResult, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, :null},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
