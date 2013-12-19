json.array!(@charges) do |charge|
  json.extract! charge, :id, :amount, :comment, :description, :icon
  json.url charge_url(charge, format: :json)
end
