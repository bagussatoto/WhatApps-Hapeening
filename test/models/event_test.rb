require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "past events should not be current" do
    old_event = Event.new(start_date: Date.yesterday, end_date: Date.yesterday,
      location: "Columbus", name: "My Event", link: "google.com");
    assert_not old_event.current?
  end

  test "current events should be current" do
    current_event = Event.new(start_date: Date.today, end_date: Date.today,
      location: "Columbus", name: "My Event", link: "google.com");
    assert current_event.current?
  end

  test "future events should be current" do
    future_event = Event.new(start_date: Date.tomorrow, end_date: Date.tomorrow,
      location: "Columbus", name: "My Event", link: "google.com");
    assert future_event.current?
  end
end
