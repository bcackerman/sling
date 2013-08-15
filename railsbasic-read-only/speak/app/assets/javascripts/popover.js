// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.


//--indicates the mouse is currently over a div
var onDiv = false;
//--indicates the mouse is currently over a link
var onLink = false;
//--indicates that the bubble currently exists
var bubbleExists = false;
//--this is the ID of the timeout that will close the window if the user mouseouts the link
var timeoutID;

var pos;

var pop_select;


function hideBubble() {
  clearTimeout(timeoutID);
  //--if the mouse isn't on the div then hide the bubble
  if (bubbleExists && !onDiv && !onLink) {
    $(".watch-featured-dropdown").hide();
    bubbleExists = false;
  }
}

function showBubble(e) {
  if (bubbleExists) { hideBubble(); }
  $.get("/posts/featured.js", "&pop_select="+pop_select, null, "script");
  $(".watch-featured-dropdown").css({'left': pos});
  $(document).ajaxComplete(function(e) {
    $(".watch-featured-dropdown").fadeIn('slow');
    $(e.currentTarget).unbind('ajaxComplete');
  });

  $(".watch-featured-dropdown").hover(
    function() { keepBubbleOpen(); },
    function() { letBubbleClose(); }
  );

  bubbleExists = true;
}

function keepBubbleOpen() {
  onDiv = true;
}

function letBubbleClose() {
  onDiv = false;
  hideBubble();
}


$(function() {

  $("#watch-featured-carousel ul li img").hoverIntent(
    function(e) {
      obj = $(this).parent('li');
      pos = $(this).position().left - 23;
      if (onDiv || onLink) { return false; }
      onLink = true;
      pop_select = $(this).attr('alt');
      showBubble.call(obj, e);
    },
    function(e) {
      onLink = false;
      timeoutID = setTimeout(hideBubble, 500);
    }
  );



});

