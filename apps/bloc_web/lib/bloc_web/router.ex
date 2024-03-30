defmodule BlocWeb.Router do
  use BlocWeb, :router

  import BlocWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {BlocWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BlocWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlocWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:bloc_web, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: BlocWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", BlocWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{BlocWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live("/users/register", UserRegistrationLive, :new)
      live("/users/log_in", UserLoginLive, :new)
      live("/users/reset_password", UserForgotPasswordLive, :new)
      live("/users/reset_password/:token", UserResetPasswordLive, :edit)
    end

    post("/users/log_in", UserSessionController, :create)
  end

  scope "/", BlocWeb do
    pipe_through([:browser, :require_authenticated_user])

    live_session :require_authenticated_user,
      on_mount: [{BlocWeb.UserAuth, :ensure_authenticated}] do
      live("/users/settings", UserSettingsLive, :edit)
      live("/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email)

      live("/blocks", BlockLive.Index, :index)
      live("/blocks/new", BlockLive.Index, :new)
      live("/blocks/:id/edit", BlockLive.Index, :edit)

      live("/blocks/:id", BlockLive.Show, :show)
      live("/blocks/:id/show/edit", BlockLive.Show, :edit)

      live("/habits", HabitLive.Index, :index)
      live("/habits/new", HabitLive.Index, :new)
      live("/habits/:id/edit", HabitLive.Index, :edit)

      live("/habits/:id", HabitLive.Show, :show)
      live("/habits/:id/show/edit", HabitLive.Show, :edit)

      live("/habit_periods", HabitPeriodLive.Index, :index)
      live("/habit_periods/new", HabitPeriodLive.Index, :new)
      live("/habit_periods/:id/edit", HabitPeriodLive.Index, :edit)

      live("/habit_periods/:id", HabitPeriodLive.Show, :show)
      live("/habit_periods/:id/show/edit", HabitPeriodLive.Show, :edit)
    end
  end

  scope "/", BlocWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)

    live_session :current_user,
      on_mount: [{BlocWeb.UserAuth, :mount_current_user}] do
      live("/users/confirm/:token", UserConfirmationLive, :edit)
      live("/users/confirm", UserConfirmationInstructionsLive, :new)
    end
  end
end
