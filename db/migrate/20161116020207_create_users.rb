class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :pasword
      t.string :wins
      t.string :losses
      t.string :records
      t.string :songs
    end
  end
end
