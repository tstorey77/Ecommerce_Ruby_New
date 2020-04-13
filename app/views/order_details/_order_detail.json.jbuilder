json.extract! order_detail, :id, :Cards_id, :Order_id, :created_at, :updated_at
json.url order_detail_url(order_detail, format: :json)
