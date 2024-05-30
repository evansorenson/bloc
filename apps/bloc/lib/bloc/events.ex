defmodule Bloc.Events do
  @moduledoc false

  defmodule TaskCompleted do
    @moduledoc false
    defstruct task: nil
  end

  defmodule TaskAssignedDate do
    @moduledoc false

    defstruct task: nil
  end

  defmodule TaskMovedList do
    @moduledoc false

    defstruct task: nil
  end
end
