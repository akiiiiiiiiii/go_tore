class AddEditToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduction, :text
    add_column :users, :birthday, :date
    # add_column :users, :age, :integer
    add_column :users, :gender_id, :string
    add_column :users, :blood_type_id, :string
    add_column :users, :birthplace, :string
    add_column :users, :residence, :string
    add_column :users, :history, :integer
    add_column :users, :homegym, :string
    add_column :users, :purpose, :string
    add_column :users, :good, :string
    add_column :users, :bad, :string
    add_column :users, :supplement, :string
    add_column :users, :status, :string
    add_column :users, :twitter, :string
    add_column :users, :instagram, :string
  end
end
