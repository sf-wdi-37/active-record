class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :first
      t.string :last
      t.string :email

      t.timestamps null: false
    end
  end
end
