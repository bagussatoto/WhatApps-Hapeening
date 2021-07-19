require 'nokogiri'
require 'watir-webdriver'

desc "Adds events"
task add_events: :environment do
  browser = Watir::Browser.new :phantomjs
  browser.goto 'http://www.experiencecolumbus.com/event-search?keyword=&sdate=&edate=&free=&cat=9&start=1'

  link = browser.link text: 'Weekend'
  link.click

  button = browser.button(class: 'btn', value: 'Search')
  button.click

  sleep 5

  @doc = Nokogiri::HTML.parse(browser.html)
  scrapedInfo = Array.new

  title = @doc.css(".results").css("li").each do |node|
    scrapedInfo.push(node)
  end

  scrapedInfo.each do |node|
    if !node.css('h3').text.empty? then
      name = node.css('h3').text
      location = location = node.css('h4').text
      location = location + ", " + node.css('ul > li > a').text

      start_date = DateTime.strptime(node.css('.dtstart').text, '%m-%d-%Y')
      end_date = DateTime.new

      page = node.css('h3 > a')
      link = 'http://www.experiencecolumbus.com/' + page[0]['href']

      if node.css('.dtend').text.empty? then
        end_date = start_date
      else
        end_date = Date.strptime(node.css('.dtend').text, '%m-%d-%Y')
      end

      if Event.where(name: name, location: location).empty?
        Event.create(
          name: node.css('h3').text,
          location: location,
          start_date: start_date,
          end_date: end_date,
          link: link
        )
      end
    end
  end
end
