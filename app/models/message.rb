class Message < ActiveRecord::Base

  validates_presence_of :body, :message => 'message.body.blank'
end
