var game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update });

function preload() {

	//load environment 
	game.load.image('background', 'background.png');
	game.load.image('playbtn', 'images/playbutton.png');
	game.load.image('passbtn', 'images/passbutton.png');
	game.load.image('dashboard', 'images/dashboard.png');

	//load card images
	game.load.image('card1', 'images/Card1.png');
	game.load.image('card2', 'images/Card2.png');
	game.load.image('card3', 'images/Card3.png');
	game.load.image('card4', 'images/Card4.png');
	game.load.image('card5', 'images/Card5.png');
	game.load.image('card6', 'images/Card6.png');
	game.load.image('card7', 'images/Card7.png');
	game.load.image('card8', 'images/Card8.png');
	game.load.image('card9', 'images/Card9.png');
	game.load.image('card10', 'images/Card10.png');
	game.load.image('card11', 'images/Card11.png');
	game.load.image('card12', 'images/Card12.png');
	game.load.image('card13', 'images/Card13.png');
	game.load.image('card14', 'images/Card14.png');
	game.load.image('card15', 'images/Card15.png');
	game.load.image('card16', 'images/Card16.png');
	game.load.image('card17', 'images/Card17.png');
	game.load.image('card18', 'images/Card18.png');
	game.load.image('card19', 'images/Card19.png');
	game.load.image('card20', 'images/Card20.png');
	game.load.image('card21', 'images/Card21.png');
	game.load.image('card22', 'images/Card22.png');
	game.load.image('card23', 'images/Card23.png');
	game.load.image('card24', 'images/Card24.png');
	game.load.image('card25', 'images/Card25.png');
	game.load.image('card26', 'images/Card26.png');
	game.load.image('card27', 'images/Card27.png');
	game.load.image('card28', 'images/Card28.png');
	game.load.image('card29', 'images/Card29.png');
	game.load.image('card30', 'images/Card30.png');
	game.load.image('card31', 'images/Card31.png');
	game.load.image('card32', 'images/Card32.png');
	game.load.image('card33', 'images/Card33.png');
	game.load.image('card34', 'images/Card34.png');
	game.load.image('card35', 'images/Card35.png');
	game.load.image('card36', 'images/Card36.png');
	game.load.image('card37', 'images/Card37.png');
	game.load.image('card38', 'images/Card38.png');
	game.load.image('card39', 'images/Card39.png');
	game.load.image('card40', 'images/Card40.png');
	game.load.image('card41', 'images/Card41.png');
	game.load.image('card42', 'images/Card42.png');
	game.load.image('card43', 'images/Card43.png');
	game.load.image('card44', 'images/Card44.png');
	game.load.image('card45', 'images/Card45.png');
	game.load.image('card46', 'images/Card46.png');
	game.load.image('card47', 'images/Card47.png');
	game.load.image('card48', 'images/Card48.png');
	game.load.image('card49', 'images/Card49.png');
	game.load.image('card50', 'images/Card50.png');
	game.load.image('card51', 'images/Card51.png');
	game.load.image('card52', 'images/Card52.png');

}

//button variable
var PlayBtn;
var PassBtn;


//card for each palyer
var Hand1 = [];
var Hand2 = [];
var Hand3 = [];
var Hand4 = [];

var deck = deck();
deck = shuffle(deck);
deal(deck);

//player variable
var Player1 = new player(1, Hand1);
var Player2 = new player(2, Hand2);
var Player3 = new player(3, Hand3);
var Player4 = new player(4, Hand4);

var curPlayer = 1;
var curPlayerText;
var card;

function create() {

	//ad background to screen
	game.add.sprite(0,0, 'background');
	console.log("background set!");

	var dashboard = game.add.sprite(0, 530, 'dashboard');
	dashboard.scale.setTo(0.4, 0.25);
	console.log("dashboard set!");


	//play button
	PlayBtn = game.add.button (695, 550, 'playbtn', play, this, 2, 1, 0); //(x, y, loaded-img, function)
	PlayBtn.name = 'playbtn';
	PlayBtn.scale.setTo(0.5, 0.5);

	//pass button
	PassBtn = game.add.button (30, 550, 'passbtn', pass, this, 2, 1, 0); 
	PassBtn.name = 'passbtn';
	PassBtn.scale.setTo(0.5, 0.5);


	//Texts
	curPlayerText = game.add.text(30, 20, "Current Player: " + curPlayer, {font: "22px Arial", fill: "#ffffff"});

	for(i = 0; i < 13; i++) {
		card = game.add.sprite(180 + i * 25,410, 'card' + Player1.hand[i].value);
		card.events.onInputDown.add(choose, this);
		card.inputEnabled = true;
		card.scale.setTo(0.5, 0.5);
	}

	

}

function update() {

}

//This function is called when a card is clicked
function choose() {
	
	console.log("choose: y = " + card.y);
	console.log("choose: key: " + card.key);

	if (card.y === 410) {
		card.y -= 20;
	} else if(card.y === 390) {
		card.y += 20;
	}
}



//This function is called when the PLAY button is called
function play(button) {
	console.log("play");
	nextPlayer();
}

//this function is called when the PASS button is called
function pass(button) {
	console.log("pass");
	nextPlayer();
}

//set the nextplayer
function nextPlayer() {
	curPlayer = curPlayer % 4 + 1;
	curPlayerText.text = "Current Player: " + curPlayer;
}

//======================== DECK DATA ========================//

//Card object
function card(value, num, suit) {
	this.value = value;
	this.num = num;
	this.suit = suit;
}

//Create Deck object using card object
function deck() {
	this.num = ['3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', '1', '2'];
	this.suits = ['Diamonds','Clubs','Hearts','Spades'];
	var cards = [];
	var n = 1;

	for(var i = 0; i < this.suits.length; i++) {
		for(var j = 0; j < this.num.length; j++) {
			cards.push(new card(n, this.num[j], this.suits[i]));
			n++;
		}
	}

	console.log("Deck created");
	return cards;
}
//======================== DECK DATA ========================//

//======================== DECK Maipulators ========================//

//shuffle the deck
function shuffle(deck) {
  var currentIndex = deck.length, temporaryValue, randomIndex ;

  // While there remain cards to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining card...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current card.
    temporaryValue = deck[currentIndex];
    deck[currentIndex] = deck[randomIndex];
    deck[randomIndex] = temporaryValue;
  }

  return deck;
}

//give all player 13 cards
function deal(deck) {
	
	var index = 0;

	for(var i = 0; i < 13; i++) {
		Hand1.push(deck[index]);
		index++;
	}
	for(i = 0; i < 13; i++) {
		Hand2.push(deck[index]);
		index++;
	}
	for(i = 0; i < 13; i++) {
		Hand3.push(deck[index]);
		index++;
	}
	for(i = 0; i < 13; i++) {
		Hand4.push(deck[index]);
		index++;
	}
}

//======================== DECK Maipulators ========================//

//======================== Player DATA ========================//
function player(id, hand) {
	this.id = id;
	this.hand = hand;
}
//======================== Player DATA ========================//