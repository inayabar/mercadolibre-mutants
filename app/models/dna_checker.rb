require 'byebug'
class DnaChecker
  attr_accessor :dna
  SUPPORTED_LETTERS = %w[A T C G].freeze

  def is_mutant?(dna)
    self.dna = dna.map { |row| row.split('') } # Convierto el array de strings a matriz
    raise DnaCheckerErrors::NotSquareMatrix unless valid_matrix?
    raise DnaCheckerErrors::InvalidLetters unless valid_letters_in_matrix?

    invalid_sequence_count > 1
  end

  def invalid_sequence_count
    # Obtengo columnas, filas y diagonales, y cuento cuantas contienen un patron mutante
    (columns + dna + diagonals).count do |array|
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
    diagonals = []
    already_analized = []
    dna.each_with_index do |row, row_index|
      row.each_with_index do |_element, element_index|
        next if already_analized.include?([row_index, element_index]) # Evito volver a contar una posicion que ya fue incluida en una diagonal

        diagonal = []
        (dna.size - row_index).times do |n|
          i = row_index + n
          j = element_index + n
          break if j > dna.size

          already_analized << [i, j]
          diagonal << dna[i].try(:[], j)
        end
        diagonals << diagonal.compact
      end
    end
    diagonals.reject(&:blank?)
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
