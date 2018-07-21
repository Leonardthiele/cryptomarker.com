defmodule Platform.Util.Score do
  @moduledoc false

  @doc """
  Calculates a percentage score from a list

  ## Examples

      iex> Score.calculate_percentage([])
      1.0

      iex> Score.calculate_percentage([{1, true}])
      1.0

      iex> Score.calculate_percentage([{1, true}, {1, false}])
      0.5
  """
  def calculate_percentage([]), do: 1.0
  def calculate_percentage(list) when is_list(list) do
    {total, filled} = calculate_absolute_points(list)
    filled / total
  end

  @doc """
  Calculates a percentage score from a list

  ## Examples

      iex> Score.calculate_absolute_points([])
      {0, 0}

      iex> Score.calculate_absolute_points([{1, true}])
      {1, 1}

      iex> Score.calculate_absolute_points([{1, false}])
      {1, 0}

      iex> Score.calculate_absolute_points([{2, false}, {1, false}, {1, true}, {1, true}])
      {5, 2}
  """
  def calculate_absolute_points([]), do: {0, 0}
  def calculate_absolute_points(list) when is_list(list) do
    Enum.reduce list, {0, 0}, fn({current_points, result}, {sum_points, last}) ->
      if result do
        {current_points + sum_points, last + current_points}
      else
        {current_points + sum_points, last}
      end
    end
  end
end
