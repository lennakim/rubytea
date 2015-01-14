class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :title
      t.string  :subtitle
      t.text    :body
      t.integer :limit_num
      t.string  :price
      t.string  :address
      t.datetime :start_at

      t.timestamps null: false
    end
  end
end
