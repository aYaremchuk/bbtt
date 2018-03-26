class NewPostNotificationJob < ApplicationJob
  queue_as :default

  def perform(post)
    post.groups.each do |group|
      group.users.each do |user|
        NewPostNotificationMailer.notification(post, user).deliver
      end
    end
  end
end
