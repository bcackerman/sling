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

