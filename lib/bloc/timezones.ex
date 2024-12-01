# defmodule Bloc.Timezones do
#   alias Bloc.Scope

#   def to_utc(%Scope{timezone: timezone}, datetime) do
#     Timex.Timezone.convert(datetime, "Etc/UTC")
#   end

#   def from_utc(%Scope{timezone: timezone}, datetime) do
#     DateTime.shift_zone!(datetime, timezone)
#   end

#   def normalize_value(%Scope{timezone: timezone}, value) do
#     case value do
#       %DateTime{} -> from_utc(%{timezone: timezone}, value)
#       _ -> value
#     end
#   end
# end
