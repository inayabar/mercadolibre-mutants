RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "shared dna examples", :shared_context => :metadata do
  let(:non_mutant_dna) do
    %w[ATGCGA
       CAGTGC
       TTATTT
       AGACGG
       GCGTCA
       TCACTG]
  end
  let(:mutant_dna) do
    %w[ATGCGA
       CAGTGC
       TTATTT
       AGAAGT
       GCGTCA
       TCCCCG]
  end
  let(:other_mutant_dna) do
    %w[ATGCGA CAGTGC TTATGT AGAAGG CCCCTA TCACTG]
  end
  let(:diagonally_mutant_dna) do
    # Dna with one right to left and one left to right diagonal pattern
    %w[ATGCGA
       CAGGGC
       TTGTGT
       AGAAGG
       CTCCTA
       TCACTG]
  end
  let(:non_square_dna) { %w[A ATG GAC] }
  let(:invalid_letters_dna) { %w[XYZ ATG GAC] }
end

RSpec.configure do |rspec|
  rspec.include_context "shared dna examples", :include_shared => true
end
