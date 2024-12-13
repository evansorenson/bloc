defmodule Bloc.Tasks.NaturalLanguageParser do
  @moduledoc """
  Parses natural language in task titles to extract dates and time estimates.
  """

  @date_keywords %{
    "today" => 0,
    "tomorrow" => 1,
    "tmr" => 1,
    "next" => 7
  }

  @weekdays %{
    "monday" => 1,
    "tuesday" => 2,
    "wednesday" => 3,
    "thursday" => 4,
    "friday" => 5,
    "saturday" => 6,
    "sunday" => 7,
    "mon" => 1,
    "tue" => 2,
    "wed" => 3,
    "thu" => 4,
    "fri" => 5,
    "sat" => 6,
    "sun" => 7
  }

  @time_patterns %{
    "15m" => 15,
    "30m" => 30,
    "45m" => 45,
    "60m" => 60,
    "1h" => 60,
    "1h30m" => 90,
    "2h" => 120,
    "3h" => 180,
    "4h" => 240
  }

  def parse(title) do
    title = String.downcase(title)
    {clean_title, due_date} = extract_date(title)
    {clean_title, estimate} = extract_time_estimate(clean_title)

    %{
      title: String.trim(clean_title),
      due_date: due_date,
      estimated_minutes: estimate
    }
  end

  defp extract_date(title) do
    cond do
      # Handle "today", "tomorrow"
      date = find_keyword_date(title) ->
        {remove_date_keyword(title), date}

      # Handle "next tuesday", "monday", etc
      date = find_weekday_date(title) ->
        {remove_weekday(title), date}

      true ->
        {title, nil}
    end
  end

  defp find_keyword_date(title) do
    Enum.find_value(@date_keywords, fn {keyword, days} ->
      if String.contains?(title, keyword) do
        Date.add(Date.utc_today(), days)
      end
    end)
  end

  defp find_weekday_date(title) do
    Enum.find_value(@weekdays, fn {day, weekday} ->
      if String.contains?(title, day) do
        days_until = calculate_days_until(weekday)
        days_until = if String.contains?(title, "next"), do: days_until + 7, else: days_until
        Date.add(Date.utc_today(), days_until)
      end
    end)
  end

  defp calculate_days_until(target_weekday) do
    today = Date.day_of_week(Date.utc_today())
    diff = target_weekday - today
    if diff <= 0, do: diff + 7, else: diff
  end

  defp remove_date_keyword(title) do
    Enum.reduce(@date_keywords, title, fn {keyword, _}, acc ->
      String.replace(acc, keyword, "")
    end)
  end

  defp remove_weekday(title) do
    title
    |> String.replace("next", "")
    |> then(fn str ->
      Enum.reduce(@weekdays, str, fn {day, _}, acc ->
        String.replace(acc, day, "")
      end)
    end)
  end

  defp extract_time_estimate(title) do
    {pattern, minutes} =
      Enum.find(@time_patterns, {nil, nil}, fn {pattern, _} ->
        String.contains?(title, pattern)
      end)

    if pattern do
      {String.replace(title, pattern, ""), minutes}
    else
      {title, nil}
    end
  end
end
