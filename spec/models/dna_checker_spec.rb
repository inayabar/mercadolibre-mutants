require 'rails_helper'
require 'shared_examples.rb'
describe DnaChecker do
  include_context "shared dna examples"
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
