// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require vendor
//= require_tree .

var currentSlide = 0;   // The slide that the user is currently viewing
var totalSlides = 4;   // Total number of slides in the featured section
var stepSlide = 2;
var unitDist = 96;
var slideTimer;
var slideInProgress = 0;

//--indicates the mouse is currently over a div
var onDiv = false;
//--indicates the mouse is currently over a link
var onLink = false;
//--indicates that the bubble currently exists
var bubbleExists = false;
//--this is the ID of the timeout that will close the window if the user mouseouts the link
var timeoutID;

var pos;

var voice = new Audio();

var pop_select = null;

var last_played = null;

function hideBubble() {
  clearTimeout(timeoutID);
  //--if the mouse isn't on the div then hide the bubble
  if (bubbleExists && !onDiv && !onLink) {
    $(".speech-featured-dropdown").hide();
    bubbleExists = false;
  }
}

function showBubble(event) {
  if (bubbleExists) { hideBubble(); }
  $.get("/answers/featured.js", "&pop_select="+pop_select, null, "script");
  $(".speech-featured-dropdown").css({'left': pos});
  $(".speech-featured-dropdown").ajaxComplete(function(event) {
    $(".speech-featured-dropdown").fadeIn('slow');
    $(event.currentTarget).unbind('ajaxComplete');
  });

  $(".speech-featured-dropdown").hover(
    function(event) { keepBubbleOpen(); },
    function(event) { letBubbleClose(); }
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

  // if the function argument is given to overlay,
  // it is assumed to be the onBeforeLoad event listener
  $("#masthead-signup-container a[rel]").overlay({
    effect: 'apple',
    mask: {color: '#ebebeb', loadSpeed: 200, opacity: 0.5},
    closeOnClick: false,
  });

  $("#speech-front-audio-container .pagination a").live("click", function() {
    $(".speech-front-progress-spinner").show();
    $.getScript(this.href);
    $("#speech-front-audio-container").ajaxComplete(function() {
      $(".speech-front-progress-spinner").hide();
    });
    return false;
  });

  $(".speech-front-tab-fltr li a").live("click", function() {
    // Tab select switching
    $(this).parents('ul').find('li.selected').removeClass("selected speech-tab-fltr-disabled").addClass("speech-tab-fltr-link");
    $(this).parents('li').removeClass("speech-tab-fltr-link").addClass("selected speech-tab-fltr-disabled");
    var tab_select = $(this).parents('li').attr('alt');
    $(".speech-front-progress-spinner").show();
    $.get("/answers.js", "&tab_select="+tab_select, null, "script");
    $("#speech-front-audio-container").ajaxComplete(function() {
      $(".speech-front-progress-spinner").hide();
    });
    return false;
  });

  $(".guide-section li a").live("click", function() {
    // Tab select switching
    $(this).parents('ul').find('li.selected').removeClass("selected guide-item-fltr-disabled").addClass("guide-item-fltr-link");
    $(this).parents('li').removeClass("guide-item-fltr-link").addClass("selected guide-item-fltr-disabled");
    var guide_select = $(this).parents('li').attr('alt');
    $.get("/users/post.js", "&guide_select="+guide_select, null, "script");
    return false;
  });

  $(".speech-front-audio-item, .user-main-audio-item").hover( 
    function() { $(this).find(".speech-question-info-link").show(); },
    function() { $(this).find(".speech-question-info-link").hide(); }
  );

  if ($.cookie('currentSlideSetting') != null) {
    currentSlide = $.cookie('currentSlideSetting');
    $(".speech-featured-slider").css({'left': -unitDist*stepSlide*currentSlide});
  }

  $(".s-previous").live("click", function() {
    currentSlide--;
    if (currentSlide < 0) {
      currentSlide = totalSlides;
    }
    $.cookie('currentSlideSetting', currentSlide, { expires: 1, path: '/' });
    $(".speech-featured-slider").animate({left : -unitDist*stepSlide*currentSlide+1}, 500);
    return false;
  });

  $(".s-next").live("click", function() {
    currentSlide++;
    if (currentSlide > totalSlides) {
      currentSlide = 0;
    }
    $.cookie('currentSlideSetting', currentSlide, { expires: 1, path: '/' });
    $(".speech-featured-slider").animate({left : -unitDist*stepSlide*currentSlide}, 500);
    return false;
  });

  $("#carousel_container").hover(
    function() { $(this).find(".slider_scroll").show(); },
    function() { $(this).find(".slider_scroll").hide(); }
  );

  $(".speech-featured-item").hoverIntent(
    function(event) {
      pos = $(this).position().left - 138 -unitDist*stepSlide*currentSlide;
      if (onDiv || onLink) { return false; }
      onLink = true;
      pop_select = $(this).children('img').attr('alt');
      showBubble.call(this, event);
    },
    function(event) {
      onLink = false;
      timeoutID = setTimeout(hideBubble, 500);
    }
  );


  $("#carousel_ul li").hoverIntent(
    function(event) {
      if (slideInProgress == 0) {
        pos = $(this).position().left - 618;
        if (onDiv || onLink) { return false; }
        onLink = true;
        pop_select = $(this).children('img').attr('alt');
        showBubble.call(this, event);
      }
    },
    function(event) {
      onLink = false;
      timeoutID = setTimeout(hideBubble, 500);
    }
  );

  $("#left_scroll").hoverIntent(
    function(event) {
      slide("left");
      slideTimer = setInterval('slide("left")', 2000); 
    },
    function(event) {
      clearInterval(slideTimer);
    }
  );

  $("#right_scroll").hoverIntent(
    function(event) {
      slide("right");
      slideTimer = setInterval('slide("right")', 2000); 
    },
    function(event) {
      clearInterval(slideTimer);
    }
  );

  $(".new-question-inputs input").live("click", function(evt) {
    if ($(".new-question-inputs textarea").val().length == 0) {
      evt.preventDefault();
      return false;
    }
  });

  $(".new-evaluation-inputs input").live("click", function(evt) {
    if ($(".new-evaluation-inputs textarea").val().length == 0) {
      evt.preventDefault();
      return false;
    }
  });



  $(".play-stop a img").live("click", function(evt) {
    evt.preventDefault();
    if (this.getAttribute("src") == '/assets/play.png') {
      var vpath = this.getAttribute("voice");
      if (voice.canPlayType("audio/mpeg").match(/maybe|probably/i)) {
        voice.src = vpath + '.mp3';
      } else if (voice.canPlayType("audio/ogg").match(/maybe|probably/i)) {
        voice.src = vpath + '.ogg';
      } else {
        return false;
      }
      voice.volume = 0.6;
      voice.load();
      voice.play();

      if (last_played != null) {
        last_played.attr('src', '/assets/play.png');
      }
      $(this).attr('src', '/assets/stop.png');
      last_played = $(this);
      $(voice).bind("ended", function(){ last_played.attr('src', '/assets/play.png');});

    } else {
      voice.pause();
      $(this).attr('src', '/assets/play.png');
    }
    return false;
  });

  /*move the last list item before the first item. The purpose of this is
  if the user clicks to slide left he will be able to see the last item.*/
  for (var i=0; i<5; i++) {
    $('#carousel_ul li:first').before($('#carousel_ul li:last'));
  }
});

function slide(where) {
  slideInProgress = 1;

  //get the item width
  var item_width = $('#carousel_ul li').outerWidth() + 6;

  /* using a if statement and the where variable check
  we will check where the user wants to slide (left or right)*/
  if(where == 'left'){
    //...calculating the new left indent of the unordered list (ul) for left sliding
    var left_indent = parseInt($('#carousel_ul').css('left')) + 5*item_width;
  }else{
    //...calculating the new left indent of the unordered list (ul) for right sliding
    var left_indent = parseInt($('#carousel_ul').css('left')) - 5*item_width;

  }

  //make the sliding effect using jQuery's animate function... '
  $('#carousel_ul:not(:animated)').animate({'left' : left_indent},3000,function(){

    /* when the animation finishes use the if statement again, and make an ilussion
    of infinity by changing place of last or first item*/
    if(where == 'left'){
      //...and if it slided to left we put the last item before the first item
      for (var i=0; i<5; i++) {
        $('#carousel_ul li:first').before($('#carousel_ul li:last'));
      }
    }else{
      //...and if it slided to right we put the first item after the last item
      for (var i=0; i<5; i++) {
        $('#carousel_ul li:last').after($('#carousel_ul li:first'));
      }
    }

    //...and then just get back the default left indent
    $('#carousel_ul').css({'left' : '-480px'});
    slideInProgress = 0;
  });

}

