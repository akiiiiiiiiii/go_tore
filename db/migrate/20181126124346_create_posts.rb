class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body


      t.timestamps
    end
    add_column :posts, :user_id, :integer
    add_column :posts, :create_time, :timestamp
    add_column :posts, :update_time, :timestamp
    add_column :posts, :place, :string
    add_column :posts, :post_image_id, :string
  end
end
