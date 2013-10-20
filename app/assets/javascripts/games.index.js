var inputNewGame;
var container = $('#container');
function constructNewGame() {
	var x = 0;
	var y = 0;

	var text = $.trim(inputNewGame.val()).toUpperCase().split('');
	var newText = "";
	var limit = 25;
	container.empty();
	if (text.length < limit) {
		limit = text.length;
	}
	for (var i = 0; i < limit; i++) {
		if (text[i] >= 'A' && text[i] <= 'Z') {
			newText = newText + text[i];
			container.append('<div class="normalTile tile" + style="left:' + x + 'px; top: ' + y + 'px;"> ' + text[i] + '</div');
			x += 50;
			if (x == 250) {
				x = 0;
				y += 50;
			}
		}
	}
	inputNewGame.val(newText);
}


$(document).ready(function() {
	inputNewGame = $("#new-game");
	constructNewGame();
	inputNewGame.keyup(function() {
		constructNewGame();
	});
	inputNewGame.focusout(function() {
		constructNewGame();
	});

});

