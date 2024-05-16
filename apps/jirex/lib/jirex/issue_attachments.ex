defmodule Jirex.IssueAttachments do
  @moduledoc """
  Provides API endpoints related to issue attachments
  """

  @default_client Jirex.Client

  @doc """
  Add attachment

  Adds one or more attachments to an issue. Attachments are posted as multipart/form-data ([RFC 1867](https://www.ietf.org/rfc/rfc1867.txt)).

  Note that:

   *  The request must have a `X-Atlassian-Token: no-check` header, if not it is blocked. See [Special headers](#special-request-headers) for more information.
   *  The name of the multipart/form-data parameter that contains the attachments must be `file`.

  The following examples upload a file called *myfile.txt* to the issue *TEST-123*:

  #### curl ####

      curl --location --request POST 'https://your-domain.atlassian.net/rest/api/2/issue/TEST-123/attachments'
       -u 'email@example.com:<api_token>'
       -H 'X-Atlassian-Token: no-check'
       --form 'file=@"myfile.txt"'

  #### Node.js ####

      // This code sample uses the 'node-fetch' and 'form-data' libraries:
       // https://www.npmjs.com/package/node-fetch
       // https://www.npmjs.com/package/form-data
       const fetch = require('node-fetch');
       const FormData = require('form-data');
       const fs = require('fs');

       const filePath = 'myfile.txt';
       const form = new FormData();
       const stats = fs.statSync(filePath);
       const fileSizeInBytes = stats.size;
       const fileStream = fs.createReadStream(filePath);

       form.append('file', fileStream, {knownLength: fileSizeInBytes});

       fetch('https://your-domain.atlassian.net/rest/api/2/issue/TEST-123/attachments', {
           method: 'POST',
           body: form,
           headers: {
               'Authorization': `Basic ${Buffer.from(
                   'email@example.com:'
               ).toString('base64')}`,
               'Accept': 'application/json',
               'X-Atlassian-Token': 'no-check'
           }
       })
           .then(response => {
               console.log(
                   `Response: ${response.status} ${response.statusText}`
               );
               return response.text();
           })
           .then(text => console.log(text))
           .catch(err => console.error(err));

  #### Java ####

      // This code sample uses the  'Unirest' library:
       // http://unirest.io/java.html
       HttpResponse response = Unirest.post("https://your-domain.atlassian.net/rest/api/2/issue/{issueIdOrKey}/attachments")
               .basicAuth("email@example.com", "")
               .header("Accept", "application/json")
               .header("X-Atlassian-Token", "no-check")
               .field("file", new File("myfile.txt"))
               .asJson();

               System.out.println(response.getBody());

  #### Python ####

      # This code sample uses the 'requests' library:
       # http://docs.python-requests.org
       import requests
       from requests.auth import HTTPBasicAuth
       import json

       url = "https://your-domain.atlassian.net/rest/api/2/issue/{issueIdOrKey}/attachments"

       auth = HTTPBasicAuth("email@example.com", "")

       headers = {
          "Accept": "application/json",
          "X-Atlassian-Token": "no-check"
       }

       response = requests.request(%{
          "POST",
          url,
          headers = headers,
          auth = auth,
          files = {
               "file": ("myfile.txt", open("myfile.txt","rb"}), "application-type")
          }
       )

       print(json.dumps(json.loads(response.text), sort_keys=True, indent=4, separators=(",", ": ")))

  #### PHP ####

      // This code sample uses the 'Unirest' library:
       // http://unirest.io/php.html
       Unirest\Request::auth('email@example.com', '');

       $headers = array(
         'Accept' => 'application/json',
         'X-Atlassian-Token' => 'no-check'
       );

       $parameters = array(
         'file' => File::add('myfile.txt')
       );

       $response = Unirest\Request::post(
         'https://your-domain.atlassian.net/rest/api/2/issue/{issueIdOrKey}/attachments',
         $headers,
         $parameters
       );

       var_dump($response)

  #### Forge ####

      // This sample uses Atlassian Forge and the `form-data` library.
       // https://developer.atlassian.com/platform/forge/
       // https://www.npmjs.com/package/form-data
       import api from "@forge/api";
       import FormData from "form-data";

       const form = new FormData();
       form.append('file', fileStream, {knownLength: fileSizeInBytes});

       const response = await api.asApp().requestJira('/rest/api/2/issue/{issueIdOrKey}/attachments', {
           method: 'POST',
           body: form,
           headers: {
               'Accept': 'application/json',
               'X-Atlassian-Token': 'no-check'
           }
       });

       console.log(`Response: ${response.status} ${response.statusText}`);
       console.log(await response.json());

  Tip: Use a client library. Many client libraries have classes for handling multipart POST operations. For example, in Java, the Apache HTTP Components library provides a [MultiPartEntity](http://hc.apache.org/httpcomponents-client-ga/httpmime/apidocs/org/apache/http/entity/mime/MultipartEntity.html) class for multipart POST operations.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse Projects* and *Create attachments* [ project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec add_attachment(String.t(), [Jirex.MultipartFile.t()], keyword) ::
          {:ok, [Jirex.Attachment.t()]} | :error
  def add_attachment(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.IssueAttachments, :add_attachment},
      url: "/rest/api/2/issue/#{issueIdOrKey}/attachments",
      body: body,
      method: :post,
      request: [{"multipart/form-data", [{Jirex.MultipartFile, :t}]}],
      response: [{200, [{Jirex.Attachment, :t}]}, {403, :null}, {404, :null}, {413, :null}],
      opts: opts
    })
  end

  @doc """
  Get all metadata for an expanded attachment

  Returns the metadata for the contents of an attachment, if it is an archive, and metadata for the attachment itself. For example, if the attachment is a ZIP archive, then information about the files in the archive is returned and metadata for the ZIP archive. Currently, only the ZIP archive format is supported.

  Use this operation to retrieve data that is presented to the user, as this operation returns the metadata for the attachment itself, such as the attachment's ID and name. Otherwise, use [ Get contents metadata for an expanded attachment](#api-rest-api-2-attachment-id-expand-raw-get), which only returns the metadata for the attachment's contents.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** For the issue containing the attachment:

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec expand_attachment_for_humans(String.t(), keyword) ::
          {:ok, Jirex.AttachmentArchiveMetadataReadable.t()} | :error
  def expand_attachment_for_humans(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueAttachments, :expand_attachment_for_humans},
      url: "/rest/api/2/attachment/#{id}/expand/human",
      method: :get,
      response: [
        {200, {Jirex.AttachmentArchiveMetadataReadable, :t}},
        {401, :null},
        {403, :null},
        {404, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get contents metadata for an expanded attachment

  Returns the metadata for the contents of an attachment, if it is an archive. For example, if the attachment is a ZIP archive, then information about the files in the archive is returned. Currently, only the ZIP archive format is supported.

  Use this operation if you are processing the data without presenting it to the user, as this operation only returns the metadata for the contents of the attachment. Otherwise, to retrieve data to present to the user, use [ Get all metadata for an expanded attachment](#api-rest-api-2-attachment-id-expand-human-get) which also returns the metadata for the attachment itself, such as the attachment's ID and name.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** For the issue containing the attachment:

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec expand_attachment_for_machines(String.t(), keyword) ::
          {:ok, Jirex.AttachmentArchiveImpl.t()} | :error
  def expand_attachment_for_machines(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueAttachments, :expand_attachment_for_machines},
      url: "/rest/api/2/attachment/#{id}/expand/raw",
      method: :get,
      response: [
        {200, {Jirex.AttachmentArchiveImpl, :t}},
        {401, :null},
        {403, :null},
        {404, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get attachment metadata

  Returns the metadata for an attachment. Note that the attachment itself is not returned.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec get_attachment(String.t(), keyword) :: {:ok, Jirex.AttachmentMetadata.t()} | :error
  def get_attachment(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueAttachments, :get_attachment},
      url: "/rest/api/2/attachment/#{id}",
      method: :get,
      response: [{200, {Jirex.AttachmentMetadata, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get attachment content

  Returns the contents of an attachment. A `Range` header can be set to define a range of bytes within the attachment to download. See the [HTTP Range header standard](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Range) for details.

  To return a thumbnail of the attachment, use [Get attachment thumbnail](#api-rest-api-2-attachment-thumbnail-id-get).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** For the issue containing the attachment:

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `redirect`: Whether a redirect is provided for the attachment download. Clients that do not automatically follow redirects can set this to `false` to avoid making multiple requests to download the attachment.

  """
  @spec get_attachment_content(String.t(), keyword) :: {:ok, [map]} | :error
  def get_attachment_content(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:redirect])

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueAttachments, :get_attachment_content},
      url: "/rest/api/2/attachment/content/#{id}",
      method: :get,
      query: query,
      response: [
        {200, [:map]},
        {206, :null},
        {303, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {416, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get Jira attachment settings

  Returns the attachment settings, that is, whether attachments are enabled and the maximum attachment size allowed.

  Note that there are also [project permissions](https://confluence.atlassian.com/x/yodKLg) that restrict whether users can create and delete attachments.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_attachment_meta(keyword) :: {:ok, Jirex.AttachmentSettings.t()} | :error
  def get_attachment_meta(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.IssueAttachments, :get_attachment_meta},
      url: "/rest/api/2/attachment/meta",
      method: :get,
      response: [{200, {Jirex.AttachmentSettings, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get attachment thumbnail

  Returns the thumbnail of an attachment.

  To return the attachment contents, use [Get attachment content](#api-rest-api-2-attachment-content-id-get).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** For the issue containing the attachment:

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `redirect`: Whether a redirect is provided for the attachment download. Clients that do not automatically follow redirects can set this to `false` to avoid making multiple requests to download the attachment.
    * `fallbackToDefault`: Whether a default thumbnail is returned when the requested thumbnail is not found.
    * `width`: The maximum width to scale the thumbnail to.
    * `height`: The maximum height to scale the thumbnail to.

  """
  @spec get_attachment_thumbnail(String.t(), keyword) :: {:ok, [map]} | :error
  def get_attachment_thumbnail(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:fallbackToDefault, :height, :redirect, :width])

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueAttachments, :get_attachment_thumbnail},
      url: "/rest/api/2/attachment/thumbnail/#{id}",
      method: :get,
      query: query,
      response: [
        {200, [:map]},
        {303, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete attachment

  Deletes an attachment from an issue.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** For the project holding the issue containing the attachment:

   *  *Delete own attachments* [project permission](https://confluence.atlassian.com/x/yodKLg) to delete an attachment created by the calling user.
   *  *Delete all attachments* [project permission](https://confluence.atlassian.com/x/yodKLg) to delete an attachment created by any user.
  """
  @spec remove_attachment(String.t(), keyword) :: :ok | :error
  def remove_attachment(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueAttachments, :remove_attachment},
      url: "/rest/api/2/attachment/#{id}",
      method: :delete,
      response: [{204, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
