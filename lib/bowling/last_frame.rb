module Bowling
  class LastFrame < Frame

    def initialize(index)
      @frame_number = 10
      @rolls = []
    end

    def score
      @rolls.reduce(:+) || 0
    end

    def last_frame?
      @frame_number == 10
    end

    def done?
      (@rolls.length == 2 && @rolls[0] + @rolls[1] < 10) ||
       @rolls.length == 3
    end

    def strike_bonus
      @rolls[0] + @rolls[1]
    end

    def spare_bonus
      @rolls[0]
    end

    def to_s
      output = [@frame_number]

      if @rolls[0] == 10
        output.push(STRIKE)
        if @rolls[1] == 10
          output.push(STRIKE)
          @rolls[2] == 10 ? STRIKE : @rolls[2]
        elsif @rolls[1] + @rolls[2] == 10
          output.push(SPARE)
        else
          output.push(@rolls[1])
          output.push(@rolls[2])
        end
      elsif @rolls[0] + @rolls[1] == 10
        output.push(@rolls[0])
        output.push(SPARE)
        output.push(@rolls[2] == 10 ? STRIKE : @rolls[2])
      else
        output.push(@rolls[0])
        output.push(@rolls[1])
      end

      output.join("\t")
    end

  end

end

