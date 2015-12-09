class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chat_message = Conversation.new
  end

 def create
   @chat_message = Conversation.new(params[:chat_message])

   Pusher.trigger('chat', 'new_message',{name: @chat_message.name, message: @chat_message.message
     }, {socket_id: params[:socket_id]})
   respond_to :js
 end
end
