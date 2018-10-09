class CreateTableStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.integer :count_mutant_dna, default: 0
      t.integer :count_human_dna, default: 0
    end
  end
end
