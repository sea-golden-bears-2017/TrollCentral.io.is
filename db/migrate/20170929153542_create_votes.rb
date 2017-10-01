class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user, index: true
      t.integer :value
      t.references :voteable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
