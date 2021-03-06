class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :role, default: "Customer"
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
