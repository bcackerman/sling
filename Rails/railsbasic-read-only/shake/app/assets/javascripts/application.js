// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require vendor

var nav_start = 1;
var nav_select = null;
var nav_last = null;

$(function() {

  $(".nav-button a").live("click", function(evt) {
    evt.preventDefault();
    if (nav_last != null) {
      nav_last.attr('src', '/assets/'+nav_last.attr('alt')+'_icon.png');
    }
    if (nav_start == 0) {
      $(this).parents('#navigation').find('div.selected').removeClass("selected nav-disabled").addClass("nav-button");
    } else {
      nav_start = 0;
    }
    $(this).parents('.nav-button').removeClass("nav-button").addClass("selected nav-disabled");
  
    nav_last = $(this).find('img');
    nav_select = $(this).parents('div').attr('alt');
    nav_last.attr('src', '/assets/'+nav_last.attr('alt')+'_icon_hover.png');

    $.get("/products.js", "&nav_select="+nav_select, null, "script");
    $(".nav-button").ajaxComplete(function() {

    });

    return false;
  });

});

function showSlides() {
  $('#slides').slides({
    slideSpeed: 800,
    bigTarget: true,
    animationStart: function(current){
      $('.caption').animate({
        bottom:-35
      },100);
    },
    animationComplete: function(current){
      $('.caption').animate({
        bottom:0
      },200);
    },
    slidesLoaded: function() {
      $('.caption').animate({
        bottom:0
      },200);
    }
  });

  $('#slides_two').slides({
    slideSpeed: 1000,
    pagination: false
  });
}

