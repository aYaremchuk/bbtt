require 'rails_helper'

describe NewPostNotificationJob do
  it { is_expected.to be_processed_in(:default) }
end
