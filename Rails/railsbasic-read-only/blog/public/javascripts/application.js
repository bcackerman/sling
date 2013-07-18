var gnews_timeout_handle;
var gnews_update_rate = 60000;
var search_input_text = null;
var front_display_mode = null;
var voice = new Audio();

$(function() {

  $("#post_list .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#front_list .pagination a").live("click", function() {
    $(".front_progress").show()
    $.getScript(this.href);
    $(".post_search").ajaxComplete(function() {
      $(".front_progress").hide();
    });
    return false;
  });

  $(".front_find_icon a").live("click", function() {
    $(".post_search input").select();
    if ($(".post_search input#search_text_entry_contains").val()) {
      front_display_mode = "Search";
      search_input_text = $(".post_search").serialize();
      updateFrontPage();
    }
    return false;
  });

  $(".post_search input").submit(function(evt) {
    evt.preventDefault();
  });
  
  $(".post_search input").keypress(function(evt) {
    var key = evt.keyCode || evt.which;
    if (key == 13){
      $(".front_find_icon a").click();
      return false;
    }
  });



  voice.onpause = voice.onplay = function(e) {
    alert("ON Pause or ON Play");
  }
  
  voice.onended = function(e) {
    alert("ON Ended");
  }
  
  $(".play_stop a").live("click", function() {
    if (voice.ended || voice.paused) {

      //voice = new Audio();
      /*var vpath = this.getAttribute("voice");
      if (voice.canPlayType("audio/mpeg").match(/maybe|probably/i)) {
        voice.src = vpath + '.mp3';
      } else if (voice.canPlayType("audio/ogg").match(/maybe|probably/i)) {
        voice.src = vpath + '.ogg';
      } else {
        return false;
      }*/
      voice.src = 'sound.mp3';
      voice.volume = 0.6;
      voice.load();
      voice.play();
    }
    else {
      voice.pause();
    }

    /*var postid = this.getAttribute("postid");
    var newsid = this.getAttribute("newsid");
    if (postid) {
      $.post('/posts/played', {id: postid});
    }
    if (newsid) {
      $.post('/gnews/played', {id: newsid});
    }*/

    clearTimeout(gnews_timeout_handle);
    gnews_timeout_handle = setTimeout(updateGlobalNews, gnews_update_rate);

    return false;
  });

  $(".post_inputs textarea").keyup(function() {
    if ($(".post_inputs textarea").val().length) {
      $(".post_inputs .text .hint").css({'color': '#555'});
    }
  });

  $("#record_button").live("click", function() {
    if ($(".post_inputs textarea").val().length) {
      Recorder.record('audio', 'audio.wav');
    } else {
      $(".post_inputs .text .hint").css({'color': 'red'}).text("Please type in text input");
    }
    return false;
  });

  $("#play_button").live("click", function() {
    Recorder.playBack('audio');
    return false;
  });

  gnews_timeout_handle = setTimeout(updateGlobalNews, gnews_update_rate);
});

function updateGlobalNews() {
  $.getScript("/gnews/top.js");
  gnews_timeout_handle = setTimeout(updateGlobalNews, gnews_update_rate);
}

function updateLangFilter() {
    var language_id = $("#language_id").attr("value");
    if (language_id == "Post_Index") {
      updateFrontPage();
    } else if (language_id == "Post_Topic") {
      updateTopicPage();
    } else if (language_id == "Gnews_Index") {
      updateGnewsPage();
    } else if (language_id == "User_Show") {
      updateUserPage();
    }

}

function updateFrontPage() {
  var search_filter = search_input_text + "&mode=" + front_display_mode;
  $.get($(".post_search").attr("action"), search_filter, $(".front_progress").show(), "script");

  if (front_display_mode == "Search") {
    $(".front_title").html("Search Results");
  } else { // Top Rated
    $(".front_title").html("Top Rated");
  }

  $(".post_search").ajaxComplete(function() {
    $(".front_progress").hide();
  });
}

function updateTopicPage() {
  $.get("/posts/topic.js", "&mode=Filter"+"&id="+$("#hd_topic_id").attr("value"), $(".front_progress").show(), "script");
  $("#post_list").ajaxComplete(function() {
    $(".front_progress").hide();
  });
}

function updateGnewsPage() {
  $.get("/gnews.js", "&mode=Filter", $(".front_progress").show(), "script");
  $("#post_list").ajaxComplete(function() {
    $(".front_progress").hide();
  });
}

function updateUserPage() {
  $.get("/users/post.js", "&mode=Filter"+"&username="+$("#hd_user_name").attr("value"), $(".front_progress").show(), "script");
  $("#post_list").ajaxComplete(function() {
    $(".front_progress").hide();
  });
}

