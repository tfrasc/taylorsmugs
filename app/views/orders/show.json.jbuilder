json.extract! @order, :id, :name, :phone, :email, :photo, :message, :paid, :method, :review, :created_at, :updated_at
json.checkout_id @checkout_id
json.checkout_uri @checkout_uri
