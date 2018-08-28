class StatsRevisionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "stats_revision"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
