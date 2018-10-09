class DnaChecker
  attr_accessor :dna
  alias rows dna
  SUPPORTED_LETTERS = %w[A T C G].freeze

  def is_mutant?(dna)
    self.dna = dna.map { |row| row.split('') } # Convert array of strings to matrix and assign to instance variable
    raise DnaCheckerErrors::NotSquareMatrix unless valid_matrix?
    raise DnaCheckerErrors::InvalidLetters unless valid_letters_in_matrix?

    invalid_sequence_count > 1
  end

  def invalid_sequence_count
    # Obtain rows, columns and diagonals and count how many alien patterns appear
    (columns + rows + diagonals).count do |array|
      contains_invalid_pattern(array)
    end
  end

  def columns
    columns = []
    dna.size.times do |i|
      columns << dna.map { |row| row[i] }
    end
    columns
  end

  def diagonals
    # Left to right and right to left diagonals
    obtain_diagonals + obtain_diagonals(reverse: true)
  end

  def obtain_diagonals(reverse: false)
    # Reverse implies if the diagonals being obtained are from left to right or viceversa
    dna = reverse ? self.dna.map(&:reverse) : self.dna
    diagonals = []
    already_analized = []
    dna.each_with_index do |row, row_index|
      row.each_with_index do |_element, element_index|
        next if already_analized.include?([row_index, element_index]) # Avoid counting a position already included in a diagonal

        diagonal = []
        (dna.size - row_index).times do |n|
          i = row_index + n
          j = element_index + n
          break if j >= dna.size # Stop check for this element if trespassing boundaries of the matrix

          already_analized << [i, j]
          diagonal << dna[i].try(:[], j)
        end
        diagonals << diagonal.compact
      end
    end
    diagonals.reject { |d| d.blank? || d.size < 4 } # Reject diagonals that cant have alien patter
  end

  def contains_invalid_pattern(array)
    array = array.join('')
    SUPPORTED_LETTERS.map { |l| l * 4 }.any? do |pattern|
      array.include? pattern
    end
  end

  def valid_matrix?
    dna.all? { |row| row.size == dna.size }
  end

  def valid_letters_in_matrix?
    dna.all? { |row| row.all? { |letter| letter.in? SUPPORTED_LETTERS } }
  end
end
