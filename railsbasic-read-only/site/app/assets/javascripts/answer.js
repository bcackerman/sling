//////////////////
///  WAVE Rec  ///
//////////////////
function closeAnswer() {
  $(".apple_overlay_answer .close").click();
}

function closeAnswerModal(status) {
  $('.new-answer-inputs').hide();
  if (status == 'success') {
    $('.new-answer-status').html("Thank you for your speech.").fadeIn('slow');
    setTimeout(closeAnswer, 2000);
  } else {
    $('.new-answer-status').html("Unknown error occurred: Please try again later!").fadeIn('slow');
  }
}

function record_answer_countdown(number) {
  $('.speech-new-record-timer').text(number);
  number--;
  if(number >= 0) {
    timeoutHandler = setTimeout(function() { record_answer_countdown(number); }, 1000);
  } else {
    Recorder.record('audio', 'audio.wav');
    $("#speech-new-answer-speak-container").hide();
    $('#save_button').css({'position': 'absolute', 'top' : '100px', 'left': '50px'});
    $("#speech-new-answer-upload-container").fadeIn('slow');
  }
}

function read_question_countdown(number) {
  $('.speech-new-read-timer').text(number);
  number--;
  if(number >= 0) {
    timeoutHandler = setTimeout(function() { read_question_countdown(number); }, 1000);
  } else {
    Recorder.record('audio', 'audio.wav');
    $("#speech-new-answer-question-container").hide();
    $("#speech-new-answer-speak-container").fadeIn('slow');
    var recordTime = $('.speech-new-record-timer').attr('value');
    record_answer_countdown(recordTime);
  }
}


//////////////////
///  WAMI Rec  ///
//////////////////
// initialize some global vars
var timeoutHandler = null;
var imagepath = "http://"+document.location.host+"/assets/recorder/";
var recordInterval;

function startRecording() {
  Wami.startRecording("https://wami-recorder.appspot.com/audio",
      Wami.nameCallback(onRecordStart), Wami
          .nameCallback(onRecordFinish), Wami
          .nameCallback(onError));
}

function stopRecording() {
  Wami.stopRecording();
  clearInterval(recordInterval);
}

function onError(e) {
  alert(e);
}

function onRecordStart() {
  recordInterval = setInterval(function() {
    var level = Wami.getRecordingLevel();
    var levelindicator;
    if (level < 5) {
      levelindicator = 'microphone.png';
    } else if (level < 15) {
      levelindicator = 'microphone_s1.png';
    } else if (level < 25) {
      levelindicator = 'microphone_s2.png';
    } else if (level < 35) {
      levelindicator = 'microphone_s3.png';
    } else if (level < 45) {
      levelindicator = 'microphone_s4.png';
    } else if (level < 55) {
      levelindicator = 'microphone_s5.png';
    } else if (level < 65) {
      levelindicator = 'microphone_s6.png';
    } else if (level < 75) {
      levelindicator = 'microphone_s7.png';
    } else if (level < 85) {
      levelindicator = 'microphone_s8.png';
    } else {
      levelindicator = 'microphone_s9.png';
    }
    $('#microphone_container img').attr('src', imagepath+levelindicator);
  }, 200);
}

function onRecordFinish() {
  $('#microphone_container img').attr('src', imagepath+'microphone.png');
}

function startPlaying() {
  Wami.startPlaying("https://wami-recorder.appspot.com/audio",
      Wami.nameCallback(onPlayStart), Wami
          .nameCallback(onPlayFinish), Wami
          .nameCallback(onError));
}

function stopPlaying() {
  Wami.stopPlaying();
}

function onPlayStart() {

}

function onPlayFinish() {
  $('#play_button img').attr('src', imagepath+'play_enabled.png');
  $('#play_button img').attr('title', 'Playback');
  $('#record_status').css({'color': 'green'}).text("Playback stopped");
}



function setupRecorder() {
  $("#record_button").fadeIn('slow');
  $('#microphone_container').fadeIn('slow');
  $('#start-answer-button').fadeIn('slow');
  $('#record_status').css({'color': 'green'}).text("Press to record (10 seconds)").fadeIn('slow');
  $("#status_info h3").text("Test voice recorder here").fadeIn('slow');
}

function recordAnswerCountdown(number) {
  $('.speech-new-record-timer').text(number);
  number--;
  if(number >= 0) {
    timeoutHandler = setTimeout(function() { recordAnswerCountdown(number); }, 1000);
  } else {
    $("#speech-new-answer-speak-container").hide();
    $("#speech-new-answer-upload-container").fadeIn('slow');
    stopRecording();
  }
}

function readQuestionCountdown(number) {
  $('.speech-new-read-timer').text(number);
  number--;
  if(number >= 0) {
    timeoutHandler = setTimeout(function() { readQuestionCountdown(number); }, 1000);
  } else {
    startRecording();
    $("#speech-new-answer-question-container").hide();
    $("#speech-new-answer-speak-container").fadeIn('slow');
    var recordTime = $('.speech-new-record-timer').attr('value');
    recordAnswerCountdown(recordTime);
  }
}




$(function(){

//////////////////
///  WAVE Rec  ///
//////////////////
if (true) {
  $('.answer-button a[data-remote]').live('ajax:beforeSend', function(e, xhr, settings){
    xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);
    $("#speech-new-answer-test-container").hide();
    $("#speech-new-answer-question-container").hide();
    $('#modal-answer-container').hide();
  });

  $('.answer-button a[data-remote]').live('ajax:success', function(xhr, data, status){
    if(swfobject.hasFlashPlayerVersion("10.1.0")) {
      $('#modal-answer-container').html(data).show();
      Recorder.setup();
    } else {
      $("#record_privacy").hide();
      $('#record_status').css({'color': 'red'}).text("No flash player available");
      $("#status_info h3").text("Adobe Flash Player 10.1.0 or greater is required");
      $('#modal-answer-container').show();
    }
 });

  $(".apple_overlay_answer .close").live("click", function(evt) {
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    $('#microphone_container').hide();
    $('#start-answer-button').hide();
    return false;
  });

  $("#start-answer-button").live("click", function(evt) {
    evt.preventDefault();
    // stop recording if the test recorder is in record
    if ($('#record_button img').attr('title') != 'Record') {
      Recorder.record('audio', 'audio.wav');
    }
    // stop playback if the test recorder is playing voice
    if ($('#play_button img').attr('title') != 'Playback') {
      Recorder.playBack('audio');
    }
    $("#speech-new-answer-test-container").hide();
    $("#record_privacy").hide();
    $("#status_info").hide();
    $("#speech-new-answer-question-container").fadeIn('slow');
    var readTime = $('.speech-new-read-timer').attr('value');
    read_question_countdown(readTime);
    return false;
  });

  $("#answer-done-button").live("click", function(evt) {
    evt.preventDefault();
    Recorder.record('audio', 'audio.wav');
    //Recorder.resize(150, 30);
    $("#speech-new-answer-speak-container").hide();
    $('#save_button').css({'position': 'absolute', 'top' : '100px', 'left': '50px'});
    $("#speech-new-answer-upload-container").fadeIn('slow');
    $('#record_status').css({'color': 'green'}).text("Ready for uploading");
    $("#status_info h3").text("Upload your answer now");
    $("#status_info").fadeIn('slow');
    return false;
  });


  $("#record_button").live("click", function(evt) {
    evt.preventDefault();
    Recorder.record('audio', 'audio.wav');
    return false;
  });

  $("#play_button, #answer-playback-button").live("click", function(evt) {
    evt.preventDefault();
    Recorder.playBack('audio');
    return false;
  });

} else {


//////////////////
///  WAMI Rec  ///
//////////////////
  $('.answer-button a[data-remote]').live('ajax:beforeSend', function(e, xhr, settings){
    xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);
    $("#speech-new-answer-test-container").hide();
    $("#speech-new-answer-question-container").hide();
    $('#modal-answer-container').hide();
  });

  $('.answer-button a[data-remote]').live('ajax:success', function(xhr, data, status){
    if(swfobject.hasFlashPlayerVersion("10.1.0")) {
      $('#modal-answer-container').html(data).show();
      Wami.setup({
          id : "wami",
          onReady : setupRecorder
      });

    } else {
      $("#record_privacy").hide();
      $('#record_status').css({'color': 'red'}).text("No flash player available");
      $("#status_info h3").text("Adobe Flash Player 10.1.0 or greater is required");
      $('#modal-answer-container').show();
    }
 });

  $(".apple_overlay_answer .close").live("click", function(evt) {
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    $('#microphone_container').hide();
    $('#start-answer-button').hide();
    return false;
  });


  $("#start-answer-button").live("click", function(evt) {
    evt.preventDefault();
    // stop if the test recorder is in record or playback
    stopRecording();
    stopPlaying();
    $("#speech-new-answer-test-container").hide();
    $("#record_privacy").hide();
    $("#status_info").hide();
    $("#speech-new-answer-question-container").fadeIn('slow');
    var readTime = $('.speech-new-read-timer').attr('value');
    readQuestionCountdown(readTime);
    return false;
  });

  $("#answer-done-button").live("click", function(evt) {
    evt.preventDefault();
    stopRecording();
    $("#speech-new-answer-speak-container").hide();
    $("#speech-new-answer-upload-container").fadeIn('slow');
    $('#record_status').css({'color': 'green'}).text("Ready for uploading");
    $("#status_info h3").text("Upload your answer now");
    $("#status_info").fadeIn('slow');
    return false;
  });


  $("#record_button").live("click", function(evt) {
    evt.preventDefault();
    if ($('#record_button img').attr('title') != 'Record') {
      stopRecording();
      $('#record_button img').attr('src', imagepath+'record_enabled.png');
      $('#record_button img').attr('title', 'Record');
      $('#play_button img').attr('src', imagepath+'play_enabled.png');
      $('#play_button img').attr('title', 'Playback');
      $('#play_button').show();
      $('#record_status').css({'color': 'orange'}).text("Recording stopped");
    } else {
      startRecording();
      $('#record_button img').attr('src', imagepath+'record_stop.png');
      $('#record_button img').attr('title', 'Stop');
      $('#play_button').hide();
      $('#record_status').css({'color': 'orange'}).text("Recording in progress ...");
    }
    return false;
  });

  $("#play_button").live("click", function(evt) {
    evt.preventDefault();
    if ($('#play_button img').attr('title') != 'Playback') {
      stopPlaying();
      $('#record_button img').attr('src', imagepath+'record_enabled.png');
      $('#record_button img').attr('title', 'Record');
      $('#play_button img').attr('src', imagepath+'play_enabled.png');
      $('#play_button img').attr('title', 'Playback');
      $('#record_status').css({'color': 'green'}).text("Playback stopped");
    } else {
      startPlaying();
      $('#record_button img').attr('src', imagepath+'record_enabled.png');
      $('#record_button img').attr('title', 'Record');
      $('#play_button img').attr('src', imagepath+'play_stop.png');
      $('#play_button img').attr('title', 'Stop');
      $('#record_status').css({'color': 'green'}).text("Playing voice ...");
    }
    return false;
  });

    $("#answer-playback-button").live("click", function(evt) {
    evt.preventDefault();
    if ($(this).attr('title') != 'Playback') {
      stopPlaying();
      $(this).attr('title', 'Playback');
      $('#record_status').css({'color': 'green'}).text("Playback stopped");
    } else {
      startPlaying();
      $(this).attr('title', 'Stop');
      $('#record_status').css({'color': 'green'}).text("Playing voice ...");
    }
    return false;
  });

}


});

