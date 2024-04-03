defmodule T2 do
  @doc """
  Create a Robot simulator given an initial direction and position.
  Valid directions are :north, :east, :south, :west.
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction, position) do
    %{
      direction: direction,
      position: position
    }
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L" (turn left), "A" (advance).
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, "") do
    robot
  end

  def simulate(robot, instructions) do
    simulate(
      step(robot, String.at(instructions, 0)),
      String.slice(instructions, 1, String.length(instructions))
    )
  end

  defp step(robot, instruction) do
    case instruction do
      "R" -> turn_right(robot)
      "L" -> turn_left(robot)
      "A" -> advance(robot)
    end
  end

  defp turn_right(robot) do
    new_dir =
      case direction(robot) do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    set_direction(robot, new_dir)
  end

  defp turn_left(robot) do
    new_dir =
      case direction(robot) do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    set_direction(robot, new_dir)
  end

  defp advance(robot) do
    {x, y} = position(robot)

    case direction(robot) do
      :north -> set_position(robot, {x, y + 1})
      :east -> set_position(robot, {x + 1, y})
      :south -> set_position(robot, {x, y - 1})
      :west -> set_position(robot, {x - 1, y})
    end
  end

  @doc """
  Return the robot's current direction.

  Valid directions are :north, :east, :south, :west.
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot |> Map.get(:direction)
  end

  defp set_direction(robot, new_direction) do
    robot |> Map.put(:direction, new_direction)
  end

  @doc """
  Return the robot's current position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot |> Map.get(:position)
  end
  defp set_position(robot, new_position) do
    robot |> Map.put(:position, new_position)
  end

end
