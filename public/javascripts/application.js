// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
 
    var counter = parseInt($("#count").val());
 
    $("#addButton").click(function () {
 
	counter++;
 
	var newTextBoxDiv = $(document.createElement('input'))
	
		
	newTextBoxDiv.attr({ 	type: "text",
							class: "tags_in",
							name: "tag_list" + counter,
							id: id="tag_list" + counter
	});

	newTextBoxDiv.appendTo("#TextBoxesGroup");
 
	$('#count').replaceWith('<input id="count" name="song[count]" type="hidden" value="' + counter + '" />');
	

     });
 
     $("#removeButton").click(function () {
	if(counter==0){
          alert("No more textbox to remove");
          return false;
       }   
	
        $("#tag_list" + counter).remove();
		
		counter--;
		$('#count').replaceWith('<input id="count" name="song[count]" type="hidden" value="' + counter + '" />');

     });
	 

	var artcounter = parseInt($("#artistcount").val());
 
    $("#addArtist").click(function () {
 
	artcounter++;
 
	var newTextBoxDiv = $(document.createElement('input'))
	
		
	newTextBoxDiv.attr({ 	type: "text",
							class: "artist_in", 
							name: "artist_list" + artcounter,
							id: id="artist_list" + artcounter
	});

	newTextBoxDiv.appendTo("#ArtistBoxesGroup");
 
	$('#artistcount').replaceWith('<input id="artistcount" name="song[artistcount]" type="hidden" value="' + artcounter + '" />');
	

     });
 
     $("#removeArtist").click(function () {
	if(artcounter==0){
          alert("No more textbox to remove");
          return false;
       }   
	
        $("#artist_list" + artcounter).remove();
		
		artcounter--;
		$('#artistcount').replaceWith('<input id="artistcount" name="song[artistcount]" type="hidden" value="' + artcounter + '" />');

     });
	 
	
	 

  });
$(function() {
				
		var song = $( "#song_name" ),
			lyric = $( "#song_lyric" ),
			artist = $( "#artist_list1" ),
			artistname = $( "#artist_name" ),
			artisttype = $( "#artist_artist_type" ),
			name = $( "#user_name"), 
			email = $( "#uesr_email"), 
			password = $("#user_password"),
			conpassword = $("#user_password_confirmation"),
			allFields = $( [] ).add( song ).add( lyric ).add(artist).add(artistname).add(artisttype).add(name).add(email).add(password).add(conpassword),
			tips = $( ".validateTips" );
			
		function updateTips( t ) {
			tips
				.text( t )
				.addClass( "ui-state-highlight" );
			setTimeout(function() {
				tips.removeClass( "ui-state-highlight", 1500 );
			}, 500 );
		}
	
		function checkEmpty( o, n ) {
			if ( o.val().length == 0 ) {
				o.addClass( "ui-state-error" );
				updateTips( n + " should not be empty." );
				return false;
			} else {
				return true;
			}
		}
		
		function checkRegexp( o, regexp, n ) {
			if ( ( regexp.test( o.val() ) ) ) {
				o.addClass( "ui-state-error" );
				updateTips( n );
				return false;
			} else {
				return true;
			}
		}
		
		function checkLength( o, n, min, max ) {
			if ( o.val().length > max || o.val().length < min ) {
				o.addClass( "ui-state-error" );
				updateTips( "Length of " + n + " must be between " +
					min + " and " + max + "." );
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp( o, regexp, n ) {
			if ( !( regexp.test( o.val() ) ) ) {
				o.addClass( "ui-state-error" );
				updateTips( n );
				return false;
			} else {
				return true;
			}
		}

		function checkPassword( o, n ) {
			if ( !( o.val()==n.val() ) )  {
				o.addClass( "ui-state-error" );
				updateTips( "Confirmed Password is not the same" );
				return false;
			} else {
				return true;
			}
		}

		$( "#edit-song-form" ).dialog({
			autoOpen: false,
			height: 500,
			width: 600,
			modal: true,
			buttons: {
				"Submit": function() {
					
					var bValid = true;
					allFields.removeClass( "ui-state-error" );

					bValid = bValid && checkEmpty( song, "Song's name" );
					bValid = bValid && checkEmpty( artist, "Artist" );
					bValid = bValid && checkEmpty( lyric, "Lyric" );
					
					
					if ( bValid ) {
						$("#the-song-form").submit();
						$( this ).dialog( "close" );
					}
					
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});

		$( "#edit-song" )
			.button()
			.click(function() {
				$( "#edit-song-form" ).dialog( "open" );
			});
			
		$( "#edit-artist-form" ).dialog({
			autoOpen: false,
			height: 500,
			width: 600,
			modal: true,
			buttons: {
				"Submit": function() {
					
					var bValid = true;
					allFields.removeClass( "ui-state-error" );

					bValid = bValid && checkEmpty( artistname, "Artist's name" );
					bValid = bValid && checkEmpty( artisttype, "Artist's type" );
					
					if ( bValid ) {
						$("#the-artist-form").submit();
						$( this ).dialog( "close" );
					}
					
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});

		$( "#edit-artist" )
			.button()
			.click(function() {
				$( "#edit-artist-form" ).dialog( "open" );
			});
			
		$( "#edit-user-form" ).dialog({
			autoOpen: false,
			height: 500,
			width: 600,
			modal: true,
			buttons: {
				"Submit": function() {
					
					var bValid = true;
					allFields.removeClass( "ui-state-error" );

					bValid = bValid && checkEmpty( name, "Your name" );
					bValid = bValid && checkLength( password, "password", 6, 40 );
					bValid = bValid && checkRegexp( email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com" );			
					bValid = bValid && checkPassword( password,conpassword );
					
					if ( bValid ) {
						$("#the-user-form").submit();
						$( this ).dialog( "close" );
					}
					
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});	
			
		$( "#signup_witho_fb" )
			.button()
			.click(function() {
				$( "#edit-user-form" ).dialog( "open" );
			});	
		
		$( "#signup_with_fb" )
			.button()
			.click(function() {
			
				FB.login(function(response) {
				  if (response.session) {
					window.location.href = "http://localhost:3000/signupfb"
				  } else {
					// user cancelled login
				  }
				});

				
			});	
	
		
	});
	
	
	



  