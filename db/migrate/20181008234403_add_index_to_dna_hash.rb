class AddIndexToDnaHash < ActiveRecord::Migration[5.1]
  def change
    add_index :dnas, :dna_hash
  end
end
