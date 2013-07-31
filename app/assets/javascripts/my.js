function completeFilters(){
	chain_to_keep = "";
	chain_to_remove = "";
	$('#container').children().each(function(){
		if ( $(this).hasClass('blueTile') ){
			chain_to_keep = chain_to_keep + $.trim($(this).text());
		} else if ( $(this).hasClass('redTile') ){
			chain_to_remove = chain_to_remove + $.trim($(this).text());
		}
	});
	$('#chain_chain_to_keep').attr('value', $.trim(chain_to_keep.toLowerCase()));
	$('#chain_chain_to_remove').attr('value', $.trim(chain_to_remove.toLowerCase()));

}
function reset(){
	$('#container').children().each(function(){
		$(this).addClass('normalTile');
		$(this).removeClass('blueTile');
		$(this).removeClass('redTile');
	});
	$('#chain_chain_to_keep').attr('value', '');
	$('#chain_chain_to_remove').attr('value', '');
}

var inputNewGame;
function constructNewGame(){
	var x = 0;
	var y = 0;
	var container = $('#container');
	var text = $.trim(inputNewGame.val()).toUpperCase().split('');
	var limit = 25;
	if(text.length < limit){
		limit = text.length;
	}
	for(var i = 0 ; i < limit ; i ++){
		container.append('<div class="normalTile tile" + style="left:' 
		+ x + 'px; top: ' + y + 'px;"> ' + text[i]+ '</div');
		x += 50;
		if(x == 250){
			x = 0;
			y += 50;
		}		
	}
} 
function colorTiles(array_of_letters){
	$('#container').children().each(function(){
		$(this).addClass('normalTile');
		$(this).removeClass('blueTile');
		$(this).removeClass('redTile');
		for(i = 0 ; i < array_of_letters.length ; i ++){
			if($.trim($(this).text()) == array_of_letters[i]){
				$(this).addClass('blueTile');
				$(this).removeClass('normalTile');
				array_of_letters[i] = 0;
				i = 50;
			}
		}
	});	
}
$(document).ready(function(){
	inputNewGame = $("#new-game");
	constructNewGame()
	inputNewGame.keyup(function(){
		constructNewGame();
	});
	$("#resetButton").click(function(){
		reset();
	});
	colorTiles($.trim($('#chain_chain_to_keep').attr('value')).toUpperCase().split(''))
	$('.accordion-toggle').click(function(){
		colorTiles($.trim($(this).text()).toUpperCase().split(''));			
	});
	$('.tile').click(function(){
		if ( $(this).hasClass('blueTile') ){
			$(this).addClass('redTile');
			$(this).removeClass('normalTile');
			$(this).removeClass('blueTile');
		} else if ( $(this).hasClass('redTile') ){
			$(this).addClass('normalTile');
			$(this).removeClass('redTile');
			$(this).removeClass('blueTile');
		}else {
			$(this).addClass('blueTile');
			$(this).removeClass('normalTile');
			$(this).removeClass('redTile');
		}
		completeFilters();
	});
	$('.play').click(function(){
		$('#word-to-be-played').attr('value', $(this).attr('id'));
	})
});
