$(function() {

  var lang_a = null;  
  var lang_b = null;

  $("#post_list .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#front_list .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $("#post_search input").keyup(function() {
    $.get($("#post_search").attr("action"), $("#post_search").serialize(), null, "script");
    return false;
  });

  $(".lang_flag a img").live("click", function(evt) {
    if ((lang_a == null) || (lang_b == null)) { 
      lang_b = lang_a;
      lang_a = this.getAttribute("title");
      $(this).fadeTo('fast', 1);
      $.get($("#post_search").attr("action"), {lang_a: lang_a, lang_b: lang_b}, null, "script");
    }
    return false;
  });

  $("#lang_reset a").live("click", function(evt) {
    lang_a = null;  
    lang_b = null;
    $(".lang_flag a img").fadeTo('slow', 0.2);
    $.get($("#post_search").attr("action"), $("#post_search").serialize(), null, "script");
    return false;
  });

  $(".echo_avatar a img").live("click", function(evt) {
    evt.preventDefault();
    var soundClip = new Audio(this.getAttribute("voice"));
    soundClip.load();
    soundClip.play();
    return false;
  });

  $("#record_button").live("click", function(evt) {
    evt.preventDefault();
    Recorder.record('audio', 'audio.wav');
    return false;
  });

  $("#play_button").live("click", function(evt) {
    evt.preventDefault();
    Recorder.playBack('audio');
    return false;
  });

});
