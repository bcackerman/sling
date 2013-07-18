package {
    import flash.events.*;
    import flash.display.*;
    import flash.media.*;
    import flash.net.*;
    import flash.external.*;

    public class RecorderJSInterface {

        public static var READY:String = "ready";
        public static var NO_MICROPHONE_FOUND:String = "no_microphone_found";
        public static var MICROPHONE_USER_REQUEST:String = "microphone_user_request";
        public static var MICROPHONE_CONNECTED:String = "microphone_connected";
        public static var MICROPHONE_NOT_CONNECTED:String = "microphone_not_connected";
        public static var RECORDING:String = "recording";
        public static var RECORDING_STOPPED:String = "recording_stopped";
        public static var PLAYING:String = "playing";
        public static var STOPPED:String = "stopped";
        public static var SAVE_PRESSED:String = "save_pressed";
        public static var SAVING:String = "saving";
        public static var SAVED:String = "saved";
        public static var SAVE_FAILED:String = "save_failed";
        public static var SAVE_PROGRESS:String = "save_progress";

        public var recorder:MicrophoneRecorder;
        public var authenticityToken:String = "";
        public var eventHandler:String = "microphone_recorder_events";
        public var uploadUrl:String;
        public var uploadFormData:Array;
        public var uploadFieldName:String;
        public var saveButton:DisplayObject;

        public function RecorderJSInterface(){
            this.recorder = new MicrophoneRecorder();
            if (((ExternalInterface.available) && (ExternalInterface.objectID))){
                ExternalInterface.addCallback("record", this.record);
                ExternalInterface.addCallback("playBack", this.playBack);
                ExternalInterface.addCallback("stopPlayBack", this.stopPlayBack);
                ExternalInterface.addCallback("duration", this.duration);
                ExternalInterface.addCallback("init", this.init);
                ExternalInterface.addCallback("permit", this.requestMicrophoneAccess);
                ExternalInterface.addCallback("configure", this.configureMicrophone);
                ExternalInterface.addCallback("show", this.show);
                ExternalInterface.addCallback("hide", this.hide);
                ExternalInterface.addCallback("update", this.update);
                ExternalInterface.addCallback("setUseEchoSuppression", this.setUseEchoSuppression);
                ExternalInterface.addCallback("setLoopBack", this.setLoopBack);
                ExternalInterface.addCallback("getMicrophone", this.getMicrophone);
            };
            this.recorder.addEventListener(MicrophoneRecorder.SOUND_COMPLETE, this.playComplete);
            this.recorder.addEventListener(MicrophoneRecorder.PLAYBACK_STARTED, this.playbackStarted);
        }
        public function ready(_arg1:int, _arg2:int):void{
            ExternalInterface.call(this.eventHandler, RecorderJSInterface.READY, _arg1, _arg2);
        }
        public function show():void{
            if (this.saveButton){
                this.saveButton.visible = true;
            };
        }
        public function hide():void{
            if (this.saveButton){
                this.saveButton.visible = false;
            };
        }
        private function playbackStarted(_arg1:Event):void{
            ExternalInterface.call(this.eventHandler, MicrophoneRecorder.PLAYBACK_STARTED, this.recorder.currentSoundName, this.recorder.latency);
        }
        private function playComplete(_arg1:Event):void{
            ExternalInterface.call(this.eventHandler, RecorderJSInterface.STOPPED, this.recorder.currentSoundName);
        }
        public function init(_arg1:String=null, _arg2:String=null, _arg3:Array=null):void{
            this.uploadUrl = _arg1;
            this.uploadFieldName = _arg2;
            this.update(_arg3);
        }
        public function update(_arg1:Array=null):void{
            var _local2:int;
            var _local3:Object;
            this.uploadFormData = new Array();
            if (_arg1){
                _local2 = 0;
                while (_local2 < _arg1.length) {
                    _local3 = _arg1[_local2];
                    this.uploadFormData.push(MultiPartFormUtil.nameValuePair(_local3.name, _local3.value));
                    _local2++;
                };
            };
        }
        public function isMicrophoneAvailable():Boolean{
            if (!this.recorder.mic.muted){
                return (true);
            };
            if (Microphone.names.length == 0){
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.NO_MICROPHONE_FOUND);
            } else {
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.MICROPHONE_USER_REQUEST);
            };
            return (false);
        }
        public function requestMicrophoneAccess():void{
            this.recorder.mic.addEventListener(StatusEvent.STATUS, this.onMicrophoneStatus);
            this.recorder.mic.setLoopBack();
        }
        private function onMicrophoneStatus(_arg1:StatusEvent):void{
            this.recorder.mic.setLoopBack(false);
            if (_arg1.code == "Microphone.Unmuted"){
                this.configureMicrophone();
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.MICROPHONE_CONNECTED, this.recorder.mic);
            } else {
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.MICROPHONE_NOT_CONNECTED);
            };
        }
        public function configureMicrophone(_arg1:int=22, _arg2:int=100, _arg3:Number=0, _arg4:int=4000):void{
            this.recorder.mic.rate = _arg1;
            this.recorder.mic.gain = _arg2;
            this.recorder.mic.setSilenceLevel(_arg3, _arg4);
        }
        public function setUseEchoSuppression(_arg1:Boolean):void{
            this.recorder.mic.setUseEchoSuppression(_arg1);
        }
        public function setLoopBack(_arg1:Boolean):void{
            this.recorder.mic.setLoopBack(_arg1);
        }
        public function getMicrophone():Microphone{
            return (this.recorder.mic);
        }
        public function record(_arg1:String, _arg2:String=null):Boolean{
            if (!this.isMicrophoneAvailable()){
                return (false);
            };
            if (this.recorder.recording){
                this.recorder.stop();
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.RECORDING_STOPPED, this.recorder.currentSoundName, this.recorder.duration());
            } else {
                this.recorder.record(_arg1, _arg2);
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.RECORDING, this.recorder.currentSoundName);
            };
            return (this.recorder.recording);
        }
        public function playBack(_arg1:String):Boolean{
            if (this.recorder.playing){
                this.recorder.stop();
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.STOPPED, this.recorder.currentSoundName);
            } else {
                this.recorder.playBack(_arg1);
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.PLAYING, this.recorder.currentSoundName);
            };
            return (this.recorder.playing);
        }
        public function stopPlayBack():void{
            if (this.recorder.recording){
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.RECORDING_STOPPED, this.recorder.currentSoundName, this.recorder.duration());
            } else {
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.STOPPED, this.recorder.currentSoundName);
            };
            this.recorder.stop();
        }
        public function duration(_arg1:String):Number{
            return (this.recorder.duration(_arg1));
        }
        public function save():Boolean{
            ExternalInterface.call(this.eventHandler, RecorderJSInterface.SAVE_PRESSED, this.recorder.currentSoundName);
            try {
                this._save(this.recorder.currentSoundName, this.recorder.currentSoundFilename);
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.SAVING, this.recorder.currentSoundName);
            } catch(e:Error) {
                ExternalInterface.call(this.eventHandler, RecorderJSInterface.SAVE_FAILED, this.recorder.currentSoundName, e.message);
                return (false);
            };
            return (true);
        }
        private function _save(_arg1:String, _arg2:String):void{
            var _local3:String = MultiPartFormUtil.boundary();
            this.uploadFormData.push(MultiPartFormUtil.fileField(this.uploadFieldName, this.recorder.convertToWav(_arg1), _arg2, "audio/x-wav"));
            var _local4:URLRequest = MultiPartFormUtil.request(this.uploadFormData);
            this.uploadFormData.pop();
            _local4.url = this.uploadUrl;
            var _local5:URLLoader = new URLLoader();
            _local5.addEventListener(Event.COMPLETE, this.onSaveComplete);
            _local5.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            _local5.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            _local5.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            _local5.load(_local4);
        }
        private function onSaveComplete(_arg1:Event):void{
            var _local2:URLLoader = URLLoader(_arg1.target);
            ExternalInterface.call(this.eventHandler, RecorderJSInterface.SAVED, this.recorder.currentSoundName, _local2.data);
        }
        private function onIOError(_arg1:Event):void{
            ExternalInterface.call(this.eventHandler, RecorderJSInterface.SAVE_FAILED, this.recorder.currentSoundName, IOErrorEvent(_arg1).text);
        }
        private function onSecurityError(_arg1:Event):void{
            ExternalInterface.call(this.eventHandler, RecorderJSInterface.SAVE_FAILED, this.recorder.currentSoundName, SecurityErrorEvent(_arg1).text);
        }
        private function onProgress(_arg1:Event):void{
            ExternalInterface.call(this.eventHandler, RecorderJSInterface.SAVE_PROGRESS, this.recorder.currentSoundName, ProgressEvent(_arg1).bytesLoaded, ProgressEvent(_arg1).bytesTotal);
        }

    }
}//package 

