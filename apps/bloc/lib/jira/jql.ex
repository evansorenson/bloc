defmodule Jira.JQL do
  @moduledoc """
  Provides API endpoints related to jql
  """

  @default_client Jira.Client

  @doc """
  Get field reference data (GET)

  Returns reference data for JQL searches. This is a downloadable version of the documentation provided in [Advanced searching - fields reference](https://confluence.atlassian.com/x/gwORLQ) and [Advanced searching - functions reference](https://confluence.atlassian.com/x/hgORLQ), along with a list of JQL-reserved words. Use this information to assist with the programmatic creation of JQL queries or the validation of queries built in a custom query builder.

  To filter visible field details by project or collapse non-unique fields by field type then [Get field reference data (POST)](#api-rest-api-2-jql-autocompletedata-post) can be used.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_auto_complete(keyword) :: {:ok, Jira.JQLReferenceData.t()} | :error
  def get_auto_complete(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.JQL, :get_auto_complete},
      url: "/rest/api/2/jql/autocompletedata",
      method: :get,
      response: [{200, {Jira.JQLReferenceData, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get field reference data (POST)

  Returns reference data for JQL searches. This is a downloadable version of the documentation provided in [Advanced searching - fields reference](https://confluence.atlassian.com/x/gwORLQ) and [Advanced searching - functions reference](https://confluence.atlassian.com/x/hgORLQ), along with a list of JQL-reserved words. Use this information to assist with the programmatic creation of JQL queries or the validation of queries built in a custom query builder.

  This operation can filter the custom fields returned by project. Invalid project IDs in `projectIds` are ignored. System fields are always returned.

  It can also return the collapsed field for custom fields. Collapsed fields enable searches to be performed across all fields with the same name and of the same field type. For example, the collapsed field `Component - Component[Dropdown]` enables dropdown fields `Component - cf[10061]` and `Component - cf[10062]` to be searched simultaneously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_auto_complete_post(Jira.SearchAutoCompleteFilter.t(), keyword) ::
          {:ok, Jira.JQLReferenceData.t()} | :error
  def get_auto_complete_post(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.JQL, :get_auto_complete_post},
      url: "/rest/api/2/jql/autocompletedata",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.SearchAutoCompleteFilter, :t}}],
      response: [{200, {Jira.JQLReferenceData, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get field auto complete suggestions

  Returns the JQL search auto complete suggestions for a field.

  Suggestions can be obtained by providing:

   *  `fieldName` to get a list of all values for the field.
   *  `fieldName` and `fieldValue` to get a list of values containing the text in `fieldValue`.
   *  `fieldName` and `predicateName` to get a list of all predicate values for the field.
   *  `fieldName`, `predicateName`, and `predicateValue` to get a list of predicate values containing the text in `predicateValue`.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `fieldName`: The name of the field.
    * `fieldValue`: The partial field item name entered by the user.
    * `predicateName`: The name of the [ CHANGED operator predicate](https://confluence.atlassian.com/x/hQORLQ#Advancedsearching-operatorsreference-CHANGEDCHANGED) for which the suggestions are generated. The valid predicate operators are *by*, *from*, and *to*.
    * `predicateValue`: The partial predicate item name entered by the user.

  """
  @spec get_field_auto_complete_for_query_string(keyword) ::
          {:ok, Jira.AutoCompleteSuggestions.t()} | :error
  def get_field_auto_complete_for_query_string(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:fieldName, :fieldValue, :predicateName, :predicateValue])

    client.request(%{
      args: [],
      call: {Jira.JQL, :get_field_auto_complete_for_query_string},
      url: "/rest/api/2/jql/autocompletedata/suggestions",
      method: :get,
      query: query,
      response: [{200, {Jira.AutoCompleteSuggestions, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Convert user identifiers to account IDs in JQL queries

  Converts one or more JQL queries with user identifiers (username or user key) to equivalent JQL queries with account IDs.

  You may wish to use this operation if your system stores JQL queries and you want to make them GDPR-compliant. For more information about GDPR-related changes, see the [migration guide](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/).

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec migrate_queries(Jira.JQLPersonalDataMigrationRequest.t(), keyword) ::
          {:ok, Jira.ConvertedJQLQueries.t()} | {:error, String.t()}
  def migrate_queries(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.JQL, :migrate_queries},
      url: "/rest/api/2/jql/pdcleaner",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.JQLPersonalDataMigrationRequest, :t}}],
      response: [
        {200, {Jira.ConvertedJQLQueries, :t}},
        {400, {:string, :generic}},
        {401, {:string, :generic}}
      ],
      opts: opts
    })
  end

  @doc """
  Parse JQL query

  Parses and validates JQL queries.

  Validation is performed in context of the current user.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `validation`: How to validate the JQL query and treat the validation results. Validation options include:
      
       *  `strict` Returns all errors. If validation fails, the query structure is not returned.
       *  `warn` Returns all errors. If validation fails but the JQL query is correctly formed, the query structure is returned.
       *  `none` No validation is performed. If JQL query is correctly formed, the query structure is returned.

  """
  @spec parse_jql_queries(Jira.JqlQueriesToParse.t(), keyword) ::
          {:ok, Jira.ParsedJqlQueries.t()} | {:error, Jira.ErrorCollection.t()}
  def parse_jql_queries(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:validation])

    client.request(%{
      args: [body: body],
      call: {Jira.JQL, :parse_jql_queries},
      url: "/rest/api/2/jql/parse",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.JqlQueriesToParse, :t}}],
      response: [
        {200, {Jira.ParsedJqlQueries, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Sanitize JQL queries

  Sanitizes one or more JQL queries by converting readable details into IDs where a user doesn't have permission to view the entity.

  For example, if the query contains the clause *project = 'Secret project'*, and a user does not have browse permission for the project "Secret project", the sanitized query replaces the clause with *project = 12345"* (where 12345 is the ID of the project). If a user has the required permission, the clause is not sanitized. If the account ID is null, sanitizing is performed for an anonymous user.

  Note that sanitization doesn't make the queries GDPR-compliant, because it doesn't remove user identifiers (username or user key). If you need to make queries GDPR-compliant, use [Convert user identifiers to account IDs in JQL queries](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-jql/#api-rest-api-3-jql-sanitize-post).

  Before sanitization each JQL query is parsed. The queries are returned in the same order that they were passed.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec sanitise_jql_queries(Jira.JqlQueriesToSanitize.t(), keyword) ::
          {:ok, Jira.SanitizedJqlQueries.t()} | {:error, Jira.ErrorCollection.t()}
  def sanitise_jql_queries(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.JQL, :sanitise_jql_queries},
      url: "/rest/api/2/jql/sanitize",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.JqlQueriesToSanitize, :t}}],
      response: [
        {200, {Jira.SanitizedJqlQueries, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
