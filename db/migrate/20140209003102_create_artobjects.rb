class CreateArtobjects < ActiveRecord::Migration
  def change
    create_table :artobjects do |t|
      t.string :name
      t.integer :user_id
      t.text :editors
      t.integer :day
      t.integer :month
      t.integer :year
      t.integer :minday
      t.integer :minmonth
      t.integer :minyear
      t.integer :maxday
      t.integer :maxmonth
      t.integer :maxyear
      t.boolean :approximatedate

      t.timestamps
    end
  end
end
