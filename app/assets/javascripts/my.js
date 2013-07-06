$(document).ready(function(){
	$('.accordion-toggle').click(function(){
		array_of_letters = $.trim($(this).text()).toUpperCase().split('');
		$('#container').children().each(function(){
			$(this).addClass('normalTile');
			$(this).removeClass('blueTile');
			for(i = 0 ; i < array_of_letters.length ; i ++){
				if($.trim($(this).text()) == array_of_letters[i]){
					$(this).addClass('blueTile');
					$(this).removeClass('normalTile');
					array_of_letters[i] = 0;
					i = 50;
				}
			}
		});		
	});
});
