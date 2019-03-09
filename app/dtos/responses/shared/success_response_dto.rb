class SuccessResponseDto < BaseResponseDto
  def initialize(messages)
    super true, messages
  end
end