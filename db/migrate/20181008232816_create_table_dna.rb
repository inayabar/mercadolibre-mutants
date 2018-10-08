class CreateTableDna < ActiveRecord::Migration[5.1]
  def change
    create_table :dnas do |t|
      t.string :dna_hash, unique: true
      t.boolean :alien
    end
  end
end
