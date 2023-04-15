NimbleCSV.define(CSVParser, separator: ",", escape: "\"")

alias PunchyApi.{User, Truck, Operation, Repo}

[truck_data_url: _truck_data_url] = Application.get_env(:punchy_api, :data)
{:ok, cwd} = File.cwd()
truck_data_save_path = cwd <> "/priv/truck_data.csv"

defmodule RowProcessor do
  def process_row(row) do
    data_map = [
      {0, :location_id},
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
    try do
      %{
        truck_name: truck_name,
        food_items: food_items,
        location_id: location_id,
        latitude: latitude,
        longitude: longitude
      } = data

      username = "#{truck_name} Owner"

      IO.inspect("DATA")
      IO.inspect(data)

      Repo.transaction(fn ->
        truck_owner =
          case Repo.get_by(User, username: username) do
            nil ->
              created_truck_owner =
                case User.create_user(%{username: username}) do
                  {:ok, user} -> user
                  _ -> nil
                end

              created_truck_owner

            user ->
              user
          end

        IO.inspect("TRUCK OWNER")
        IO.inspect(truck_owner)

        truck =
          case [Repo.get_by(Truck, name: truck_name), truck_owner] do
            [nil, nil] ->
              nil

            [nil, truck_owner] ->
              case Truck.create_truck(%{
                     name: truck_name,
                     card_punches: 5,
                     card_reward: "Free drink!",
                     food_items: food_items,
                     user_id: truck_owner.id
                   }) do
                {:ok, truck} ->
                  truck

                _ ->
                  nil
              end
            [truck, _] ->
              truck
          end

        IO.inspect("TRUCK")
        IO.inspect(truck)

        case truck do
          nil ->
            nil

          truck ->
            Operation.create_operation(%{
              location_id: location_id,
              latitude: latitude,
              longitude: longitude,
              truck_id: truck.id
            })
        end
      end)
    rescue
      e ->
        IO.inspect("ABORTED")
        IO.inspect(e)
        # IO.inspect(data)
    end
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
