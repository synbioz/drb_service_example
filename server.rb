require "drb"
require_relative "drb_observable"

# Random prices generator
class MockPrice

  MIN = 500
  RANGE = 300

  def initialize(identifier)
    @price = RANGE / 2
  end

  def price
    @price += (rand() - 0.5) * RANGE


    @price = -@price if @price < 0
    @price = 2 * RANGE - @price if @price >= RANGE

    MIN + @price
  end

end

# Ticker to fetch price periodically
class Ticker

  include DRbObservable

  def initialize(price_feed)
    @feed = price_feed
    Thread.new { run }
  end

  def run
    last_price = nil

    loop do
      price = @feed.price
      puts "Current price: #{price}"

      if price != last_price
        last_price = price
        notify_observers(Time.now, price)
      end

      sleep 1
    end
  end
end


ticker = Ticker.new(MockPrice.new(:awesome_guitar))

DRb.start_service("druby://localhost:4000", ticker)

puts "Server running at #{DRb.uri}."
puts "Press Ctrl-C to exit."

trap("INT") { DRb.stop_service }
DRb.thread.join
