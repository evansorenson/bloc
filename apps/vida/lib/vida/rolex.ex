defmodule Rolex do
  @moduledoc """
  Rolex is an expressive role based permission definition and checking library.

  Permissions are grouped by scopes and are granted to roles defined within.
  If checks are also defined for the role, either globally or within the permissions, they must all pass for the permission to be granted.
  Checks may be defined globally via the `check/2` macro, or within a role within a permission.
  All roles must be defined globally as they are checked at compile time. This also helps tie into other systems by providing the `c:roles/0` function on the generated module.

  ## Config

  Available configuration options passed into the `use` statement. See `t:config/0` for options and descriptions.

  ## Compile time checks

  Rolex performs several compile time checks to ensure that your permissions are well enforced.

  - All roles must be defined using the `roles/1` macro before use. This prevents typos and such.
  - Checks defined as `check :my_check` will fail to compile if your module does not define `MyModule.my_check/4`. This prevents runtime failures.
  - Checks defined as `{MyOtherModule, :my_check}` will fail to compile if `MyOtherModule.my_check/4` is not exported

  ## Example Usage

      iex> defmodule Example.Posts do
      ...>   def is_visible?(_user, _scope, _perm, %{is_public?: true}), do: true
      ...>   def is_visible?(%{id: user_id}, _scope, _perm, %{created_by: user_id}), do: true
      ...>   def is_visible?(_user, _scope, _perm, _post), do: false
      ...>   def is_own?(%{id: user_id}, _scope, _perm, %{created_by: user_id}), do: true
      ...>   def is_own?(_user, _scope, _perm, _object), do: false
      ...>   def is_editable?(_user, _scope, _perm, %{is_editable?: true}), do: true
      ...>   def is_editable?(_user, _scope, _perm, _object), do: false
      ...> end
      ...>
      iex> defmodule Example.Active do
      ...>   def is_active?(%{active: active}, _scope, _perm, _object), do: active
      ...> end
      ...>
      iex> defmodule Example do
      ...>   use Rolex
      ...>
      ...>   alias __MODULE__.Posts
      ...>   alias __MODULE__.Active
      ...>
      ...>   roles [
      ...>     :admin,
      ...>     :member
      ...>   ]
      ...>
      ...>   # You can define a check in either atom format or module, atom format
      ...>   check :admin, :is_active?
      ...>   check :member, Active, :is_active?
      ...>
      ...>   scope :posts do
      ...>     permission :view do
      ...>       role :admin
      ...>       role :member do
      ...>         check Posts, :is_visible?
      ...>       end
      ...>     end
      ...>
      ...>     permission :edit do
      ...>       role :admin
      ...>       role :member do
      ...>         check [
      ...>           {Posts, :is_own?},
      ...>           {Posts, :is_editable?}
      ...>         ]
      ...>       end
      ...>     end
      ...>
      ...>     permission :delete do
      ...>       role :admin
      ...>     end
      ...>   end
      ...>
      ...>   def is_active?(%{active: active}, _scope, _perm, _object), do: active
      ...> end
      iex> Example.can?(%{roles: [:admin], id: 1, active: true}, :posts, :view, %{created_by: 2,})
      true
      iex> Example.can?(%{roles: [:admin], id: 1, active: false}, :posts, :view, %{created_by: 2,})
      false
      iex> Example.can?(%{roles: [:member], id: 3, active: true}, :posts, :view, %{created_by: 2})
      false
      iex> Example.can?(%{roles: [:member], id: 3, active: true}, :posts, :view, %{is_public?: true, created_by: 2})
      true
      iex> Example.can?(%{roles: [:member], id: 2, active: true}, :posts, :view, %{is_public?: true, created_by: 2})
      true
      iex> Example.can?(%{roles: [:member], id: 2, active: true}, :posts, :view, [%{is_public?: true, created_by: 2}, %{is_public?: false, created_by: 2}])
      true
      iex> Example.can?(%{roles: [:member], id: 2, active: true}, :posts, :view, [%{is_public?: true, created_by: 2}, %{is_public?: false, created_by: 3}])
      false
      iex> Example.can?(%{roles: [:member], id: 2, active: false}, :posts, :view, %{is_public?: true, created_by: 2})
      false
      iex> Example.can?(%{roles: [:member], id: 2, active: true}, :posts, :edit, %{is_public?: true, created_by: 2})
      true
      iex> Example.can?(%{roles: [:member], id: 2, active: true}, :posts, :edit, %{is_public?: true, created_by: 3, is_editable?: true})
      true
      iex> Example.can?(%{roles: [:member], id: 2, active: true}, :posts, :edit, %{is_public?: true, created_by: 3, is_editable?: false})
      false
      iex> Example.has?(%{roles: [:member], id: 2, active: false}, :posts, :view)
      true

  """
  alias Rolex.Check
  alias Rolex.Permission
  alias Rolex.Role
  alias Rolex.Scope
  alias Rolex.Stack

  @typedoc """
  A user object. Represented as a map but can be anything that has `roles` on it or can be passed to `t:roles_getter`
  """
  @type user :: map()

  @typedoc """
  Any object being checked as having access to.
  """
  @type object :: any()

  @typedoc """
  The name of a scope as an atom.
  """
  @type scope :: atom()

  @typedoc """
  The name of a permission as an atom.
  """
  @type permission :: atom()

  @doc """
  A callback generated in the module to list all the scopes.
  """
  @callback scopes() :: %{atom() => Scope.t()}
  @doc """
  A callback generated in the module to list all possible roles.
  """
  @callback roles() :: [atom()]

  @doc """
  A callback generated in the module to map scope name to permission names.
  """
  @callback permissions() :: %{scope() => [permission()]}

  @doc """
  A callback generated in the module to check if a user has the scoped permission against the object.
  While this callback is auto generated for you via the `use`, you can override this however you want. See `can?/5`.

  TODO: Expand on this doc
  """
  @callback can?(user(), scope(), permission(), object() | [object()]) :: boolean()

  @doc """
  A callback generated in the module to check if the user has a scoped permission based solely on role. This method DOES NOT run checks.
  While this callback is auto generated for you via the `use`, you can override this however you want. See `has?/4`.

  TODO: Expand on this doc
  """
  @callback has?(user(), scope(), permission()) :: boolean()

  @typedoc """
  A function that retrieves the roles for the given user.

  It expects a single argument, the `t:user/0`, and returns a list of role names.

  ## Example

  The default behavior for getting roles is `Map.get(user, :roles, [])`. So if
  your user's roles live on a different key, you can use `roles_getter` to
  point to the right place.

      defmodule CustomRolesKey do
        use Roles, roles_getter: &__MODULE__.get_roles/1

        # ... permission config

        def get_roles(user), do: Map.get(user, :my_roles_key, [])
      end
  """
  @type roles_getter :: (Rolex.user() -> [atom()])

  @typedoc """
  Configure the DSL. See individual types for descriptions.
  """
  @type config :: [
          roles_getter: roles_getter()
        ]

  @scopes :scopes
  @roles :roles

  defmacro __using__(opts) do
    quote do
      import unquote(__MODULE__), only: :macros
      unquote(__MODULE__).__init__(__MODULE__, unquote(opts))

      @before_compile unquote(__MODULE__)
      @after_compile unquote(__MODULE__)

      @behaviour Rolex
    end
  end

  @doc false
  def __init__(module, opts) do
    Module.register_attribute(module, @scopes, accumulate: true)
    Module.register_attribute(module, @roles, [])
    Module.put_attribute(module, @roles, [])
    Module.register_attribute(module, :__roles_getter__, [])
    roles_getter = Keyword.get(opts, :roles_getter)
    Module.put_attribute(module, :__roles_getter__, roles_getter)
    Stack.init(module)
  end

  @doc """
  Define a scope.

  Scopes are groupings of permissions.

  Only can be defined at the root of the module.
  """
  defmacro scope(name, do: context) do
    quote do
      unquote(__MODULE__).__scope__(__MODULE__, unquote(name), fn -> unquote(context) end)
    end
  end

  @doc false
  def __scope__(module, name, context) do
    if is_duplicate_scope?(name, module) do
      raise "scope \"#{inspect(name)}\" is duplicated."
    end

    scope = %Scope{name: name}
    Stack.push(module, scope)

    try do
      context.()
    after
      scope = Stack.pop(module)
      Module.put_attribute(module, @scopes, scope)
    end
  end

  defp is_duplicate_scope?(scope, module) do
    module
    |> Module.get_attribute(@scopes)
    |> Enum.map(fn %Scope{name: name} -> name end)
    |> Enum.member?(scope)
  end

  @doc """
  Define a check for a specific role in a specific permission.

  All checks can be defined in 1 of three ways.

  #### Atom format

      check :is_still_active?

  #### Module and function format

      check Posts, :is_visible?

  #### A list of modules and functions that will evauluate to true if any of the inner checks evaluate to true

      check [
        {Posts, :is_visible?},
        {Posts, :is_editable?}
      ]

  ## Example

      iex> defmodule CheckExample do
      ...>   use Rolex
      ...>
      ...>
      ...>   roles [:member]
      ...>   check :admin, __MODULE__, :is_active?
      ...>   check :unknown_role, :is_active?
      ...>
      ...>   scope :posts do
      ...>     permission :create do
      ...>       role :member do
      ...>         check :is_active?
      ...>       end
      ...>     end
      ...>   end
      ...>
      ...>   def is_active?(%{active: active}, _scope, _perm, _object), do: active
      ...> end
      iex> CheckExample.can?(%{active: true, roles: [:member]}, :posts, :create, %{})
      true
      iex> CheckExample.can?(%{active: false, roles: [:member]}, :posts, :create, %{})
      false

  """
  defmacro check(mod_funs) when is_list(mod_funs) do
    quote do
      unquote(__MODULE__).__checks__(__MODULE__, unquote(mod_funs))
    end
  end

  # Scoped check with local call - root->scope->permission->role->check
  defmacro check(fun) do
    quote do
      unquote(__MODULE__).__checks__(__MODULE__, {__MODULE__, unquote(fun)})
    end
  end

  @doc """
  Define a global check for a role. This will apply across all scopes and will always be enforced for a role. Usage is similar to `check/1` and `check/2`

  ## Example

      iex> defmodule GlobalCheckExample do
      ...>   use Rolex
      ...>
      ...>   roles [:member, :admin]
      ...>
      ...>   check :member, :is_still_active?
      ...>   check :admin, __MODULE__, :is_still_active?
      ...>
      ...>   scope :posts do
      ...>     permission :create do
      ...>       role :member
      ...>     end
      ...>   end
      ...>
      ...>   def is_still_active?(%{active: active}, _scope, _perm, _object), do: active
      ...> end
      iex> GlobalCheckExample.can?(%{active: true, roles: [:member]}, :posts, :create, %{})
      true
      iex> GlobalCheckExample.can?(%{active: false, roles: [:member]}, :posts, :create, %{})
      false

  """
  defmacro check(role_or_module, call_or_function) do
    role_or_module = maybe_expand(role_or_module, %{__CALLER__ | function: {:can?, 4}})

    quote do
      unquote(__MODULE__).__maybe_check__(
        __MODULE__,
        unquote(role_or_module),
        unquote(call_or_function)
      )
    end
  end

  defmacro check(role, mod, fun) do
    mod = Macro.expand(mod, %{__CALLER__ | function: {:can?, 4}})

    quote do
      unquote(__MODULE__).__role_check__(__MODULE__, unquote(role), {unquote(mod), unquote(fun)})
    end
  end

  # Do not expand module attributes as they don't need to be.
  defp maybe_expand({:@, _line, _other} = ast, _env), do: ast
  defp maybe_expand(ast, env), do: Macro.expand(ast, env)

  def __maybe_check__(module, role_or_module, fun) do
    # This function exists to handle the ambiguity between
    # global role based checks with a local defined function
    # and scoped checks with a remote function
    # role based `check :some_role, :some_local_function
    # scoped `check SomeModule, :some_remote_function
    if Stack.is_root?(module) do
      # Given a global role based check with a local function
      __role_check__(module, role_or_module, {module, fun})
    else
      # Given scoped check with a remote function
      __checks__(module, {role_or_module, fun})
    end
  end

  @doc false
  def __checks__(module, mod_funs) when is_list(mod_funs) do
    checks = accumulate_checks(mod_funs, [])
    Stack.push(module, checks)
    Stack.pop(module)
  end

  @doc false
  def __checks__(module, {_mod, _fun} = mf) do
    mod_funs = [mf]
    __checks__(module, mod_funs)
  end

  defp accumulate_checks([], acc), do: acc

  defp accumulate_checks([{_mod, _fun} = mf | rest], acc) do
    accumulate_checks(rest, [%Check{call: mf} | acc])
  end

  @doc false
  def __role_check__(module, role, {_mod, _fun} = mf) do
    check = %Check{call: mf}
    Stack.role_check(module, role, check)
  end

  @doc """
  Define a permission within a scope.

  Permissions must be unique within a scope.

  Can only be used within the scope macro.

  Optionally, you can pass additional metadata to store on the permission.
  This is particularly useful for later filtering and finding permissions
  when scoping alone isn't sufficient.

  # Example

      iex> defmodule PermissionExample do
      ...>   use Rolex
      ...>
      ...>   roles [:member, :admin]
      ...>
      ...>   scope :posts do
      ...>     permission :create do
      ...>       role :member
      ...>     end
      ...>
      ...>     permission :view, expose: true do
      ...>       role :member
      ...>     end
      ...>    end
      ...> end
      iex> Enum.flat_map(PermissionExample.scopes(), fn {_name, scope} ->
      ...>   scope.permissions
      ...>   |> Map.values()
      ...>   |> Enum.filter(fn %{metadata: metadata} ->
      ...>     Keyword.get(metadata, :expose, false)
      ...>   end)
      ...> end)
      [%Rolex.Permission{name: :view, metadata: [expose: true], roles: %{member: %Rolex.Role{name: :member}}}]

  """
  defmacro permission(name, do: context) do
    quote do
      unquote(__MODULE__).__permission__(__MODULE__, unquote(name), fn -> unquote(context) end)
    end
  end

  defmacro permission(name, metadata, do: context) do
    quote do
      unquote(__MODULE__).__permission__(
        __MODULE__,
        unquote(name),
        fn -> unquote(context) end,
        unquote(metadata)
      )
    end
  end

  @doc false
  def __permission__(module, name, context, metadata \\ []) do
    perm = %Permission{name: name, metadata: metadata}
    roles_getter = Module.get_attribute(module, :__roles_getter__)

    perm =
      if roles_getter do
        %{perm | roles_getter: roles_getter}
      else
        perm
      end

    Stack.push(module, perm)

    try do
      context.()
    after
      Stack.pop(module)
    end
  end

  @doc """
  Grant a role access to a permission.

  Can only be used within the permission macro.

  Roles must be unique within a permission and must also be defined globally within the `roles/1` macro.

  Roles can have a context to define checks. See `check/1` for examples.
  """
  defmacro role(name, do: context) do
    quote do
      unquote(__MODULE__).__role__(__MODULE__, unquote(name), fn -> unquote(context) end)
    end
  end

  @doc """
  See `role/2`
  """
  defmacro role(name) do
    quote do
      unquote(__MODULE__).__role__(__MODULE__, unquote(name), fn -> nil end)
    end
  end

  @doc false
  def __role__(module, name, context) do
    defined = Module.get_attribute(module, @roles, [])

    unless Enum.member?(defined, name) do
      raise "unknown role \"#{name}\" -- refer to Rolex documentation"
    end

    Stack.push(module, %Role{name: name})

    try do
      context.()
    after
      Stack.pop(module)
    end
  end

  @doc """
  Defines all possible role names for compile time checking and building the `c:roles/0` callback.

  Only valid in the root of the module.

  Names must be unique.
  """
  defmacro roles(roles) do
    quote do
      Module.put_attribute(__MODULE__, unquote(@roles), unquote(roles))
    end
  end

  defmacro __after_compile__(env, _ast) do
    validate_checks!(env)

    []
  end

  defmacro __before_compile__(env) do
    scopes =
      env.module
      |> Module.get_attribute(@scopes)
      |> Enum.map(fn scope -> {scope.name, scope} end)
      |> Enum.into(%{})

    roles = Module.get_attribute(env.module, @roles)
    permissions = gen_permissions(scopes)

    quote do
      def scopes() do
        unquote(Macro.escape(scopes))
      end

      def roles() do
        unquote(Macro.escape(roles))
      end

      def permissions() do
        unquote(Macro.escape(permissions))
      end

      def can?(user, scope, permission, object) do
        unquote(__MODULE__).can?(__MODULE__, user, scope, permission, object)
      end

      def split(user, scope, permission, objects) do
        unquote(__MODULE__).split(__MODULE__, user, scope, permission, objects)
      end

      def filter(user, scope, permission, objects) do
        unquote(__MODULE__).filter(__MODULE__, user, scope, permission, objects)
      end

      def has?(user, scope, permission) do
        unquote(__MODULE__).has?(__MODULE__, user, scope, permission)
      end

      defoverridable can?: 4, has?: 3, split: 4, filter: 4
    end
  end

  @doc """
  `has?` is a check to see if they have a permission regardless of the object being operated on.
  If the user has any role that has this permission it'll return true.
  """
  @spec has?(module(), user(), scope(), permission()) :: boolean()
  def has?(module, user, scope, permission) do
    perm = load_permission(module, scope, permission)
    Permission.has?(perm, user)
  end

  @doc """
  `can?` is a check to see if the user has a permission against a specific object or list of objects.
  This will run the checks defined in the role definition. If any of them return true they'll have permission.

  Optionally, a list of objects to check the permission against is supported where it will return false
  if the user does not have permission to any of the objects.
  """
  @spec can?(module(), user(), scope(), permission(), object() | [object()]) :: boolean()
  def can?(module, user, scope, permission, objects) when is_list(objects) do
    perm = load_permission(module, scope, permission)
    Enum.all?(objects, &Permission.can?(perm, user, scope, &1))
  end

  def can?(module, user, scope, permission, object) do
    perm = load_permission(module, scope, permission)
    Permission.can?(perm, user, scope, object)
  end

  @spec split(module(), user(), scope(), permission(), [object()]) :: {[object()], [object()]}
  def split(module, user, scope, permission, objects) when is_list(objects) do
    perm = load_permission(module, scope, permission)
    successes = Permission.filter(perm, user, scope, objects)
    {successes, objects -- successes}
  end

  @spec filter(module(), user(), scope(), permission(), [object()]) :: [object()]
  def filter(module, user, scope, permission, objects) when is_list(objects) do
    perm = load_permission(module, scope, permission)
    Permission.filter(perm, user, scope, objects)
  end

  defp load_permission(module, scope, permission) do
    case Map.get(module.scopes(), scope) do
      nil ->
        raise "unknown scope \"#{scope}\""

      scope ->
        case Map.get(scope.permissions, permission) do
          nil ->
            raise "unknown permission \"#{permission}\""

          perm ->
            perm
        end
    end
  end

  defp gen_permissions(scopes) do
    # Gen a map of scopes->permissions
    scopes
    |> Enum.map(fn {scope_name, scope} ->
      {scope_name, Map.keys(scope.permissions)}
    end)
    |> Enum.into(%{})
  end

  defp validate_checks!(caller) do
    # Raises if the checks are not defined and exported
    # This is an extra safety precaution to ensure we don't
    # get runtime failures checking permissions.
    scopes = caller.module.scopes()

    scopes
    |> Enum.flat_map(fn {_, scope} -> scope.permissions end)
    |> Enum.flat_map(fn {_, perm} -> perm.roles end)
    |> Enum.flat_map(fn {_, role} -> role.checks end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(fn %Check{call: {mod, fun}} ->
      case Code.ensure_compiled(mod) do
        {:module, mod} ->
          unless function_exported?(mod, fun, 4) do
            raise "invalid check {#{inspect(mod)}, #{inspect(fun)}}"
          end

        {:error, :unavailable} ->
          IO.puts(
            :stderr,
            "ROLEX: can't validate check {#{inspect(mod)}, #{inspect(fun)}} -- module \"#{inspect(mod)}\" is unavailable (compiler deadlock)"
          )

        _other ->
          raise "invalid check {#{inspect(mod)}, #{inspect(fun)}} -- module \"#{inspect(mod)}\" is not found"
      end
    end)
  end
end
