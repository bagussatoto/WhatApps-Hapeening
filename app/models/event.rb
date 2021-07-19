class Event < ActiveRecord::Base
  before_create :shorten_link

  def current?
    range = self.start_date..self.end_date
    now = Date.today
    range.cover?(now) or now < self.start_date
  end

  def self.current
    Event.all.sort_by{ :start_date }.select{ |event| event.current? }
  end

  def self.last_three
    Event.current.last(3)
  end

  def self.last_five
    Event.current.last(5)
  end

  def to_string
    name = self.name
    link = self.link

    "#{name}\n#{link}"
  end

  def self.humanize_date(date)
    date.strftime("%m/%d/%y")
  end

  private

  def shorten_link
    Bitly.use_api_version_3

    Bitly.configure do |config|
      config.api_version = 3
      config.access_token = ENV['BITLYAPI']
    end

    bitly = Bitly.client.shorten(self.link)

    self.link = bitly.short_url
  end
end
