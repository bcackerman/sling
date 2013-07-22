var appWidth = 48;
var appHeight = 48;
var imagepath = "http://"+document.location.host+"/images/recorder/";
var flashvars = {'event_handler': 'microphone_recorder_events', 'upload_image': imagepath+'upload.png'};
var params = {};
var attributes = {'id': "audio_recorder", 'name':  "audio_recorder"};
swfobject.embedSWF("http://"+document.location.host+"/library/flash/recorder.swf", "flashcontent", appWidth, appHeight, "10.1.0", "", flashvars, params, attributes);

var startNumber = 12;
var timeoutHandler = null;
function countDown(number) {
  $('#record_count').text(number);
  number--;
  if(number >= 0) {
    timeoutHandler = setTimeout(function() { countDown(number); }, 1000);
  }
}

function microphone_recorder_events()
{
  switch(arguments[0]) {
  case "ready":
    var width = parseInt(arguments[1]);
    var height = parseInt(arguments[2]);
    Recorder.uploadFormId = "#new_post";
    Recorder.uploadFieldName = "record_file[filename]";
    Recorder.connect("audio_recorder", 0);
    Recorder.recorderOriginalWidth = width;
    Recorder.recorderOriginalHeight = height;
    $('#save_button').css({'width': width, 'height': height});
    $('#record_status').css({'color': 'green'}).text("Press to Record");
  break;

  case "no_microphone_found":
    $('#record_status').css({'color': 'red'}).text("No Microphone Found!");
    break;

  case "microphone_user_request":
    Recorder.showPermissionWindow();
    break;

  case "microphone_connected":
    var mic = arguments[1];
    Recorder.defaultSize();
    $('#upload_status').css({'color': '#000'}).text("Microphone: " + mic.name);
    $('#record_status').css({'color': 'green'}).text("Press to Start Recording");
    break;

  case "microphone_not_connected":
    Recorder.defaultSize();
    $('#record_status').css({'color': 'red'}).text("No Microphone Connected!");
    break;

  case "recording":
    var name = arguments[1];
    countDown(startNumber);
    Recorder.hide();
    $('#record_button img').attr('src', imagepath+'record_stop.png');
    $('#play_button').hide();
    $('#record_status').css({'color': 'orange'}).text("Start Recording");
    break;

  case "recording_stopped":
    var name = arguments[1];
    var duration = arguments[2];
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    Recorder.show();
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#play_button').show();
    $('#record_status').css({'color': 'orange'}).text("Recording Stopped");
    break;

  case "playing":
    var name = arguments[1];
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#play_button img').attr('src', imagepath+'play_stop.png');
    $('#record_status').css({'color': 'green'}).text("Playing Voice");
    break;

  case "playback_started":
    var name = arguments[1];
    var latency = parseInt(arguments[2], 10);
    timeoutHandler = setTimeout(function() {countDown(startNumber);}, latency);
    $('#record_status').css({'color': 'green'}).text("Playing Voice");
    break;

  case "stopped":
    var name = arguments[1];
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#play_button img').attr('src', imagepath+'play_enabled.png');
    $('#record_status').css({'color': 'green'}).text("Playback Stopped");
    break;

  case "save_pressed":
    Recorder.updateForm();
    break;

  case "saving":
    var name = arguments[1];
    break;

  case "saved":
    var name = arguments[1];
    var data = $.parseJSON(arguments[2]);
    if(data.saved) {
      $('#upload_status').css({'color': 'green'}).text("Saved Successfully");
    } else {
      $('#upload_status').css({'color': 'green'}).text("Could Not Saved");
    }
    break;

  case "save_failed":
    var name = arguments[1];
    var errorMessage = arguments[2];
    $('#upload_status').css({'color': 'red'}).text("Failed: " + errorMessage);
    break;

  case "save_progress":
    var name = arguments[1];
    var bytesLoaded = arguments[2];
    var bytesTotal = arguments[3];
    $('#upload_status').css({'color': 'green'}).text("Progress: " + bytesLoaded + " / " + bytesTotal);
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
      if(Recorder.uploadFormId && $) {
        var frm = $(Recorder.uploadFormId); 
        Recorder.recorder.init(frm.attr('action').toString(), Recorder.uploadFieldName, frm.serializeArray());
      }
      return;
    }

    setTimeout(function() {Recorder.connect(name, attempts+1);}, 100);
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
    $('#record_status').css({'color': 'blue'}).text("To skip this, change Flash settings to always allow");
    // need to wait until app is resized before displaying permissions screen
    setTimeout(function(){Recorder.recorder.permit();}, 1);
  }
}
