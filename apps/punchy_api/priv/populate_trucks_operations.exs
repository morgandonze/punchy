NimbleCSV.define(CSVParser, separator: ",", escape: "\"")

alias PunchyApi.{User, Truck, Repo}

[truck_data_url: _truck_data_url] = Application.get_env(:punchy_api, :data)
{:ok, cwd} = File.cwd()
truck_data_save_path = cwd <> "/priv/truck_data.csv"

defmodule RowProcessor do
  def process_row(row) do
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

    set_attr = fn {index, value}, acc ->
      {_data_map_index, key} =
        Enum.find(data_map, fn {data_map_index, _key} ->
          data_map_index == index
        end)

      Map.put(acc, key, value)
    end

    row
    |> Enum.with_index(add_index)
    |> Enum.filter(keep_col?)
    |> Enum.reduce(%{}, set_attr)
  end

  def create_from_dataset(data) do
    %{
      truck_name: truck_name,
      food_items: food_items
    } = data

    Repo.transaction(fn ->
      with {:ok, user} <-
             %User{}
             |> User.changeset(%{
               username: "#{truck_name} Owner"
             })
             |> Repo.insert() do
        %Truck{}
        |> Truck.changeset(%{
          name: truck_name,
          card_punches: 5,
          card_reward: "Free drink!",
          food_items: food_items,
          user_id: user.id
        })
        |> Repo.insert()
      end
    end)

    # create User to own the Truck
  end
end

# case Download.from(truck_data_url, [path: truck_data_save_path]) do
case {:ok, truck_data_save_path} do
  {:ok, path} ->
    path
    |> File.stream!()
    |> CSVParser.parse_stream()
    |> Stream.map(&RowProcessor.process_row/1)
    |> Stream.each(&RowProcessor.create_from_dataset/1)
    |> Stream.run()

  # |> create_operation

  {:error, reason} ->
    IO.inspect("Downloading Truck data failed. :#{reason}")
end
