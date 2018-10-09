require 'rails_helper'
describe DnaChecker do
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

  describe 'is_mutant?' do
    context 'when the dna does not contain mutant matching pattern' do
      it 'returns false' do
        expect(DnaChecker.new.is_mutant?(non_mutant_dna)).to be(false)
      end
    end

    context 'when the dna contains a mutant matching pattern' do
      it 'returns true' do
        checker = DnaChecker.new
        expect(checker.is_mutant?(mutant_dna)).to be(true)
        expect(checker.is_mutant?(other_mutant_dna)).to be(true)
        expect(checker.is_mutant?(diagonally_mutant_dna)).to be(true)
      end
    end

    context 'when the dna matrix is not square' do
      it 'raises NonSquareMatrixError' do
        expect do
          DnaChecker.new.is_mutant?(non_square_dna)
        end.to raise_error(DnaCheckerErrors::NotSquareMatrix)
      end
    end

    context 'when the dna matrix contains invalid letters' do
      it 'raises InvalidLettersError' do
        expect do
          DnaChecker.new.is_mutant?(invalid_letters_dna)
        end.to raise_error(DnaCheckerErrors::InvalidLetters)
      end
    end
  end
end
