class Conversation < ActiveRecord::Base
  include ActiveModel::Model
  attr_accessor :name, :message
end
