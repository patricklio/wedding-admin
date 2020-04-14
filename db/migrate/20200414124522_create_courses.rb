class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :author
      t.string :photo

      t.timestamps
    end
  end
end
