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
//= require rails.validations
//= require rails.validations.simple_form
//= require best_in_place
//= require vendor
//= require_tree .


var metric_init;
var select_init;
var video_played = 0;

$(function() {
  if (document.getElementById('watch-metric')) {
    metric_init = $(".watch-metric-bar").position().top;
  }
  if (document.getElementById('watch-select')) {
    select_init = $(".watch-select-box").position().top;
  }

  $('#watch-player video').on("play", function(e) {
    if ((e.target.currentTime < 0.2) && (video_played == 0)) {   
      video_played = 1;
      var watch_id = $('#watch_id').val();
      if (watch_id == "post_show") {
        var post_id = $('#post_id').val();
        $.post('/posts/view', {id: post_id});
      } else if (watch_id == "speech_show") {
        var speech_id = $('#speech_id').val();
        $.post('/speeches/view', {id: speech_id});
      }
    }
  });

  $('#watch-player video').on("ended", function(e) {
    video_played = 0;
  });

  $('.best_in_place').best_in_place();

  $('.carousel').carousel({
    interval: false
  });

  $('#watch-tab').tab();

  $('#watch-tab li a').on('click', function(e) {
    e.preventDefault();
    $(this).parents('ul').find('li.active').removeClass("active");
    $(this).parents('li').addClass("active");
    var tab_select = escape($(this).parents('li').attr('rel'));
    var container_id = $('#watch-post-container').attr('rel');
    if (container_id == "posts") {
      $.get("posts.js", "&tab_select="+tab_select, null, "script");
    } else if (container_id == "questions") {
      $.get("questions.js", "&tab_select="+tab_select, null, "script");
    }
    return false;
  });

  $('#watch-filter li a').on('click', function(e) {
    e.preventDefault();
    $(this).parents('ul').find('li.active').removeClass("active");
    $(this).parents('li').addClass("active");
    $(this).parents('ul').find('li.selected').removeClass("selected");
    var cat_filter = escape($(this).parents('li').attr('rel'));
    var watch_id = $('#watch_id').val();
    if (watch_id == "post_index") {
      $.get("posts.js", "&cat_filter="+cat_filter, null, "script");
    } else if (watch_id == "post_channel") {
      $(".watch-metric-bar").hide();
      $.get("/posts/channel.js", "&cat_filter="+cat_filter, null, "script");
    }
    return false;
  });

  $('#watch-filter li').hoverIntent(
    function(e) {
      var flt_text;
      var flt_sel = $(this).attr('rel');
      var flt_page = document.getElementById('watch_id').value;
      if (flt_sel == "Answer") {
        flt_text = "Answer is a 1-3 mintes impromptu talk which responds to one of the questions. To start, go to the question and click on Answer link.";
      } else if (flt_sel == "Evaluation") {
        flt_text = "Evaluation is a 2-3 minutes feedback given to the prepared speech. To start, follow to the speech page and click on Evaluate link.";
      } else if (flt_sel == "Speech") {
        flt_text = "Speech is a prepared 5 to 7 minutes talk with your choice of title, click Upload on top of the page to upload your speech video.";
      } else {
        if (flt_page == "index") {
          flt_text = "This is posts index page. Three type of video posts are listed - speech, evaluation and answer.";
        } else if (flt_page == "channel") {
          flt_text = "This is user's posts page.";
        }
      }
      $('#watch-filter-about').text(flt_text);
    },
    function(e) {}
  );

  $('.spinner a, .spinner li').on('click', function(e) {
    e.preventDefault();
    $(".watch-tab-spinner").show();
    $(document).ajaxComplete(function(e) {
      $(".watch-tab-spinner").hide();
      $(e.currentTarget).unbind('ajaxComplete');
    });
    return false;
  });

  $('#post-search').on('click', function(e) {
    $('#post_search').submit();
    return false;
  });

  showQuestionLink();
  togglePostDesc();
  updatePostMetric();
  updateQuestionMetric();

});

function showQuestionLink() {
  $('li.question-list-item').hover(
    function(e) {
      $(this).find('.question-links').show();
    },
    function(e) {
      $(this).find('.question-links').hide();
    }
  );
}

function togglePostDesc() {
  $('.video-description .video-desc-details a').on('click', function(e) {
    e.preventDefault();
    var $collapse = $(this).closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');
    return false;
  });
}

function updatePostMetric() {
  $('li.video-blog-item').hoverIntent(  
    function(e) {
      if (!$(this).hasClass("active")) {
        $(".watch-metric-bar").hide();
        $(this).parents('ul').find('li.active').removeClass("active");
        $(this).addClass("active");
        var offset = $(this).position().top;     
        $(".watch-metric-bar").css({'top': metric_init+offset});
        var post_select = $(this).attr('alt');
        $.get("/ratings/metric.js", "&post_select="+post_select, null, "script");
        $(document).ajaxComplete(function(e) {
          $(".watch-metric-bar").fadeIn('slow');
          $(e.currentTarget).unbind('ajaxComplete');
        });
      }
    },
    function(e) {}
  );
}

function updateQuestionMetric() {
  $('li.question-blog-item').hoverIntent (  
    function(e) {
      if (!$(this).hasClass("active")) {
        $(".watch-select-box").hide();
        $(this).parents('ul').find('li.active').removeClass("active");
        $(this).addClass("active");
        var offset = $(this).position().top;     
        $(".watch-select-box").css({'top': select_init+offset});
        var question_select = $(this).attr('alt');
        $.get("/questions/select.js", "&question_select="+question_select, null, "script");
        $(document).ajaxComplete(function(e) {
          $(".watch-select-box").fadeIn('slow');
          $(e.currentTarget).unbind('ajaxComplete');
        });
      }
    },
    function(e) {}
  );
}

