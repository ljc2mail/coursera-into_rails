#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_accessor :highest_wf_count
  attr_accessor :highest_wf_words
  attr_accessor :content
  attr_accessor :line_number
  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result


  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize (content, line_number)
    @content = content
    @line_number = line_number 
    self.calculate_word_frequency  
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency
    wf = {}
    @highest_wf_count = 0
    @content.downcase.split.each do |word|
      if wf[word] == nil
        wf[word] = 1
      else
        wf[word] += 1
      end
      @highest_wf_count = wf[word] if wf[word] > @highest_wf_count
    end
    @highest_wf_words = [];
    wf.each_pair do |key, value| 
      if value == @highest_wf_count
        @highest_wf_words << key
      end
    end
  end#calculate_word_frequency

end#LineAnalyzer

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  attr_accessor :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  def initialize
    @analyzers = []
    #self.analyze_file
    #self.calculate_line_with_highest_frequency
    #self.print_highest_word_frequency_across_lines
  end
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file
    File.foreach("test.txt") do |line|
      @analyzers << line.chomp
    end
  end
  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency()
    line_number = 1
    @highest_count_across_lines = 0
    @analyzers.each do |line|
      cur_line = LineAnalyzer.new(line, line_number)

      if cur_line.highest_wf_count > @highest_count_across_lines
        @highest_count_across_lines = cur_line.highest_wf_count

        #@highest_count_words_across_lines = {}
        @highest_count_words_across_lines = []
        @highest_count_words_across_lines << cur_line
      elsif cur_line.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines << cur_line
      #else
      end
      line_number += 1
    end
    #puts @highest_count_words_across_lines
  end
  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line|
      print line.highest_wf_words
      print " appears in line#"
      puts line.line_number
    end
  end
end
