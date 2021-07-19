class MessagesController < ApplicationController
  def forward
    sender = params["From"]
    message = params["Body"]

    @client = Twilio::REST::Client.new ENV['TWILIOSID'], ENV['TWILIOTOKEN']

    keyword = message.split.first.downcase
    body = ""

    case keyword
    when "events"
      body = "Here are some events:\n\n"

      Event.last_five.each do |event|
        body = body + event.to_string + "\n\n"
      end
    when "help"
      body = "Text \"EVENTS\" to see the latest events"
    else
      body = "Sorry, I couldn't figure out what you were trying to say!\n" +
        "Try: EVENTS or HELP"
    end

    @client.messages.create(
      from: ENV['TWILIOPHONE'],
      to: sender,
      body: body
    )

    render nothing: true
  end
end
