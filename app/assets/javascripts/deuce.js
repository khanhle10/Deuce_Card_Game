# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
var ROOM_CHANNEL = "deuce_";
var PLAYER_JOINED = "playerJoined";
var ROOM_CREATED = "roomCreated";

var pusher

$(document).ready(function() {

    pusher = new Pusher("f186c8947d4b1acc8fdf");

    // Subscribe this user to the public channel
    var publicChannel = pusher.subscribe(PUBLIC_CHANNEL);
    publicChannel.bind(ROOM_CREATED, function(data) {
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
          window.location = "http://localhost:3000/deuces/"+id;
            pusher.unsubscribe(PUBLIC_CHANNEL);
            // Subscribe to pusher channel
            var channel = pusher.subscribe(ROOM_CHANNEL+id);
            channel.bind(PLAYER_JOINED, function(eventData) {
                // Refresh div
                $('#players').load('/deuces/'+id+' #players');
            });
        }
    });
}