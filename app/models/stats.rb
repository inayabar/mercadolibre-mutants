class Stats < ApplicationRecord
  def self.recalculate(new_dna)
    # Check which count to update and delegate concurrency management to database
    updated_field = new_dna.alien ? 'count_mutant_dna' : 'count_human_dna'
    command = "UPDATE stats SET #{updated_field} = #{updated_field} + 1 \
               WHERE id = #{self.last.id} RETURNING #{updated_field}"
    self.connection.execute(command)
  end

  def self.obtain_last
    self.last.format_with_ratio
  end

  def format_with_ratio
    {
      'count_human_dna': count_human_dna,
      'count_mutant_dna': count_mutant_dna,
      'ratio': count_mutant_dna / count_human_dna.to_f
    }
  end
end
