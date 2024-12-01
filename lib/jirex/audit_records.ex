defmodule Jirex.AuditRecords do
  @moduledoc """
  Provides API endpoint related to audit records
  """

  @default_client Jirex.Client

  @doc """
  Get audit records

  Returns a list of audit records. The list can be filtered to include items:

   *  where each item in `filter` has at least one match in any of these fields:

       *  `summary`
       *  `category`
       *  `eventSource`
       *  `objectItem.name` If the object is a user, account ID is available to filter.
       *  `objectItem.parentName`
       *  `objectItem.typeName`
       *  `changedValues.changedFrom`
       *  `changedValues.changedTo`
       *  `remoteAddress`

      For example, if `filter` contains *man ed*, an audit record containing `summary": "User added to group"` and `"category": "group management"` is returned.
   *  created on or after a date and time.
   *  created or or before a date and time.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `offset`: The number of records to skip before returning the first result.
    * `limit`: The maximum number of results to return.
    * `filter`: The strings to match with audit field content, space separated.
    * `from`: The date and time on or after which returned audit records must have been created. If `to` is provided `from` must be before `to` or no audit records are returned.
    * `to`: The date and time on or before which returned audit results must have been created. If `from` is provided `to` must be after `from` or no audit records are returned.

  """
  @spec get_audit_records(keyword) :: {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def get_audit_records(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter, :from, :limit, :offset, :to])

    client.request(%{
      args: [],
      call: {Jirex.AuditRecords, :get_audit_records},
      url: "/rest/api/2/auditing/record",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.AuditRecords, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @type t :: %__MODULE__{
          limit: integer | nil,
          offset: integer | nil,
          records: [Jirex.AuditRecordBean.t()] | nil,
          total: integer | nil
        }

  defstruct [:limit, :offset, :records, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [limit: :integer, offset: :integer, records: [{Jirex.AuditRecordBean, :t}], total: :integer]
  end
end
