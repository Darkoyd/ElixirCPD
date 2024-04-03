defmodule BoutiqueInventory do
  def new() do
    []
  end

  def add_item(inventory, item) do
    inventory = [item | inventory]
  end

  def add_size(inventory, item_name, new_size, quantity) do
    case Enum.find(inventory, &(Map.get(&1, :name)) == item_name) do
      nil ->
        inventory

      item ->
        size_map = item
        |> Map.get(:quantity_by_size)
        |> Map.put(new_size, quantity)

        new_item = Map.put(item, :quantity_by_size, size_map)
        Enum.reject(inventory, &(&1 == item))
        |> add_item(new_item)

    end
  end

  def remove_size(inventory, item_name, size) do
    case Enum.find(inventory, &(Map.get(&1, :name)) == item_name) do
      nil ->
        inventory

      item ->
        size_map = item
        |> Map.get(:quantity_by_size)
        |> Map.delete(size)

        new_item = Map.put(item, :quantity_by_size, size_map)
        Enum.reject(inventory, &(&1 == item))
        |> add_item(new_item)
    end
  end

  def sort_by_price(inventory) do
    Enum.sort(inventory, &(Map.get(&1, :price) <= Map.get(&2, :price)))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(Map.get(&1, :price) == nil))
  end

  def increase_quantity(item, n) do
        sizes_map = item
        |> Map.get(:quantity_by_size)
        |> Enum.map(fn {k, v} -> {k, v+n} end)
        |> Enum.into(%{})

        Map.put(item, :quantity_by_size, sizes_map)
    end

    def total_quantity(item) do
        item
        |> Map.get(:quantity_by_size)
        |> Enum.reduce(0, fn {_, v}, acc -> acc + v end)
    end
end
