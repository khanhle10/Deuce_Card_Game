function createGame(){var e=$("#roomName").val();$.ajax({url:"/deuces",type:"POST",dataType:"json",contentType:"application/json",data:JSON.stringify({roomName:e}),success:function(e){var s=pusher.subscribe(ROOM_CHANNEL+e.id);s.bind(PLAYER_JOINED,function(s){$("#players").load("/deuces/"+e.id+" #players")})}})}function joinGame(e){$.ajax({url:"/deuces/join/"+e,type:"POST",success:function(s){window.location="/deuces/"+e,pusher.unsubscribe(PRIVATE_CHANNEL);var a=pusher.subscribe(ROOM_CHANNEL+e);a.bind(PLAYER_JOINED,function(s){$("#players").load("/deuces/"+e+" #players")})}})}var ROOM_CHANNEL="deuce_",PLAYER_JOINED="playerJoined",ROOM_CREATED="roomCreated",pusher;$(document).ready(function(){pusher=new Pusher("f186c8947d4b1acc8fdf");var e=pusher.subscribe(PRIVATE_CHANNEL);e.bind(ROOM_CREATED,function(e){$("#gameList").load("/deuces/ #gameList")})});