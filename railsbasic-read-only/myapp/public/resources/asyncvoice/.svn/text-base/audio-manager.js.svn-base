if(!self.AudioManager)
    self.AudioManager = {};
(function() {
    var _recordTimer;
    var _flashLocation = "";
    var _js_status = "not_granted";


    AudioManager.init = function(options) {
        // init Flash content
        _flashLocation = options.flashLocation;
        var _flashContent = '<object id="flashRecorder" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="230" height="150" align="middle">';
        _flashContent += '<param name="allowScriptAccess" value="always" />';
        _flashContent += '<param name="movie" value="'+_flashLocation+'" />';
        _flashContent += '<param name="quality" value="high" />';
        _flashContent += '<param name="wmode" value="window" />';
        _flashContent += '<embed src="'+_flashLocation+'" wmode="window" quality="high" bgcolor="#ffffff" width="230" height="150" name="flashRecorder" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
        _flashContent += '</object>';
        var flashDiv = document.createElement("div");
        flashDiv.setAttribute("style", "position:absolute; top:-9999px; left:-9999px; width:300px; height:160px;");
        flashDiv.id = "flash_content";
        flashDiv.innerHTML = _flashContent;
        var b = document.getElementsByTagName("body");
        if (b.length > 0)
            b[0].appendChild(flashDiv);
        else document.body.appendChild(flashDiv);
    }
    /**
    *
    * @class <code>AudioManager</code> is a static helper object for recording
    * 									audio from the browser.
    */
    //AudioManager= {};

    /**
     * Records audio data from the browser, current solution only uses
     * FLASH 10.1 to record audio. The method takes a callback function as argument.
     * The audio will be recorded for a maximum of 14 seconds before the stop
     * callback function is triggered automatically, use the <code>stopRecording</code>
     * to stop the recording earlier. The audio data will in both cases be returned
     * as argument to the callback function.
     *
     * @param {Function} stopCb The callback that should be triggered when the
     * 							recording is finished.
     *
     * @returns {String} audioData Returns the audio data as a base64 encoded
     * 							String.
     */
    AudioManager.startRecording = function(stopCb, startCb) {
        /**
         * Stops the audio recording and triggers the callback function added in
         * <code>startRecording</code>. Can not be called before
         * <code>startRecording</code>.
         *
         *
         * @returns {String} audioData Returns the audio data as a base64 encoded
         * 							String.
         */
        AudioManager.stopRecording = function() {
            clearTimeout(_recordTimer);
            AudioManager.stopRecording = null;
            AudioManager.recordingStarted = null;
            var audioData = _getFlashRecorder().stopRecord();
            if (stopCb instanceof Function) stopCb(audioData);
        };

        AudioManager.recordingStarted = function(status) {
            document.getElementById("flash_content").style.top = "-9999px";
            document.getElementById("flash_content").style.left = "-9999px";
            _js_status = status =="Microphone.Muted" ? "not_granted" : "granted";
            if (startCb instanceof Function)
                startCb(_js_status);
            if (_js_status == "granted") {
                _recordTimer = setTimeout(function() { AudioManager.stopRecording(); }, 14000);
            } else {
                AudioManager.stopRecording = null;
                AudioManager.recordingStarted = null;
            }
        };
        var f = _getFlashRecorder();
        if (f && f.startRecord) {
            f.startRecord();
            if (_js_status == "granted") {
                document.getElementById("flash_content").style.top = "-9999px";
                document.getElementById("flash_content").style.left = "-9999px";
                if (startCb instanceof Function) {
                    startCb(_js_status);
                }
            } else {
                document.getElementById("flash_content").style.top = "10px";
                document.getElementById("flash_content").style.left = "10px";
            }
        } else stopCb({"error":"true", "message": "Could not find start record function"});
    };

    var _getFlashRecorder = function() {
       if (navigator.appName.indexOf("Microsoft") != -1) {
            return window["flashRecorder"];
       } else {
           return document["flashRecorder"];
       }
    };
})();

