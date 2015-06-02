module Bowling
  class Game
    def initialize
      last_frame = nil
      @frames = Array.new(10) do |i|
        frame = Frame.new(i+1)
        last_frame.next_frame = frame if last_frame
        last_frame = frame
        frame
      end
      @active_frame = 0
    end

    def play!(rolls)
      rolls.each{|r| self.roll!(r) }
    end

    def to_s
      total = 0
      @frames.map do |f|
        total += f.score
        f.to_s + "\t#{total}"
      end.join("\n")
    end
  
    protected

    def roll!(pins)
      if frame = @frames[@active_frame]
        frame.roll!(pins)
        @active_frame += 1 if frame.done?
      end
    end
  end

end
