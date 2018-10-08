class DnaSaveJob < ApplicationJob
  queue_as :dna_savers

  def perform(dna, is_mutant)
    Dna.create_if_not_exists(dna, is_mutant)
  end
end
