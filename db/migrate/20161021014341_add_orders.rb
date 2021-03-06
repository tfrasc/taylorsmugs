class AddOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string "name"
      t.string "phone"
      t.string "email"
      t.string "details"
      t.string "product", default: "mug"
      t.integer "price", default: 20
      t.boolean "paid", default: false
      t.boolean "delivered", default: false
      t.string "method"
      t.string "review"
      t.boolean "featured", default: false

      t.has_attached_file :photo
      t.has_attached_file :customer_photo

      t.timestamps
    end
  end
end
