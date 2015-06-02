module Bowling
  class Frame
    def initialize(index)
      @frame_number = index
      @rolls = []
    end

    def next_frame=(frame)
      @next_frame = frame
    end

    def roll!(pins)
      raise "This frame is done, can't add more balls" if self.done?
      @rolls.push(pins.to_i)
    end

    def score
      # TODO: handle last frame
      if is_strike?
        10 + self.next_two_balls
      elsif is_spare?
        10 + self.next_ball
      else
        @rolls.reduce(:+) || 0
      end
    end

    def done?
      if (@frame_number < 10 && (@rolls[0] == 10 || @rolls.length == 2)) ||
          (@frame_number == 10 && @rolls.length == 2 && !(self.is_spare? || self.is_strike?))
        true
      else
        false
      end
    end

    def to_s
      if @frame_number == 10 && @rolls[1] == 10
        second_roll = 'X'
      else
        second_roll = self.is_spare? ? '/' : @rolls[1]
      end
      [@frame_number,
       self.is_strike? ? 'X' : @rolls[0],
       second_roll,
       @rolls[2] && @rolls[2] == 10 ? 'X' : (@rolls[2] || ""),
      ].join("\t")
    end

    protected

    def is_strike?
      first_ball == 10
    end

    def is_spare?
      !self.is_strike? && first_ball + @rolls[1] == 10
    end

    def first_ball
      @rolls[0] || 0
    end
    
    def second_ball
      if is_strike? && @frame_number != 10
        @next_frame.first_ball
      else
        @rolls[1] || 0
      end
    end

    # Used for spares
    def next_ball
      if @frame_number == 10
        @rolls[2]
      else
        @next_frame.first_ball
      end
    end

    # used for strikes
    def next_two_balls
      if @frame_number == 10
        @rolls[1..2].compact.reduce(:+) || 0
      elsif @next_frame
          @next_frame.first_ball + @next_frame.second_ball
      else
        0
      end
    end
  end

end
