# frozen_string_literal: true

class InlineEditChannel < ApplicationCable::Channel
  STREAM_NAME = "inline_edit"

  def subscribed
    stream_from(STREAM_NAME)
  end
end
