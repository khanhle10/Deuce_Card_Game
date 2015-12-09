class MessagesController < ApplicationController

    @@PUBLIC_CHANNEL = 'publicChannel';
    @@MESSAGE_RECEIVED = 'messageReceived';
    before_filter :authenticate_user!

    def send_message
      # Find out the user's name
      user = User.find(params[:senderId])
      user_name = user[:name]

      # Wrap up the data that we want to send out
      message =
        {
          :sender_id => params[:senderId],
          :sender_name => user_name,
          :sender_message => params[:senderMessage],
          :time_sent => params[:timeSent]
        }

      # Trigger the Pusher
      Pusher.trigger(@@PUBLIC_CHANNEL, @@MESSAGE_RECEIVED, message)

      render nothing: true
    end

    def create
      @conversation = Conversation.find(params[:conversation_id])
      @message = @conversation.messages.build(message_params)
      @message.user_id = current_user.id
      @message.save!

      @path = conversation_path(@conversation)
    end

    private

    def message_params
      params.require(:message).permit(:body)
    end
  end
