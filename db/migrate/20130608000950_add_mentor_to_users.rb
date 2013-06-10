class AddMentorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_mentor, :boolean
    add_column :users, :wants_mentor, :boolean
  end
end
