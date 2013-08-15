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
package {
    import flash.events.*;
    import flash.display.*;
    import flash.net.*;
    import flash.text.engine.*;

    public class Recorder extends Sprite {

        public var recorderInterface:RecorderJSInterface;
        public var saveButton:InteractiveObject;

        public function Recorder(){
            this.stage.align = StageAlign.TOP_LEFT;
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            this.recorderInterface = new RecorderJSInterface();
            if (this.root.loaderInfo.parameters["event_handler"]){
                this.recorderInterface.eventHandler = this.root.loaderInfo.parameters["event_handler"];
            };
            var _local1:String = this.root.loaderInfo.parameters["upload_image"];
            if (_local1){
                this.saveButton = this.createSaveImage(_local1);
            } else {
                this.saveButton = this.createSaveLink();
                this.ready();
            };
        }
        public function ready():void{
            addChild(this.saveButton);
            this.recorderInterface.saveButton = this.saveButton;
            this.saveButton.addEventListener(MouseEvent.MOUSE_UP, this.mouseReleased);
            this.saveButton.visible = false;
            this.recorderInterface.ready(this.saveButton.width, this.saveButton.height);
        }
        public function save():void{
            this.recorderInterface.save();
        }
        private function mouseReleased(_arg1:MouseEvent):void{
            this.save();
        }
        private function createSaveLink():Sprite{
            var _local1:ElementFormat = new ElementFormat();
            var _local2:Number = 238;
            if (this.root.loaderInfo.parameters["font_color"]){
                _local2 = parseInt(this.root.loaderInfo.parameters["font_color"], 16);
            };
            var _local3:Number = 12;
            if (this.root.loaderInfo.parameters["font_size"]){
                _local3 = parseInt(this.root.loaderInfo.parameters["font_size"], 10);
            };
            _local1.color = _local2;
            _local1.fontSize = _local3;
            var _local4:TextBlock = new TextBlock();
            var _local5 = "Save";
            if (this.root.loaderInfo.parameters["save_text"]){
                _local5 = this.root.loaderInfo.parameters["save_text"];
            };
            _local4.content = new TextElement(_local5, _local1);
            var _local6:TextLine = _local4.createTextLine();
            var _local7:Sprite = new Sprite();
            _local7.buttonMode = true;
            _local7.addChild(_local6);
            _local6.y = _local6.ascent;
            if (this.root.loaderInfo.parameters["background_color"]){
                _local7.graphics.beginFill(parseInt(this.root.loaderInfo.parameters["background_color"], 16));
                _local7.graphics.drawRect(0, 0, _local7.width, _local7.height);
            };
            _local7.graphics.lineStyle(1, _local2);
            _local7.graphics.moveTo(0, (_local6.height - 1));
            _local7.graphics.lineTo(_local7.width, (_local6.height - 1));
            return (_local7);
        }
        private function createSaveImage(_arg1:String):Sprite{
            var _local2:Sprite = new Sprite();
            var _local3:Loader = new Loader();
            _local3.contentLoaderInfo.addEventListener(Event.COMPLETE, this.imageCompleteHandler);
            _local3.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.imageIoErrorHandler);
            _local3.load(new URLRequest(_arg1));
            _local2.addChild(_local3);
            _local2.buttonMode = true;
            return (_local2);
        }
        private function imageCompleteHandler(_arg1:Event):void{
            this.ready();
        }
        private function imageIoErrorHandler(_arg1:Event):void{
            this.saveButton = this.createSaveLink();
            this.ready();
        }

    }
}//package 
package {
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;

    public class MicrophoneRecorder extends EventDispatcher {

        public static var SOUND_COMPLETE:String = "sound_complete";
        public static var PLAYBACK_STARTED:String = "playback_started";

        public var mic:Microphone;
        public var sound:Sound;
        public var soundChannel:SoundChannel;
        public var sounds:Dictionary;
        public var rates:Dictionary;
        public var currentSoundName:String = "";
        public var currentSoundFilename:String = "";
        public var recording:Boolean = false;
        public var playing:Boolean = false;
        public var samplingStarted:Boolean = false;
        public var latency:Number = 0;

        public function MicrophoneRecorder(){
            this.sound = new Sound();
            this.sounds = new Dictionary();
            this.rates = new Dictionary();
            super();
            this.mic = Microphone.getMicrophone();
            this.sound.addEventListener(SampleDataEvent.SAMPLE_DATA, this.playbackSampleHandler);
        }
        public static function frequency(_arg1:int):int{
            switch (_arg1){
                case 44:
                    return (44100);
                case 22:
                    return (22050);
                case 11:
                    return (11025);
                case 8:
                    return (8000);
                case 5:
                    return (5512);
            };
            return (0);
        }
        public static function convertToWav(_arg1:ByteArray, _arg2:int):ByteArray{
            var _local7:Number;
            var _local8:int;
            var _local3:ByteArray = new ByteArray();
            _local3.endian = Endian.LITTLE_ENDIAN;
            var _local4:uint = (_arg1.length / 2);
            var _local5 = 1;
            var _local6 = 16;
            _local3.writeUTFBytes("RIFF");
            _local3.writeUnsignedInt((36 + _local4));
            _local3.writeUTFBytes("WAVE");
            _local3.writeUTFBytes("fmt ");
            _local3.writeUnsignedInt(16);
            _local3.writeShort(1);
            _local3.writeShort(_local5);
            _local3.writeUnsignedInt(_arg2);
            _local3.writeUnsignedInt((((_arg2 * _local5) * _local6) / 8));
            _local3.writeShort(((_local5 * _local6) / 8));
            _local3.writeShort(_local6);
            _local3.writeUTFBytes("data");
            _local3.writeUnsignedInt(_local4);
            _arg1.position = 0;
            while (_arg1.bytesAvailable > 0) {
                _local7 = _arg1.readFloat();
                _local8 = (_local7 * 0x8000);
                _local3.writeShort(_local8);
            };
            return (_local3);
        }

        public function reset():void{
            this.stop();
            this.sounds = new Dictionary();
            this.rates = new Dictionary();
            this.currentSoundName = "";
            this.recording = false;
            this.playing = false;
        }
        public function record(_arg1:String, _arg2:String=""):void{
            this.stop();
            this.currentSoundName = _arg1;
            this.currentSoundFilename = _arg2;
            var _local3:ByteArray = this.getSoundBytes(_arg1, true);
            _local3.position = 0;
            this.rates[_arg1] = this.mic.rate;
            this.samplingStarted = true;
            this.mic.addEventListener(SampleDataEvent.SAMPLE_DATA, this.micSampleDataHandler);
            this.recording = true;
        }
        public function playBack(_arg1:String):void{
            this.stop();
            this.currentSoundName = _arg1;
            var _local2:ByteArray = this.getSoundBytes();
            _local2.position = 0;
            this.samplingStarted = true;
            this.playing = true;
            this.soundChannel = this.sound.play();
            this.soundChannel.addEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
        }
        public function stop():void{
            if (this.soundChannel){
                this.soundChannel.stop();
                this.soundChannel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
                this.soundChannel = null;
            };
            if (this.playing){
                this.playing = false;
            };
            if (this.recording){
                this.mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.micSampleDataHandler);
                this.recording = false;
            };
        }
        private function onSoundComplete(_arg1:Event):void{
            this.stop();
            dispatchEvent(new Event(MicrophoneRecorder.SOUND_COMPLETE));
        }
        public function getSoundBytes(_arg1:String=null, _arg2:Boolean=false):ByteArray{
            if (!_arg1){
                _arg1 = this.currentSoundName;
            };
            var _local3:ByteArray = ByteArray(this.sounds[_arg1]);
            if (_arg2){
                if (_local3){
                    delete this.sounds[_arg1];
                };
                _local3 = new ByteArray();
                this.sounds[_arg1] = _local3;
            };
            return (_local3);
        }
        private function micSampleDataHandler(_arg1:SampleDataEvent):void{
            var _local2:ByteArray = this.getSoundBytes();
            while (_arg1.data.bytesAvailable) {
                _local2.writeFloat(_arg1.data.readFloat());
            };
        }
        private function playbackSampleHandler(_arg1:SampleDataEvent):void{
            var _local2 = 0x0C00;
            var _local3:int;
            var _local4:Number = 0;
            if (!this.soundChannel){
                while (_local3 < _local2) {
                    _arg1.data.writeFloat(_local4);
                    _arg1.data.writeFloat(_local4);
                    _local3++;
                };
                return;
            };
            if (((this.samplingStarted) && (this.soundChannel))){
                this.samplingStarted = false;
                this.latency = ((_arg1.position * 0.02267573696145) - this.soundChannel.position);
                dispatchEvent(new Event(MicrophoneRecorder.PLAYBACK_STARTED));
            };
            var _local5:int = this.rate();
            if (_local5 == 22){
                _local2 = 0x0600;
            };
            var _local6:ByteArray = this.getSoundBytes();
            while ((((((_local3 < _local2)) && (_local6.bytesAvailable))) && (this.playing))) {
                _local4 = _local6.readFloat();
                _arg1.data.writeFloat(_local4);
                _arg1.data.writeFloat(_local4);
                if (_local5 == 22){
                    _arg1.data.writeFloat(_local4);
                    _arg1.data.writeFloat(_local4);
                };
                _local3++;
            };
        }
        public function duration(_arg1:String=null):Number{
            if (!_arg1){
                _arg1 = this.currentSoundName;
            };
            var _local2:ByteArray = this.getSoundBytes(_arg1);
            var _local3:int = MicrophoneRecorder.frequency(this.rates[_arg1]);
            var _local4:uint = (_local2.length / 4);
            return ((Number(_local4) / Number(_local3)));
        }
        public function rate(_arg1:String=null):int{
            if (!_arg1){
                _arg1 = this.currentSoundName;
            };
            return (this.rates[_arg1]);
        }
        public function frequency(_arg1:String=null):int{
            return (MicrophoneRecorder.frequency(this.rate(_arg1)));
        }
        public function convertToWav(_arg1:String):ByteArray{
            return (MicrophoneRecorder.convertToWav(this.getSoundBytes(_arg1), MicrophoneRecorder.frequency(this.rates[_arg1])));
        }

    }
}//package 
package {
    import flash.utils.*;
    import flash.net.*;

    public class MultiPartFormUtil {

        public static function boundary():String{
            var _local1 = "---------------------------";
            var _local2:int;
            while (_local2 < 25) {
                _local1 = (_local1 + Math.floor((Math.random() * 10)).toString());
                _local2++;
            };
            return (_local1);
        }
        public static function nameValuePair(_arg1:String, _arg2:Object):Object{
            var _local3:Object = new Object();
            _local3.name = _arg1;
            _local3.value = _arg2;
            return (_local3);
        }
        public static function fileField(_arg1:String, _arg2:ByteArray, _arg3:String, _arg4:String):Object{
            var _local5:Object = new Object();
            _local5.name = _arg1;
            _local5.value = new Object();
            _local5.value.data = _arg2;
            _local5.value.filename = _arg3;
            _local5.value.type = _arg4;
            return (_local5);
        }
        public static function request(_arg1:Array):URLRequest{
            var _local2:URLRequest = new URLRequest();
            MultiPartFormUtil.setup(_local2, _arg1);
            return (_local2);
        }
        public static function setup(_arg1:URLRequest, _arg2:Array):void{
            var _local3:String = MultiPartFormUtil.boundary();
            _arg1.method = URLRequestMethod.POST;
            _arg1.contentType = ("multipart/form-data; boundary=" + _local3);
            _arg1.data = MultiPartFormUtil.requestData(_arg2, _local3);
        }
        public static function requestData(_arg1:Array, _arg2:String):ByteArray{
            var _local6:Object;
            var _local7:String;
            var _local3:ByteArray = new ByteArray();
            _local3.writeByte(13);
            _local3.writeByte(10);
            var _local4:ByteArray = new ByteArray();
            var _local5:int;
            while (_local5 < _arg1.length) {
                _local6 = _arg1[_local5];
                _local7 = _local6.name;
                _local4.writeUTFBytes(("--" + _arg2));
                _local4.writeBytes(_local3);
                if (_local6.value.hasOwnProperty("data")){
                    if (_local6.value.hasOwnProperty("filename")){
                        _local4.writeUTFBytes((((("Content-Disposition: form-data; name=\"" + _local7) + "\"; filename=\"") + _local6.value.filename) + "\""));
                    } else {
                        _local4.writeUTFBytes((("Content-Disposition: form-data; name=\"" + _local7) + "\""));
                    };
                    _local4.writeBytes(_local3);
                    if (_local6.value.hasOwnProperty("type")){
                        _local4.writeUTFBytes(("Content-Type: " + _local6.value.type));
                        _local4.writeBytes(_local3);
                    };
                    _local4.writeBytes(_local3);
                    _local4.writeBytes(_local6.value.data);
                    _local4.writeBytes(_local3);
                } else {
                    _local4.writeUTFBytes((("Content-Disposition: form-data; name=\"" + _local7) + "\""));
                    _local4.writeBytes(_local3);
                    _local4.writeBytes(_local3);
                    _local4.writeUTFBytes(_local6.value.toString());
                    _local4.writeBytes(_local3);
                };
                _local5++;
            };
            _local4.writeUTFBytes((("--" + _arg2) + "--"));
            return (_local4);
        }
        public static function requestDataAsString(_arg1:Array, _arg2:String):String{
            var _local5:Object;
            var _local6:String;
            var _local3 = "";
            var _local4:int;
            while (_local4 < _arg1.length) {
                _local5 = _arg1[_local4];
                _local6 = _local5.name;
                _local3 = (_local3 + ("--" + _arg2));
                _local3 = (_local3 + "\r\n");
                if (_local5.value.hasOwnProperty("data")){
                    if (_local5.value.hasOwnProperty("filename")){
                        _local3 = (_local3 + (((("Content-Disposition: form-data; name=\"" + _local6) + "\"; filename=\"") + _local5.value.filename) + "\""));
                    } else {
                        _local3 = (_local3 + (("Content-Disposition: form-data; name=\"" + _local6) + "\""));
                    };
                    _local3 = (_local3 + "\r\n");
                    if (_local5.value.hasOwnProperty("type")){
                        _local3 = (_local3 + ("Content-Type: " + _local5.value.type));
                        _local3 = (_local3 + "\r\n");
                    };
                    _local3 = (_local3 + "Content-Transfer-Encoding: base64");
                    _local3 = (_local3 + "\r\n");
                    _local3 = (_local3 + "\r\n");
                    _local3 = (_local3 + MultiPartFormUtil.base64_encdode(_local5.value.data));
                    _local3 = (_local3 + "\r\n");
                } else {
                    _local3 = (_local3 + (("Content-Disposition: form-data; name=\"" + _local6) + "\""));
                    _local3 = (_local3 + "\r\n");
                    _local3 = (_local3 + "\r\n");
                    _local3 = (_local3 + _local5.value.toString());
                    _local3 = (_local3 + "\r\n");
                };
                _local4++;
            };
            _local3 = (_local3 + (("--" + _arg2) + "--"));
            return (_local3);
        }
        public static function base64_encdode(_arg1:ByteArray):String{
            var _local3:int;
            var _local4:int;
            var _local5:int;
            var _local6:int;
            var _local7:int;
            var _local8:int;
            var _local9:int;
            var _local10:int;
            var _local2 = "";
            _arg1.position = 0;
            while (_arg1.bytesAvailable) {
                _local3 = _arg1.readByte();
                _local4 = 0;
                _local5 = 0;
                _local6 = 0;
                if (_arg1.bytesAvailable){
                    _local4 = _arg1.readByte();
                } else {
                    _local6 = 2;
                };
                if (_arg1.bytesAvailable){
                    _local5 = _arg1.readByte();
                } else {
                    _local6 = 1;
                };
                _local7 = ((_local3 & 252) >> 2);
                _local8 = (((_local3 & 3) << 4) | ((_local4 & 240) >> 4));
                _local9 = (((_local4 & 15) << 2) | ((_local5 & 192) >> 6));
                _local10 = (_local5 & 63);
                _local2 = (_local2 + (MultiPartFormUtil.base64_character(_local7) + MultiPartFormUtil.base64_character(_local8)));
                if (_local6 == 0){
                    _local2 = (_local2 + (MultiPartFormUtil.base64_character(_local9) + MultiPartFormUtil.base64_character(_local10)));
                } else {
                    if (_local6 == 1){
                        _local2 = (_local2 + (MultiPartFormUtil.base64_character(_local9) + "="));
                    } else {
                        _local2 = (_local2 + "==");
                    };
                };
            };
            return (_local2);
        }
        public static function base64_character(_arg1:int):String{
            if ((((_arg1 >= 0)) && ((_arg1 < 26)))){
                return (String.fromCharCode((65 + _arg1)));
            };
            if ((((_arg1 >= 26)) && ((_arg1 < 52)))){
                return (String.fromCharCode(((97 + _arg1) - 26)));
            };
            if ((((_arg1 >= 52)) && ((_arg1 < 62)))){
                return (String.fromCharCode(((48 + _arg1) - 52)));
            };
            if (_arg1 == 62){
                return ("+");
            };
            if (_arg1 == 63){
                return ("/");
            };
            return ("");
        }

    }
}//package
