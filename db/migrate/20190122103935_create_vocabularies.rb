class CreateVocabularies < ActiveRecord::Migration[5.2]
  def change
    create_table :vocabularies do |t|
      t.string :part_of_speech
      t.string :vocab
      t.string :pronunciation
      t.integer :user_id

      t.timestamps
    end
  end
end
