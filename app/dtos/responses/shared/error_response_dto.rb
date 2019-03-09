class ErrorResponseDto < BaseResponseDto
  def initialize(messages)
    super(false, messages)
  end
end