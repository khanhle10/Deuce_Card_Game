var PRIVATE_CHANNEL = 'privateChannel';
var MESSAGE_RECEIVED = 'messageReceived';
var SEND_MESSAGE_ENDPOINT = '/messages/sendMessage';
var CHATBOX_WINDOW = '#chatbox';
var CHATBOX_MESSAGE_AREA = '#messagesArea';
var CHATBOX_MESSAGE_INPUT_BOX = '#messageInputBox';

var pusher;

$(document).ready(function() {

    pusher = new Pusher('Pusher.key');

    // Subscribe this user to the private channel
    var privateChannel = pusher.subscribe(PRIVATE_CHANNEL);
    privateChannel.bind(MESSAGE_RECEIVED, function(data) {
        console.log(data);
        var senderId = data["sender_id"];
        var senderName = data["sender_name"];
        var senderMessage = data["sender_message"];
        var timeSent = data["time_sent"];

        // Append to the chatbox
        var messageHtml =
            '<div class="message">' +
                '<span class="senderName">' + senderName +
                '</span>' +
                '<span class="senderMessage">' + senderMessage +
                '</span>' +
                '<span class="messageTime">' + timeSent +
                '</span>' +
            '</div>'
        $(CHATBOX_WINDOW + " " + CHATBOX_MESSAGE_AREA).append(messageHtml);
    });
});

// Send a message out to other users
// @param senderId - The user ID of the sender, can be obtained
//                   from the html.erb file by using
//                   sendMessage(<%= current_user[:id] %>)
function sendMessage(senderId) {

    console.log("Sending message...");

    // Get the message from the input box
    var message = $(CHATBOX_MESSAGE_INPUT_BOX).val();
  //  var message = document.getElementById("#messageInputBox").value;

    var d = new Date();

    var timeNow = d.getDate() + "/" + d.getMonth() + "/" + d.getFullYear() +
                  " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();

    console.log(message);
    console.log(timeNow);
    console.log(senderId);
    console.log("data is ready");

    $.ajax({
        url: SEND_MESSAGE_ENDPOINT,
        type: 'POST',
        dataType:"json",
        contentType:"application/json",
        data: JSON.stringify(
            {
                "senderId": senderId,
                "senderMessage": message,
                "timeSent": timeNow
            }
        )
    });
}
