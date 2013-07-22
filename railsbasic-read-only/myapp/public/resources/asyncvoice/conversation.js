var autoplay = false;

function onEntries(entries) {
    if (entries.error)
        return;
    for (var p in entries) {
        var entryData = renderEntry(entries[p]);
        $("#async-entries .async-no-entries").remove();
        if (entryData != "") {
            var entryContainer = $('<div></div>').append(entryData);
            $("#async-entries").prepend(entryContainer);

            var transitionName = null;
            if (typeof(document.body.style.webkitTransition) != "undefined" )
                transitionName = "webkitTransitionEnd";
            else if (typeof(document.body.style.mozTransition) != "undefined")
                transitionName = "mozTransitionEnd";
            else if (typeof(document.body.style.oTransition) != "undefined")
                transitionName = "oTransitionEnd";

            if (transitionName != null)
                addTransitionListener(transitionName, entryContainer);
            else {
                $(entryContainer).show();
                onNewEntry(entryContainer);
            }
        }
    }
}

var renderEntry = function(entry) {
    var align;
    var toRender = "";
    var previousTime;
    var audioInfo = [];
    if (entry.type && entry.type == "users_change") {
        displayUsers(entry.users, entry.action);
        return;
    }
    if (usr_name && entry.author)
        align = usr_name == entry.author.name ? "left" : "right";
    else
        align = align == "right" ? "left":"right";

    var time = new Date(entry.published);
    var time_min = time.getMinutes();
    var time_sec = time
    var time_month = time.getMonth()+1;

    if (time_min < 10) time_min = "0" + time_min;
    if (time_sec < 10) time_sec = "0" + time_sec;
    if (time_month < 10) time_month = "0" + time_month;

    //async-entry-----
    if (entry.geo && entry.geo.coordinates)
        toRender += '<div class="async-entry async-entry-w-map" id="'+entry.id+'">';
    else
        toRender += '<div class="async-entry" id="'+entry.id+'">';

    //async-user left----->
    if (align=="left") {
        toRender += '<div class="async-user async-vert-content"><a href="'+entry.author.uri+'" target="_blank">';
        toRender += '<img title="'+entry.author.name+'" class="async-user-img" src="'+entry.author.icon+'"></img></a></div>';
    }
    //-----async-user left

    //async-speech-bubble---->
    toRender += '<div class="async-speech-bubble '+align+' async-vert-content async-entry-bubble">';
    var mediaSRCs = [];
    var canPlay = "";
    var audio = self.Audio ? new Audio() : {"canPlayType": function () { return ""; }};

    for (var p in entry.link) {
        if (entry.link[p].rel == "enclosure") {
            mediaSRCs.push(entry.link[p]);
            canPlay += audio.canPlayType(entry.link[p].type);
        }
    }
    if (mediaSRCs.length > 0 && canPlay) {
        toRender += '<audio controls class="audio-elem" style="margin-left:15px;margin-top:10px;">';
        for (i = mediaSRCs.length-1; i >= 0; i--)
            toRender += '<source type = "'+mediaSRCs[i].type+'" src="'+mediaSRCs[i].href+'" />';
        toRender += '</audio>';
        if (usr_name == entry.author.name) {
            toRender += '<div class="bubble-share" style="display:none;">';
            toRender += '<a class="publish-entry" href="#" onclick="postToFb('+entry.author.name +', '+ mediaSRCs[1]+')">';
            toRender += 'Post to <img src="http://'+document.location.host+'/static/images/facebook_20.png" /></a><br><a class="remove-entry" href="#" onclick="remove_entry('+entry.hash+')">Remove</a></div><br>';
        }
    } else if (entry.summary != "" && entry.summary != "undefined") {
        toRender += '<p class="async-text">'+decodeURIComponent(escape(entry.summary))+'</p>';
        if (usr_name == entry.author.name) {
            toRender += '<div class="bubble-share" style="display:none;"><a class="remove-entry" href="#">Remove</a></div>';
        }
    }
    toRender += '<span class="async-submitted">'+time.getHours()+":"+time_min+" - "+time.getDate()+"/"+time_month+'</span>';
    var permalink = '<span class="async-submitted"><a href="http://'+document.location.host+'/async/conversation/entry/get/'+entry.id+'.html">Permalink</a></span>';
    if (entry.geo && entry.geo.coordinates) {
        toRender += '<img class="async-map-pin" src="http://'+document.location.host+'/static/images/map_16.png" onclick="showMap(this,'+entry.geo.coordinates[0]+","+entry.geo.coordinates[1]+')"/>' + permalink;
        toRender += '<div class="async-map-div"></div>';
    } else {
        toRender += permalink;
    }
    toRender += '</div>';
    //-----async-speech-bubble

    //async-user right ----->
    if (align == "right") {
        toRender += '<div class="async-user async-vert-content"><a href="'+entry.author.uri+'" target="_blank">';
        toRender += '<img title="'+entry.author.name+'" class="async-user-img" src="'+entry.author.icon+'"></img></a></div>';
    }//-----async-user right


    toRender += '</div>';
    //-----async-entry
    return toRender;
}

function playList() {
    var list = [];
    var state = "stop";
    this.append = function(obj) {
        list.push(obj);
        if (state == "stop")
            play();
    }

    var play = function() {
        state = "play";
        if (list.length > 0) {
            var clip = list.shift();
            clip.addEventListener("ended", function() { if (list.length > 0) { setTimeout(play, 100); } else state = "stop"; }, false);
            clip.addEventListener("change", function() { clip.play(); },false);
            var evt = document.createEvent("Events");
            evt.initEvent("change", true, false);
            clip.dispatchEvent(evt);
        } else {
            state = "stop";
        }
    }
}
var playList = new playList();

function onNewEntry(entryContainer) {
    if (!autoplay)
        return;
    var audioElements = entryContainer.get(0).getElementsByClassName("audio-elem");
    for (var p in audioElements) {
        var audioElem = audioElements[p];
        if (audioElem.tagName == "AUDIO") {
            playList.append(audioElem);
        } else if (audioElem.tagName == "INPUT") {
            audioElem.onclick();
        }
    }
}
function addTransitionListener(name, container) {
    container.toggleClass("async-new-entries");
    container.get(0).addEventListener(name, function() { onNewEntry(container); });
    setTimeout(function() { $(container).css("opacity", 1);}, 20);
}

function displayUsers(users, highlight) {
    var userContainer = $('<div></div>');
    for (var i = 0; i < users.length; i++) {
        var user = users[i];
        if ( user.image_url ) userContainer.append('<a href="http://'+document.location.host+"/"+ user.username+'"><img title="'+user.username+ '" class="async-profile-img" id="'+user.username+'" src="'+user.image_url+'"/></a>');
        else userContainer.append('<a href="'+user.username+'"><img title="'+user.username+ '" class="async-online-user-img" id="'+user.username+'" src="images/default_user.png"/></a>');
    }
    $(".async-online-users").empty();
    $(".async-online-users").append(userContainer);
    if (highlight)
        $(".async-online-users").show("highlight",1500);
}
function showMap(target, lat, long) {
    $(target).parents('.async-entry').toggleClass('async-expand async-entry-w-map');
    $(target).siblings('.async-map-div').toggle();
    var ll = lat + "," + long;
    var map = "<a target='_blank' href='http://maps.google.com/maps?q="+ll+"'><img src='http://maps.google.com/maps/api/staticmap?center="+ll+
              "&zoom=12&size=400x270&maptype=roadmap&markers=color:blue|label:A|"+ll+"&sensor=false' width='400' height='270' border='0' /></a>";
    $(target).siblings(".async-map-div").html(map);
}

function closeMap() {
    $(this).parents('.async-entry').toggleClass('async-expand async-entry-w-map');
    $(this).parent().toggle();
}

function sendText() {
    var text = $('#async-submit-text').get(0).value;
    if (text == "") return;
    $('#async-submit-text').get(0).value = "";
    text = unescape(encodeURIComponent(text));
    AV.createEntry(ASYNC_VOICE_CONVERSATION_NAME, "Chat Text", text, getPos(), null, function() { });
}
var posLat="";
var posLong="";
function getPos() {
    return posLat+","+posLong;
}

var postToFb = function (username, audioSrc) {
        var publish = {
            method: 'stream.publish',
            message: 'Join the conversation!',
            attachment: {
              name: 'Async Voice post',
              caption: 'This is a message in an Async Voice conversation',
              href: document.location.href,
              media: [
                {
                  type: 'mp3',
                  title: 'Voice message',
                  artist: username,
                  src: audioSrc
                }
              ]
            },
            action_links: [
             { text: 'Join the conversation', href: document.location.href }
            ],
            user_prompt_message: 'Join the conversation'
        };
        FB.ui(publish,function(response) { });
};
function remove_entry(id) {
    var yes = confirm("A remove is permanent, still sure?");
    if (yes) {
        AV.deleteEntry(id, function(data) {
            window.location = document.location.protocol + "//" + document.location.host + "/c/"+ASYNC_VOICE_CONVERSATION_NAME;
        });
    }
};
var onStart = function() {

    if (navigator && navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
                                                    posLat = new Number(position.coords.latitude).toFixed(3);
                                                    posLong = new Number(position.coords.longitude).toFixed(3);
                                                });
    }

    var onStopRecording = function(audioData) {
        uploadAudioClip("Start");
        if (audioData!="" && ! audioData.error) {
            AV.createEntry(ASYNC_VOICE_CONVERSATION_NAME, escape(new Date().toString()),
            escape($('#async-submit-text').get(0).value), getPos(), audioData, function() { uploadAudioClip("Done"); });
        }
    };
    var timeout = null;
    var changeNumber = function(i) {
        i = i-1;
        if (i >= 0) {
            $(".record-timer").text(i);
            timeout = window.setTimeout(changeNumber, 1000, i);
        }
    }
    var onStartRecording = function(status) {
        $('#async-record-container').unbind("click");
        if (status == "granted") {
            $(".record-timer").show();
            if (timeout) {window.clearTimeout(timeout); timeout = null;}
            changeNumber(15);
            $('#async-record-container').click(AudioManager.stopRecording);
            $('#record-help > img').hide();
            $('#async-record-btn').get(0).src = "http://"+document.location.host+"/static/async_lib/images/record_stop.png";
        } else {
            $('#async-record-btn').get(0).src = "http://"+document.location.host+"/static/async_lib/images/record_disabled.png"
            $('#async-record-btn').attr("style", "opacity:0.4");
        }
    };

    var uploadAudioClip = function(str) {
        if (str == "Done") {
            $('#async-record-container').click(function() { AudioManager.startRecording(onStopRecording, onStartRecording); });
            $('#async-record-btn').attr("style", "");
            $('#record-help > img').show();
            $('#async-record-btn').get(0).src = "http://"+document.location.host+"/static/async_lib/images/record_enabled.png";
        } else {
            $(".record-timer").hide();
            $('#async-record-container').unbind("click");
            $('#async-record-btn').attr("style", "width:48px; height:48px;margin-bottom:8px;");
            $('#async-record-btn').get(0).src = "http://"+document.location.host+"/static/images/spinner.gif";
        }
    };

    function onHover(event) {
        if (event.type == 'mouseover') {
            $(".bubble-share", this).show();
        } else {
            $(".bubble-share", this).hide();
        }
    }

    $(document).ready(function() {
        var btn = $('#async-record-btn').get(0);
        btn.ondragenter = btn.ondragover = btn.ondrop = function (evt) {
            evt.stopPropagation();
            evt.preventDefault();
            var file = evt.dataTransfer && evt.dataTransfer.files && evt.dataTransfer.files[0];
            if (file)
                onStopRecording(file);
            return false;
        };
        var img1 = new Image();
        img1.src = "http://"+document.location.host+"/static/async_lib/images/record_enabled.png";
        var img2 = new Image();
        img2.src = "http://"+document.location.host+"/static/async_lib/images/record_stop.png";
        var img3 = new Image();
        img3.src = "http://"+document.location.host+"/static/images/spinner.gif";
        var imgArray = [img1,img2,img3];

        if (navigator.appName.indexOf("Explorer") > 0 && navigator.appVersion.indexOf("9") < 0) {
            $("#browser-info").html('<strong>Internet Explorer</strong> is currently not fully supported. Click to download any of the following browsers to get the full experience.<div id="browsers"><a href="http://www.google.com/chrome" target="_blank"><img class="sup-browser" src="http://'+document.location.host+'/static/images/chrome.png" /></a><a href="http://www.apple.com/safari/" target="_blank"><img class="sup-browser" src="http://'+document.location.host+'/static/images/safari.png" /></a><a href="http://www.firefox.com" target="_blank"><img class="sup-browser" src="http://'+document.location.host+'/static/images/ff.png" /></a><a href="http://www.opera.com/browser/download/" target="_blank"><img class="sup-browser" src="http://'+document.location.host+'/static/images/opera.png" /></a></div>');
            $("#browser-info").show();
            $("#record-browser-info").show();
            $("#ap_container").hide();
            $("#record-help").hide();
            $('#async-record-btn').get(0).src = "http://"+document.location.host+"/static/async_lib/images/record_disabled.png";
        } else {
            autoplay = $("#autoplay_ctl_box").attr("checked");
            $("#autoplay_ctl_box").bind("change", function() {
                autoplay = this.checked;
            });
            $('#async-record-container').click(function() { AudioManager.startRecording(onStopRecording, onStartRecording); });
        }
        $('.async-map-img').live('click', closeMap);
        $('#async-submit-btn').click(sendText);
        $('#async-submit-text').keypress(function(event) {
            if (event.keyCode == '13') {
                event.preventDefault();
                sendText();
            }
        });

        window.fbAsyncInit = function() {
            FB.init({appId: '108110849250956', cookie: true, xfbml: true});
        };
        (function() {
            var e = document.createElement('script'); e.async = true;
            e.src = document.location.protocol +
              '//connect.facebook.net/en_US/all.js';
            document.getElementById('fb-root').appendChild(e);
        }());

        $(".async-speech-bubble").live('mouseover mouseout', onHover);
        $(".remove-entry").live("click", function() {
            remove_entry($(this).closest(".async-entry").attr("id"));
        });
    });
}

