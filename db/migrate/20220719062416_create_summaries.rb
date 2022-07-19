class CreateSummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :summaries do |t|
      t.text :content

      t.timestamps
    end
  end
end
