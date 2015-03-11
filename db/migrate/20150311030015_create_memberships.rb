class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :project_id, null: false
      t.integer :user_id, null: false
      t.integer :role
    end
  end
end
