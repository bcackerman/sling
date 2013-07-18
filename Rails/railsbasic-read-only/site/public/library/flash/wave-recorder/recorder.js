var appWidth = 48;
var appHeight = 48;
var imagepath = "http://"+document.location.host+"/images/recorder/";
var flashvars = {'event_handler': 'microphone_recorder_events', 'upload_image': imagepath+'upload.png'};
var params = {};
var attributes = {'id': "audio_recorder", 'name':  "audio_recorder"};
swfobject.embedSWF("http://"+document.location.host+"/library/flash/wavrecorder/recorder.swf", "flashcontent", appWidth, appHeight, "10.1.0", "", flashvars, params, attributes);

var startNumber = $('#record_time').attr('value');
var timeoutHandler = null;
function record_count_down(number) {
  $('#record_count').text(number);
  number--;
  if(number >= 0) {
    timeoutHandler = setTimeout(function() { record_count_down(number); }, 1000);
  } else {
    Recorder.record('audio', 'audio.wav');
  }
}

function playback_count_down(number) {
  $('#record_count').text(number);
  number--;
  if(number > 0) {
    timeoutHandler = setTimeout(function() { playback_count_down(number); }, 1000);
  } else if(number == 0) {
    timeoutHandler = setTimeout(function() { playback_count_down(number); }, 900);
  }
}

function microphone_recorder_events()
{
  switch(arguments[0]) {
  case "ready":
    var width = parseInt(arguments[1]);
    var height = parseInt(arguments[2]);
    Recorder.uploadFormId = $('#recorder_id').attr('value');
    Recorder.uploadFieldName = "record_file[filename]";
    Recorder.connect("audio_recorder", 0);
    Recorder.configure();
    Recorder.setUseEchoSuppression();
    Recorder.recorderOriginalWidth = width;
    Recorder.recorderOriginalHeight = height;
    $('#save_button').css({'width': width, 'height': height});
    $('#record_status').css({'color': 'green'}).text("Press to start recording");
    $('#record_privacy').hide();
  break;

  case "no_microphone_found":
    $('#record_status').show().css({'color': 'red'}).text("No microphone detected!");
    $('#record_privacy').hide();
    break;

  case "microphone_user_request":
    $('#record_status').hide();
    $('#record_privacy').show();
    Recorder.showPermissionWindow();
    break;

  case "microphone_connected":
    Recorder.defaultSize();
    Recorder.configure();
    Recorder.setUseEchoSuppression();
    $('#record_status').show().css({'color': 'green'}).text("Start to record now");
    $('#record_privacy').hide();
    break;

  case "microphone_not_connected":
    Recorder.defaultSize();
    $('#record_status').show().css({'color': 'red'}).text("No microphone connected!");
    $('#record_privacy').hide();
    break;

  case "recording":
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    record_count_down(startNumber);
    Recorder.hide();
    $('#record_button img').attr('src', imagepath+'record_stop.png');
    $('#play_button').hide();
    $('#record_status').css({'color': 'orange'}).text("Recording in progress ...");
    $('#status_info h3').hide();
    break;

  case "recording_stopped":
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    Recorder.show();
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#play_button img').attr('src', imagepath+'play_enabled.png');
    $('#play_button').show();
    $('#record_status').css({'color': 'orange'}).text("Recording stopped");
    $('#status_info h3').show();
    break;

  case "playing":
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#play_button img').attr('src', imagepath+'play_stop.png');
    $('#record_status').css({'color': 'green'}).text("Playing voice ...");
    break;

  case "playback_started":
    playback_count_down(startNumber);
    $('#record_status').css({'color': 'green'}).text("Playing voice ...");
    break;

  case "stopped":
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#play_button img').attr('src', imagepath+'play_enabled.png');
    $('#record_status').css({'color': 'green'}).text("Playback stopped");
    break;

  case "save_pressed":
    Recorder.updateForm();
    $('#status_info h3').hide();
    break;

  case "saved":
    var data = $.parseJSON(arguments[2]);
    if(data.saved) {
      $('#record_status').css({'color': 'green'}).text("Saved successfully");
    } else {
      $('#record_status').css({'color': 'red'}).text("Saving unsuccessful, please try again.");
    }
    document.location.href = "http://"+document.location.host+"/"+$('#redirect_url').attr('value');
    break;
    
  case "save_failed":
    $('#record_status').css({'color': 'red'}).text("Uploading unsuccessful, please try again.");
    break;

  case "save_progress":
    $('#record_status').css({'color': 'green'}).text("Uploading in progress ...");
    break;
  }
}

Recorder = {
  recorder: null,
  recorderOriginalWidth: 0,
  recorderOriginalHeight: 0,
  uploadFormId: null,
  uploadFieldName: null,

  connect: function(name, attempts) {
    if(navigator.appName.indexOf("Microsoft") != -1) {
      Recorder.recorder = window[name];
    } else {
      Recorder.recorder = document[name];
    }

    if(attempts >= 40) {
      return;
    }

    // flash app needs time to load and initialize
    if(Recorder.recorder && Recorder.recorder.init) {
      Recorder.recorderOriginalWidth = Recorder.recorder.width;
      Recorder.recorderOriginalHeight = Recorder.recorder.height;
      Recorder.recorder.init($(Recorder.uploadFormId).attr('action').toString(), Recorder.uploadFieldName, null);
      return;
    }

    setTimeout(function() {Recorder.connect(name, attempts+1);}, 100);
  },

  configure: function() {
    Recorder.recorder.configure(22, 50, 0, 1000);
  },

  setUseEchoSuppression: function() {
    Recorder.recorder.setUseEchoSuppression(true);
  },

  playBack: function(name) {
    Recorder.recorder.playBack(name);
  },

  record: function(name, filename) {
    Recorder.recorder.record(name, filename);
  },

  resize: function(width, height) {
    Recorder.recorder.width = width + "px";
    Recorder.recorder.height = height + "px";
  },

  defaultSize: function(width, height) {
    Recorder.resize(Recorder.recorderOriginalWidth, Recorder.recorderOriginalHeight);
  },

  show: function() {
    Recorder.recorder.show();
  },

  hide: function() {
    Recorder.recorder.hide();
  },

  updateForm: function() {
    var frm = $(Recorder.uploadFormId); 
    Recorder.recorder.update(frm.serializeArray());
  },

  showPermissionWindow: function() {
    Recorder.resize(240, 160);
    // need to wait until app is resized before displaying permissions screen
    setTimeout(function(){Recorder.recorder.permit();}, 1);
  }
}
