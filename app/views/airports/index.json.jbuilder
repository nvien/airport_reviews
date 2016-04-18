json.array!(@airports) do |airport|
  json.extract! airport, :id, :name, :city, :IATA
  json.url airport_url(airport, format: :json)
end
