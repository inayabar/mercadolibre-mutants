class Dna <ApplicationRecord
  validates :dna_hash, uniqueness: true, presence: true
  after_create :update_stats

  def self.create_if_not_exists(dna, is_mutant)
    dna_hash = Digest::SHA1.hexdigest(dna.to_s)
    self.create(dna_hash: dna_hash, alien: is_mutant)
  end

  def update_stats
    Stats.recalculate(self)
  end
end
