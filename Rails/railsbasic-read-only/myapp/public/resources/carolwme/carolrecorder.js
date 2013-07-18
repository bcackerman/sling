

function microphone_recorder_events()
{
  $('#status').text(arguments[0]);

  switch(arguments[0]) {
  case "ready":
    Recorder.connect(0);
    break;

  case "no_microphone_found":
    break;

  case "microphone_user_request":
    Recorder.showPermissionWindow();
    break;

  case "microphone_connected":
    Recorder.ready = true;
    Recorder.defaultSize();
    Recorder.initializeCallback();
    break;

  case "microphone_not_connected":
    Recorder.defaultSize();
    Recorder.failCallback();
    break;

  case "recording":
    var name = arguments[1];
    Recorder.recorded = false;
    Recorder.recording = true;
    if(Recorder.recordCallback) {Recorder.recordCallback();}
    break;

  case "recording_stopped":
    var name = arguments[1];
    var duration = arguments[2];
    Recorder.recorded = true;
    Recorder.recording = false;
    break;

  case "playback_started":
    var name = arguments[1];
    var latency = parseInt(arguments[2], 10);
    if(latency < 0) { latency = 1; }
    if(Recorder.playingCallback) setTimeout(Recorder.playingCallback, latency);
    break;

  case "playing":
    //Recorder.playingCallback();
    var name = arguments[1];
    break;

  case "stopped":
    var name = arguments[1];
    break;

  case "save_pressed":
    var name = arguments[1];
    Recorder.hide();
    Recorder.updateForm();
    break;

  case "saving":
    var name = arguments[1];
    break;

  case "saved":
    var name = arguments[1];
    var data = $.parseJSON(arguments[2]);
    if(data.saved) {
      setTimeout(function() {Recorder.recordingStatus();}, 100);
    } else {
      Recorder.show();
    }
    break;

  case "save_failed":
    var name = arguments[1];
    var errorMessage = arguments[2];
    break;
  }
}

Recorder = {
  recorder: null,
  recorderOriginalWidth: 0,
  recorderOriginalHeight: 0,
  uploadFormId: '#carol_form',
  uploadFieldName: 'carol[filename]',
  saveUrl: '/website/carol/page/save',
  statusUrl: '/website/carol/page/status',
  eventHandler: "microphone_recorder_events",
  ready: false,
  recorded: false,
  recording: false,
  playingCallback: null,
  recordCallback: null,

  connect: function(attempts) {
    if(navigator.appName.indexOf("Microsoft") != -1) {
      Recorder.recorder = window['audio-recorder'];
    } else {
      Recorder.recorder = document['audio-recorder'];
    }

    if(!Recorder.recorder) {
      Recorder.embedSwf();
      setTimeout(function() {Recorder.connect('audio-recorder', attempts+1);}, 100);
      return;
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
        Recorder.recorder.init(Recorder.saveUrl, Recorder.uploadFieldName, frm.serializeArray());
      } else {
        Recorder.showPermissionWindow();
      }

      $('#recording_controls').show();
      return;
    }

    setTimeout(function() {Recorder.connect('audio-recorder', attempts+1);}, 100);
  },

  play: function(name) {
    Recorder.recorder.play(name);
  },

  record: function(name, filename) {
    Recorder.recorder.record(name, filename);
  },

  duration: function(name) {
    return Recorder.recorder.duration(name);
  },

  stop: function() {
    try {
      Recorder.recorder.stop();
    } catch(e) {
      Recorder.failCallback();
    }
  },

  initializeCallback: function() {
    Recorder.connected = true;
    if(Recorder.callback) Recorder.callback();
  },

  failCallback: function(e) {
    if(!e || !e.success) {
      Recorder.connected = false;
      if(Recorder.failed) Recorder.failed();
    }
  },

  resize: function(width, height) {
    Recorder.recorder.width = width + "px";
    Recorder.recorder.height = height + "px";
  },

  defaultSize: function(width, height) {
    $('#status').text('Back to size:' + Recorder.recorderOriginalWidth);
    Recorder.resize(Recorder.recorderOriginalWidth, Recorder.recorderOriginalHeight);
  },

  show: function() {
    Recorder.recorder.wmode ='window';
    Recorder.resize(118, 67);
    Recorder.recorder.show();
  },

  hide: function() {
    Recorder.recorder.wmode ='transparent';
    Recorder.resize(1, 1);
    Recorder.recorder.hide();
  },

  showPermissionWindow: function() {
    Recorder.recorder.wmode ='window';
    Recorder.resize(500, 200);
    // need to wait until app is resized before displaying permissions screen
    setTimeout(function(){Recorder.recorder.permit();}, 1);
  },

  updateForm: function() {
    var frm = $(Recorder.uploadFormId); 
    Recorder.recorder.update(frm.serializeArray());
  },

  embedSwf: function() {
    var appWidth = 1;
    var appHeight = 1;
    var flashvars = {'wmode': 'transparent', 'event_handler': 'microphone_recorder_events', 'upload_image' : '/components/carol/images/carol_save.png'};
    var params = {};
    var attributes = {};
    attributes.id = "audio-recorder";
    attributes.name = "audio-recorder";
    swfobject.embedSWF("/components/carol/recorder.swf", "audio-recorder-container", appWidth, appHeight, "10.1.0", "", flashvars, params, attributes, Recorder.failCallback);

  },

  recordingStatus: function() {
    $.getJSON(Recorder.statusUrl, function(data) {
      if(data.finished) {
        CarolWithMe.saved(data);
      } else {
        setTimeout(function() {Recorder.recordingStatus();}, 500);
      }
    });
  },

 }

