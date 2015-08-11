require "drb"

class Notification

  include DRbUndumped

  def initialize(ticker, limit)
    @limit = limit
    ticker.add_observer(self)
  end

end

class LowNotification < Notification

  def update(time, price)
    puts "Price below #{@limit}: #{price}" if price < @limit
  end

end

class HighNotification < Notification

  def update(time, price)
    puts "Price above #{@limit}: #{price}" if price > @limit
  end

end

DRb.start_service
ticker = DRbObject.new_with_uri("druby://localhost:4000")

LowNotification.new(ticker, 600)
HighNotification.new(ticker, 700)

puts "Press Ctrl-C to exit."

trap("INT") { exit }
gets
