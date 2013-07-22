

var CarolWithMe = (function() {
  var that = this;

  var idx = 0;
  var carollers = {};
  var loadingcnt = 0;

   this.add = function(caroller_id,name,image,ogg,mp3) {
    var cnt = 0;
    for(var i in carollers) { cnt++; }
    if(cnt > 8) {
      alert('Ooops, 8 carollers max! Remove one to add in another caroller');
      return;
    }

     idx++;

     var curIdx = idx;

    var caroller = carollers[idx] = { id: caroller_id };


    caroller.sound = new Audio();
    CarolWithMe.hideCarollers();
    loadingcnt++;
    $(caroller.sound).bind('canplaythrough',function() { if(!caroller.loaded) loadingcnt--; caroller.loaded = true;  CarolWithMe.showCarollers(curIdx); });
    caroller.sound.src = Modernizr.audio.ogg ? ogg : mp3;
    caroller.sound.load();
    data = { name: name, id: idx, image: image }; 
    caroller.elem = $("#carollerTemplate").tmpl(data).appendTo("#carollers")[0];
    $(caroller.elem).find("input").click(function() { CarolWithMe.check(curIdx,this.checked); });
    $(caroller.elem).find("a").click(function() { CarolWithMe.remove(curIdx); });
    CarolWithMe.updateLinks();
  }

  this.remove = function(idx) {
      $("#caroller_item_" + idx).fadeOut(500, function() { $(this).remove(); });
      delete carollers[idx];
      CarolWithMe.updateLinks();
  }


  this.showCarollers = function(idx) {
    if(loadingcnt <= 0) {
      $("#carollers-loading").hide();
      $("#carollers").show();
    }
  }


  this.hideCarollers = function() {
    $("#carollers").hide();
    $("#carollers-loading").show();
  }

  this.updateLinks = function() {
    var playList = []
    for(var i in carollers) { playList.push(carollers[i].id) }


    var url = "http://carolwith.me/?play=" + playList.join(",");

    var text = "Check out my carol on CarolWith.me %23carolwithme";

    $('#share-facebook').attr('href',"http://www.facebook.com/sharer.php?u=" + url);
    $('#share-twitter').attr('href','http://twitter.com/share?url=' + url + "&text=" + text.replace(" ","+"));
  }
 

  this.play = function(recording) {
    $('#carol_record').hide();
    $('#carol_play').hide();
    $('#carol_stop').show();


    if(Recorder.recorded && !recording) {
      Recorder.playingCallback = CarolWithMe.playFiles;
      Recorder.play("carol");
    } else {
      CarolWithMe.playFiles();
    }

  };

  this.playFiles = function() {
    $("#deckthehalls")[0].play();
    for(var i in carollers) {
      carollers[i].sound.currentTime = 0;
      carollers[i].sound.play();
      carollers[i].playing = carollers[i].sound;
      carollers[i].playing.volume = ($(carollers[i].elem).find("input:checked").length > 0) ? 1.0 : 0;
    }
  }

  this.check = function(id,checked) {
    if(carollers[id].playing) {
       carollers[id].playing.volume = checked ? 1.0 : 0;
    }
  }

  this.stop = function() {
    $("#deckthehalls")[0].pause();
    $("#deckthehalls")[0].currentTime = 0;
    for(var i in carollers) {
      carollers[i].sound.pause();
      carollers[i].sound.currentTime = 0;
    }

    CarolWithMe.ended(true);
  }


  this.record = function() {
    if(Recorder.ready) {
      $("#carol-warning").hide();
      Recorder.recordCallback = CarolWithMe.recordCallback;
      Recorder.record("carol", "carol.wav");
    } else {
      $("#carol-warning").show();
      Recorder.record("carol", "carol.wav");
    }
  }

  this.recordCallback = function() {
    $('#carol_record').hide();
    $('#carol_play').hide();
    $('#carol_stop').show();
    $('#carol_save').hide();
    CarolWithMe.play(true);
  }

  this.ended = function(forced) {
    if(Recorder.recording || Recorder.recorded) {
      Recorder.stop();

      if(!forced || Recorder.recorded) {
        $('#carol_save').show();
      }
    }

    $('#carol_record').show();
    $('#carol_play').show();
    $('#carol_stop').hide();
  }

  this.save = function() {
    $('#carol_save_form').show();
    Recorder.show();
  }

  this.saved = function(data) {
    Recorder.recorded = false;
    CarolWithMe.close();
    $('#carol_save').hide();
    CarolWithMe.add(data.id,data.name, data.icon, data.ogg_url, data.mp3_url);
  }

  this.close = function() {
    $('#carol_save_form').hide();
    Recorder.hide();
  }

  return this;

})();

$(function() {

  $('#lyrics > span').each(function(){
    jQuery('audio').singalong({
      start : $(this).attr('data-start'),
      stop  : $(this).attr('data-stop'),
      elem  : $(this)
    });
  });


  $('#deckthehalls').bind('ended', function() {CarolWithMe.ended();});
  // bouncing ball setup.
  //$('#lyrics > span').replaceText(/(\w+)/g,'<span class="word">$1<\/span>' );
  $(document).bind('show.annotate',function(e,data){
    $('#lyrics span.word:visible').bouncyball(data);
  });


  $(".jcarousel").jcarousel({
    vertical: true,
    scroll: 3
  });


});

