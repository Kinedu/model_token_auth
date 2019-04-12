class CreateDummyOnes < ActiveRecord::Migration[5.2]
  def change
    create_table :dummy_ones do |t|

      t.timestamps
    end
  end
end
