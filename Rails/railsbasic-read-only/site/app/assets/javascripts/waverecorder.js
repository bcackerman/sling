var imagepath = "http://"+document.location.host+"/assets/recorder/";
var timeoutHandler = null;

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
  break;

  case "no_microphone_found":
    $('#record_status').show().css({'color': 'red'}).text("No microphone detected!");
    break;

  case "microphone_user_request":
    $('#save_button').css({'position': 'absolute', 'top' : '200px', 'left': '178px'});
    Recorder.showPermissionWindow();
    break;

  case "microphone_connected":
    Recorder.defaultSize();
    Recorder.uploadFormId = $('#recorder_id').attr('value');
    Recorder.uploadFieldName = "record_file[filename]";
    Recorder.configure();
    Recorder.setUseEchoSuppression();
    $('#save_button').css({'position': 'absolute', 'top' : '-999px', 'left': '-999px'});
    $('#record_status').show().css({'color': 'green'}).text("Start to record now");
    $('#microphone_container').fadeIn('slow');
    $('#start-answer-button').fadeIn('slow');
    break;

  case "microphone_not_connected":
    Recorder.defaultSize();
    $('#record_status').show().css({'color': 'red'}).text("No microphone connected!");
    break;

  case "recording":
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    Recorder.hide();
    $('#record_button img').attr('src', imagepath+'record_stop.png');
    $('#record_button img').attr('title', 'Stop');
    $('#play_button').hide();
    $('#record_status').css({'color': 'orange'}).text("Recording in progress ...");
    break;

  case "recording_stopped":
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    Recorder.show();
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#record_button img').attr('title', 'Record');
    $('#play_button img').attr('src', imagepath+'play_enabled.png');
    $('#play_button img').attr('title', 'Playback');
    $('#play_button').show();
    $('#record_status').css({'color': 'orange'}).text("Recording stopped");
    break;

  case "playing":
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#record_button img').attr('title', 'Record');
    $('#play_button img').attr('src', imagepath+'play_stop.png');
    $('#play_button img').attr('title', 'Stop');
    $('#record_status').css({'color': 'green'}).text("Playing voice ...");
    break;

  case "playback_started":
    $('#record_status').css({'color': 'green'}).text("Playing voice ...");
    break;

  case "stopped":
    clearTimeout( timeoutHandler );
    timeoutHandler = null;
    $('#record_button img').attr('src', imagepath+'record_enabled.png');
    $('#record_button img').attr('title', 'Record');
    $('#play_button img').attr('src', imagepath+'play_enabled.png');
    $('#play_button img').attr('title', 'Playback');
    $('#record_status').css({'color': 'green'}).text("Playback stopped");
    break;

  case "save_pressed":
    Recorder.updateForm();
    break;

  case "saved":
    var data = $.parseJSON(arguments[2]);
    if(data.saved) {
      $('#record_status').css({'color': 'green'}).text("Saved successfully");
    } else {
      $('#record_status').css({'color': 'red'}).text("Saving unsuccessful, please try again.");
    }
    //document.location.href = "http://"+document.location.host+"/"+$('#redirect_url').attr('value');
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

  setup: function () {
    var appWidth = 48;
    var appHeight = 48;
    var flashvars = {'event_handler': 'microphone_recorder_events', 'upload_image': imagepath+'upload.png'};
    var params = {};
    var attributes = {'id': "audio_recorder", 'name':  "audio_recorder"};
    swfobject.embedSWF("http://"+document.location.host+"/library/flash/wave-recorder/recorder.swf", "flashcontent", appWidth, appHeight, "10.1.0", "", flashvars, params, attributes);

  },

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

  defaultSize: function() {
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
    Recorder.resize(214, 137);
    // need to wait until app is resized before displaying permissions screen
    setTimeout(function(){Recorder.recorder.permit();}, 1);
  }
}
