json.extract! choice, :id, :name, :url, :selected, :price, :created_at, :updated_at
json.url choice_url(choice, format: :json)