{
    var timeout = null;
    function changeNumber(i) {      
        i = i-1;
        if (i >= 0) {
            $(".record-timer").text(i);
            timeout = window.setTimeout(changeNumber, 1000, i);
        }      
    }

    function onStopRecording(audioData) {
        uploadAudioClip("Start");
        if (audioData!="" && ! audioData.error) {
$("p").html(audioData);
            uploadAudioClip("Done");
        }      
    }

    function onStartRecording(status) {
        $('#async-record-container').unbind("click");
        if (status == "granted") {         
            $(".record-timer").show();
            if (timeout) {window.clearTimeout(timeout); timeout = null;}
            changeNumber(11);
            $('#async-record-container').click(AudioManager.stopRecording);
            $('#async-record-btn').get(0).src = "record_stop.png";
        } else {          
            $('#async-record-btn').get(0).src = "record_disabled.png";
            $('#async-record-btn').attr("style", "opacity:0.4");
        }       
    }

    function uploadAudioClip(str) {     
        if (str == "Done") {
            $('#async-record-container').click(function() { AudioManager.startRecording(onStopRecording, onStartRecording); });
            $('#async-record-btn').attr("style", "");
            $('#async-record-btn').get(0).src = "record_enabled.png";
        } else {
            $(".record-timer").hide();
            $('#async-record-container').unbind("click");
            $('#async-record-btn').attr("style", "width:48px; height:48px;margin-bottom:8px;");
            $('#async-record-btn').get(0).src = "spinner.gif";
        }
    }

    $(document).ready(function() {
        $('#async-record-container').click(function() {
            AudioManager.startRecording(onStopRecording, onStartRecording);
        });
    });
}

