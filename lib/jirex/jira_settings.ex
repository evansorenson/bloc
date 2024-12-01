defmodule Jirex.JiraSettings do
  @moduledoc """
  Provides API endpoints related to jira settings
  """

  @default_client Jirex.Client

  @doc """
  Get advanced settings

  Returns the application properties that are accessible on the *Advanced Settings* page. To navigate to the *Advanced Settings* page in Jira, choose the Jira icon > **Jira settings** > **System**, **General Configuration** and then click **Advanced Settings** (in the upper right).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_advanced_settings(keyword) :: {:ok, [Jirex.ApplicationProperty.t()]} | :error
  def get_advanced_settings(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.JiraSettings, :get_advanced_settings},
      url: "/rest/api/2/application-properties/advanced-settings",
      method: :get,
      response: [{200, [{Jirex.ApplicationProperty, :t}]}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get application property

  Returns all application properties or an application property.

  If you specify a value for the `key` parameter, then an application property is returned as an object (not in an array). Otherwise, an array of all editable application properties is returned. See [Set application property](#api-rest-api-2-application-properties-id-put) for descriptions of editable properties.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `key`: The key of the application property.
    * `permissionLevel`: The permission level of all items being returned in the list.
    * `keyFilter`: When a `key` isn't provided, this filters the list of results by the application property `key` using a regular expression. For example, using `jira.lf.*` will return all application properties with keys that start with *jira.lf.*.

  """
  @spec get_application_property(keyword) ::
          {:ok, [Jirex.ApplicationProperty.t()]} | {:error, Jirex.ErrorCollection.t()}
  def get_application_property(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key, :keyFilter, :permissionLevel])

    client.request(%{
      args: [],
      call: {Jirex.JiraSettings, :get_application_property},
      url: "/rest/api/2/application-properties",
      method: :get,
      query: query,
      response: [
        {200, [{Jirex.ApplicationProperty, :t}]},
        {401, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get global settings

  Returns the [global settings](https://confluence.atlassian.com/x/qYXKM) in Jira. These settings determine whether optional features (for example, subtasks, time tracking, and others) are enabled. If time tracking is enabled, this operation also returns the time tracking configuration.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_configuration(keyword) :: {:ok, Jirex.Configuration.t()} | :error
  def get_configuration(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.JiraSettings, :get_configuration},
      url: "/rest/api/2/configuration",
      method: :get,
      response: [{200, {Jirex.Configuration, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Set application property

  Changes the value of an application property. For example, you can change the value of the `jira.clone.prefix` from its default value of *CLONE -* to *Clone -* if you prefer sentence case capitalization. Editable properties are described below along with their default values.

  #### Advanced settings ####

  The advanced settings below are also accessible in [Jira](https://confluence.atlassian.com/x/vYXKM).

  | Key | Description | Default value |
  | -- | -- | -- |
  | `jira.clone.prefix` | The string of text prefixed to the title of a cloned issue. | `CLONE -` |
  | `jira.date.picker.java.format` | The date format for the Java (server-side) generated dates. This must be the same as the `jira.date.picker.javascript.format` format setting. | `d/MMM/yy` |
  | `jira.date.picker.javascript.format` | The date format for the JavaScript (client-side) generated dates. This must be the same as the `jira.date.picker.java.format` format setting. | `%e/%b/%y` |
  | `jira.date.time.picker.java.format` | The date format for the Java (server-side) generated date times. This must be the same as the `jira.date.time.picker.javascript.format` format setting. | `dd/MMM/yy h:mm a` |
  | `jira.date.time.picker.javascript.format` | The date format for the JavaScript (client-side) generated date times. This must be the same as the `jira.date.time.picker.java.format` format setting. | `%e/%b/%y %I:%M %p` |
  | `jira.issue.actions.order` | The default order of actions (such as *Comments* or *Change history*) displayed on the issue view. | `asc` |
  | `jira.view.issue.links.sort.order` | The sort order of the list of issue links on the issue view. | `type, status, priority` |
  | `jira.comment.collapsing.minimum.hidden` | The minimum number of comments required for comment collapsing to occur. A value of `0` disables comment collapsing. | `4` |
  | `jira.newsletter.tip.delay.days` | The number of days before a prompt to sign up to the Jira Insiders newsletter is shown. A value of `-1` disables this feature. | `7` |


  #### Look and feel ####

  The settings listed below adjust the [look and feel](https://confluence.atlassian.com/x/VwCLLg).

  | Key | Description | Default value |
  | -- | -- | -- |
  | `jira.lf.date.time` | The [ time format](https://docs.oracle.com/javase/6/docs/api/index.html?java/text/SimpleDateFormat.html). | `h:mm a` |
  | `jira.lf.date.day` | The [ day format](https://docs.oracle.com/javase/6/docs/api/index.html?java/text/SimpleDateFormat.html). | `EEEE h:mm a` |
  | `jira.lf.date.complete` | The [ date and time format](https://docs.oracle.com/javase/6/docs/api/index.html?java/text/SimpleDateFormat.html). | `dd/MMM/yy h:mm a` |
  | `jira.lf.date.dmy` | The [ date format](https://docs.oracle.com/javase/6/docs/api/index.html?java/text/SimpleDateFormat.html). | `dd/MMM/yy` |
  | `jira.date.time.picker.use.iso8061` | When enabled, sets Monday as the first day of the week in the date picker, as specified by the ISO8601 standard. | `false` |
  | `jira.lf.logo.url` | The URL of the logo image file. | `/images/icon-jira-logo.png` |
  | `jira.lf.logo.show.application.title` | Controls the visibility of the application title on the sidebar. | `false` |
  | `jira.lf.favicon.url` | The URL of the favicon. | `/favicon.ico` |
  | `jira.lf.favicon.hires.url` | The URL of the high-resolution favicon. | `/images/64jira.png` |
  | `jira.lf.navigation.bgcolour` | The background color of the sidebar. | `#0747A6` |
  | `jira.lf.navigation.highlightcolour` | The color of the text and logo of the sidebar. | `#DEEBFF` |
  | `jira.lf.hero.button.base.bg.colour` | The background color of the hero button. | `#3b7fc4` |
  | `jira.title` | The text for the application title. The application title can also be set in *General settings*. | `Jira` |
  | `jira.option.globalsharing` | Whether filters and dashboards can be shared with anyone signed into Jira. | `true` |
  | `xflow.product.suggestions.enabled` | Whether to expose product suggestions for other Atlassian products within Jira. | `true` |


  #### Other settings ####

  | Key | Description | Default value |
  | -- | -- | -- |
  | `jira.issuenav.criteria.autoupdate` | Whether instant updates to search criteria is active. | `true` |


  *Note: Be careful when changing [application properties and advanced settings](https://confluence.atlassian.com/x/vYXKM).*

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_application_property(String.t(), Jirex.SimpleApplicationPropertyBean.t(), keyword) ::
          {:ok, Jirex.ApplicationProperty.t()} | {:error, Jirex.ErrorCollection.t()}
  def set_application_property(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.JiraSettings, :set_application_property},
      url: "/rest/api/2/application-properties/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.SimpleApplicationPropertyBean, :t}}],
      response: [
        {200, {Jirex.ApplicationProperty, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
