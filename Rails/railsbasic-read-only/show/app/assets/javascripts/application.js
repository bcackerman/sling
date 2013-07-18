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
//= require bootstrap
//= require s3_direct_upload
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require vendor
//= require_tree .

$(function() {

  $('.carousel').carousel({
    interval: false
  })

  $(".vjs-big-play-button, .vjs-play-control, .vjs-poster").live("click", function() {
    $("#player-popup .caption").hide();
  });

  $('#watch-tab').tab();

  $('.video-thumb a').live('click', function(e) {
    e.preventDefault();
    var video_loading = $(this).parents(".video-thumb-wrap").find(".video-loading");
    video_loading.show();
    var vid_select = escape($(this).parents(".video-encode").attr('alt'));
    $.get("posts/player.js", "&vid_select="+vid_select, null, "script");

    $(this).ajaxComplete(function(e) {
      $("#player-popup").modal({keyboard:false});
      $("#player-popup .caption").show();
      video_loading.hide();
      $(e.currentTarget).unbind('ajaxComplete');
    });

    var video_src = $(this).parents(".video-encode").attr('rel');
    var video_path = video_src.substr(0, video_src.lastIndexOf('.'));
    var video_obj = VideoJS("video_player");
    var video_node = $('#video_player_html5_api').get(0);

    video_obj.ready(function() {
      video_obj.pause();
      if (video_node.canPlayType("video/mp4").match(/maybe|probably/i)) {
        video_node.src = video_path + '_mp4.mp4';
      } else if (video_node.canPlayType("video/ogg").match(/maybe|probably/i)) {
        video_node.src = video_path + '_ogv.ogv';
      } else {

      }
      $("img.vjs-poster").attr("src","front_bg.jpg").show();
      $(".vjs-big-play-button").show();
      $("#video_player").removeClass("vjs-playing").addClass("vjs-paused");
      video_obj.load();
    });
    return false;
  });

  $('#player-popup .modal .close').live('click', function(e) {
    var video_obj = VideoJS("video_player");
    video_obj.currentTime(0).pause();
  });

  $('#watch-tab li a').live('click', function(e) {
    e.preventDefault();
    $(this).parents('ul').find('li.active').removeClass("active");
    $(this).parents('li').addClass("active");
    var tab_select = escape($(this).parents('li').attr('rel'));
    $.get("posts.js", "&tab_select="+tab_select, null, "script");
    return false;
  });

  $('#watch-filter li a').live('click', function(e) {
    e.preventDefault();
    $(this).parents('ul').find('.watch-filter-subtab').hide();
    $(this).parents('li').find('.watch-filter-subtab').fadeIn('slow');
    $(this).parents('ul').find('li.active').removeClass("active");
    $(this).parents('li').addClass("active");
    $(this).parents('ul').find('li.selected').removeClass("selected");
    var ski_filter = "All";
    var cat_filter = escape($(this).parents('li').attr('rel'));
    var watch_id = $('#watch_id').val();
    if (watch_id == "index") {
      $.get("posts.js", "&cat_filter="+cat_filter+"&ski_filter="+ski_filter, null, "script");
    } else if (watch_id == "channel") {
      $.get("/posts/channel.js", "&cat_filter="+cat_filter+"&ski_filter="+ski_filter, null, "script");
    }
    return false;
  });

  $('.watch-filter-subtab li').live('click', function(e) {
    e.preventDefault();
    $(this).parents('ul').find('li.selected').removeClass("selected");
    $(this).addClass("selected");
    var ski_filter = escape($(this).attr('rel'));
    var cat_filter = escape($(this).parents('ul').attr('rel'));
    var watch_id = $('#watch_id').val();
    if (watch_id == "index") {
      $.get("posts.js", "&cat_filter="+cat_filter+"&ski_filter="+ski_filter, null, "script");
    } else if (watch_id == "channel") {
      $.get("/posts/channel.js", "&cat_filter="+cat_filter+"&ski_filter="+ski_filter, null, "script");
    }
    return false;
  });


  $('.spinner a, .spinner li').live('click', function(e) {
    e.preventDefault();
    $(".watch-tab-spinner").show();
    $("#watch-panel").ajaxComplete(function() {
      $(".watch-tab-spinner").hide();
    });
    return false;
  });

  $('#post-search').live('click', function(e) {
    $('#post_search').submit();
    return false;
  });
 

});
