var ROOM_CHANNEL = "deuce_";
var PLAYER_JOINED = "playerJoined";
var ROOM_CREATED = "roomCreated";

var pusher

$(document).ready(function() {


    pusher = new Pusher('a6c97e689cf9fd217899');

    // Subscribe this user to the private channel
    var privateChannel = pusher.subscribe(PRIVATE_CHANNEL);
    privateChannel.bind(ROOM_CREATED, function(data) {
        // Refresh div
        $('#gameList').load('/deuces/ #gameList');
    });
});

function createGame() {
    var roomName = $('#roomName').val();

    $.ajax({
        url: '/deuces',
        type: 'POST',
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(
            {
                "roomName": roomName
            }
        ),
        success: function(data) {
            // Subscribe to pusher channel
            var channel = pusher.subscribe(ROOM_CHANNEL+data["id"]);
            channel.bind(PLAYER_JOINED, function(eventData) {
                // Refresh div
                $('#players').load('/deuces/'+data["id"]+' #players');
            });
        }
    });
}

function joinGame(id) {
    $.ajax({
        url: '/deuces/join/'+id,
        type: 'POST',
        success: function(data) {
          window.location = "/deuces/"+id;
            pusher.unsubscribe(PRIVATE_CHANNEL);
            // Subscribe to pusher channel
            var channel = pusher.subscribe(ROOM_CHANNEL+id);
            channel.bind(PLAYER_JOINED, function(eventData) {
                // Refresh div
                $('#players').load('/deuces/'+id+' #players');
            });
        }
    });
}
function start_game(){
}
