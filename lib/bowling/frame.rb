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

    def last_frame?
      @frame_number == 10
    end

    def done?
      (!last_frame? && (is_strike? || @rolls.length == 2)) ||
      (last_frame? && @rolls.length == 2 && !(is_strike? || is_spare?)) ||
      (last_frame? && @rolls.length == 3)
    end

    def to_s
      output = [@frame_number, is_strike? ? 'X' : @rolls[0]]

      second_roll = if last_frame? && is_strike?(@rolls[1])
                      'X'
                    else #is_spare? is false if this is the last frame
                      is_spare? ? '/' : @rolls[1]
                    end
      output.push(second_roll)

      return output.join("\t") unless last_frame? && @rolls[2]

      third_roll = if is_strike?(@rolls[2])
                     'X'
                   elsif !is_strike?(@rolls[1]) && is_spare?(@rolls[1], @rolls[2])
                     '/'
                   else
                     @rolls[2]
                   end
      output.push(third_roll)

      output.join("\t")
    end

    protected

    def is_strike?(roll=nil)
      roll ||= first_ball
      roll == 10
    end

    def is_spare?(roll_1=nil, roll_2=nil)
      roll_1 ||= first_ball
      roll_2 ||= @rolls[1]

      !is_strike?(roll_1) && roll_1 + roll_2 == 10
    end

    def first_ball
      @rolls[0] || 0
    end
    
    def second_ball
      if is_strike? && !last_frame?
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
      if last_frame?
        @rolls[1..2].compact.reduce(:+) || 0
      elsif @next_frame
          @next_frame.first_ball + @next_frame.second_ball
      else
        0
      end
    end
  end

end
