defmodule Bloc.Events do
  @moduledoc false

  defmodule TaskCreated do
    @moduledoc false
    defstruct [:task, :task_list]
  end

  defmodule TaskUpdated do
    @moduledoc false
    defstruct [:task, :old_task]
  end

  defmodule TaskDeleted do
    @moduledoc false
    defstruct [:task, :task_list]
  end

  defmodule TaskCompleted do
    @moduledoc false
    defstruct [:task, :reward]
  end

  defmodule TaskMoved do
    @moduledoc false
    defstruct [:task, :from_list, :to_list]
  end

  defmodule TaskListCreated do
    @moduledoc false
    defstruct [:task_list]
  end

  defmodule TaskListUpdated do
    @moduledoc false
    defstruct [:task_list]
  end

  defmodule TaskListDeleted do
    @moduledoc false
    defstruct [:task_list]
  end
end
