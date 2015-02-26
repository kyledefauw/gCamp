class CreateCatsAndToys < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.timestamps
    end

    create_table :toys do |t|
      t.string :name
      t.belongs_to :cat
      t.timestamps
    end
  end
end
