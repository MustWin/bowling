module Bowling
  class Frame

    STRIKE = 'X'
    SPARE = '/'

    def initialize(index)
      @frame_number = index
      @rolls = []
    end

    def next_frame=(frame)
      @next_frame = frame
    end

    def roll!(pins)
      raise "This frame is done, can't add more balls" if done?
      @rolls.push(pins.to_i)
    end

    def score
      if strike?
        10 + @next_frame.strike_bonus
      elsif spare?
        10 + @next_frame.spare_bonus
      else
        @rolls.reduce(:+) || 0
      end
    end

    def strike_bonus
      strike? ? 10 + @next_frame.spare_bonus : @rolls.reduce(:+)
    end

    def spare_bonus
      @rolls[0]
    end

    def last_frame?
      @frame_number == 10
    end

    def done?
      strike? || @rolls.length == 2
    end

    def to_s
      output = [@frame_number]

      if strike?
        output.push(STRIKE)
      else
        output.push(@rolls[0])
        output.push(spare? ? SPARE : @rolls[1])
      end

      output.join("\t")
    end

    protected

    def strike?
      @rolls[0] == 10
    end

    def spare?
      !strike? && @rolls.reduce(:+) == 10
    end

  end

end
