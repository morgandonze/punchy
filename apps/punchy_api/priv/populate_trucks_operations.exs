NimbleCSV.define(CSVParser, separator: ",", escape: "\"")

[truck_data_url: _truck_data_url] = Application.get_env(:punchy_api, :data)
{:ok, cwd} = File.cwd()
truck_data_save_path = cwd <> "/priv/truck_data.csv"

# case Download.from(truck_data_url, [path: truck_data_save_path]) do
case {:ok, truck_data_save_path} do
  {:ok, path} ->
    process_row = fn row ->
      data_map = [
        {1, :truck_name},
        {2, :facility_type},
        {4, :location_description},
        {5, :address},
        {11, :food_items},
        {14, :latitude},
        {15, :longitude},
        {17, :days_hours}
      ]

      keep_cols = Enum.map(data_map, fn {index, _column} -> index end)

      add_index = fn elem, index ->
        {index, elem}
      end

      keep_col? = fn {index, _elem} ->
        Enum.member?(keep_cols, index)
      end

      find_key = fn {index, data_map_index, _key} ->
        data_map_index == index
      end

      set_attr = fn {index, value}, acc ->
        {_data_map_index, key} = Enum.find(index, data_map, find_key)
        Map.put(acc, key, value)
      end

      row
      |> Enum.with_index(add_index)
      |> Enum.filter(keep_col?)
      |> Enum.reduce(%{}, set_attr)
    end

    path
    |> File.stream!()
    |> CSVParser.parse_stream()
    |> Stream.map(process_row)
    |> Enum.take(1)
    |> IO.inspect()

  {:error, reason} ->
    IO.inspect("Downloading Truck data failed. :#{reason}")
end
