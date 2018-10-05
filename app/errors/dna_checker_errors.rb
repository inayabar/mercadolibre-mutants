module DnaCheckerErrors
  class Standard < StandardError; end
  class InvalidLetters < Standard
    def initialize(msg = 'The entered dna contains invalid characters')
      super
    end
  end

  class NotSquareMatrix < Standard
    def initialize(msg = 'The entered dna is not square (NxN)')
      super
    end
  end
end
