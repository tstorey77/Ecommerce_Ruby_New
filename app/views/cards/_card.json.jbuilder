json.extract! card, :id, :name, :card_type, :description, :attack, :defence, :price, :created_at, :updated_at
json.url card_url(card, format: :json)
