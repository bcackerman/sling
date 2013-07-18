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
