class BaseResponseDto
  attr_accessor :success
  attr_accessor :full_messages

  def initialize(success, messages)
    @success = success
    if not messages.nil? and messages.instance_of? Array
      @full_messages = messages
    elsif not messages.nil? and messages.instance_of? String
      @full_messages = [messages]
    end
  end
end
