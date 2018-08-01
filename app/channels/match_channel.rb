class MatchChannel < ApplicationCable::Channel

  def subscribed
    reject unless match_id.present?
    stream_from "match_#{match_id}_room"
  end

  def unsubscribed
    user_not_reading
  end

  def away
    user_not_reading
  end

  private

  def user_not_reading
    match.update_user_last_online(current_user.id) if match.present?
  end

  def match
    match ||= match_id.present? ? Match.find(match_id) : nil
  end

  def match_id
    params[:id]
  end
end
