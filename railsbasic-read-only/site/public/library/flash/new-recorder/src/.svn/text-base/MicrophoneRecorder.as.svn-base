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

