package {
    import flash.display.*;

    public dynamic class Button_emphasizedSkin extends MovieClip {

    }
}//package 
package com.dynamicflash.util {
    import flash.utils.*;

    public class Base64 {

        private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        public static const version:String = "1.1.0";

        public function Base64(){
            throw (new Error("Base64 class is static container only"));
        }
        public static function encode(_arg1:String):String{
            var _local2:ByteArray = new ByteArray();
            _local2.writeUTFBytes(_arg1);
            return (encodeByteArray(_local2));
        }
        public static function encodeByteArray(_arg1:ByteArray):String{
            var _local3:Array;
            var _local5:uint;
            var _local6:uint;
            var _local7:uint;
            var _local2 = "";
            var _local4:Array = new Array(4);
            _arg1.position = 0;
            while (_arg1.bytesAvailable > 0) {
                _local3 = new Array();
                _local5 = 0;
                while ((((_local5 < 3)) && ((_arg1.bytesAvailable > 0)))) {
                    _local3[_local5] = _arg1.readUnsignedByte();
                    _local5++;
                };
                _local4[0] = ((_local3[0] & 252) >> 2);
                _local4[1] = (((_local3[0] & 3) << 4) | (_local3[1] >> 4));
                _local4[2] = (((_local3[1] & 15) << 2) | (_local3[2] >> 6));
                _local4[3] = (_local3[2] & 63);
                _local6 = _local3.length;
                while (_local6 < 3) {
                    _local4[(_local6 + 1)] = 64;
                    _local6++;
                };
                _local7 = 0;
                while (_local7 < _local4.length) {
                    _local2 = (_local2 + BASE64_CHARS.charAt(_local4[_local7]));
                    _local7++;
                };
            };
            return (_local2);
        }
        public static function decode(_arg1:String):String{
            var _local2:ByteArray = decodeToByteArray(_arg1);
            return (_local2.readUTFBytes(_local2.length));
        }
        public static function decodeToByteArray(_arg1:String):ByteArray{
            var _local6:uint;
            var _local7:uint;
            var _local2:ByteArray = new ByteArray();
            var _local3:Array = new Array(4);
            var _local4:Array = new Array(3);
            var _local5:uint;
            while (_local5 < _arg1.length) {
                _local6 = 0;
                while ((((_local6 < 4)) && (((_local5 + _local6) < _arg1.length)))) {
                    _local3[_local6] = BASE64_CHARS.indexOf(_arg1.charAt((_local5 + _local6)));
                    _local6++;
                };
                _local4[0] = ((_local3[0] << 2) + ((_local3[1] & 48) >> 4));
                _local4[1] = (((_local3[1] & 15) << 4) + ((_local3[2] & 60) >> 2));
                _local4[2] = (((_local3[2] & 3) << 6) + _local3[3]);
                _local7 = 0;
                while (_local7 < _local4.length) {
                    if (_local3[(_local7 + 1)] == 64){
                        break;
                    };
                    _local2.writeByte(_local4[_local7]);
                    _local7++;
                };
                _local5 = (_local5 + 4);
            };
            _local2.position = 0;
            return (_local2);
        }

    }
}//package com.dynamicflash.util 
package {
    import flash.display.*;

    public dynamic class Button_selectedUpSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class TextArea_disabledSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class Button_selectedOverSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class Button_selectedDisabledSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class Button_upSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class TextArea_upSkin extends MovieClip {

    }
}//package 
package fl.managers {
    import flash.utils.*;
    import fl.core.*;
    import flash.text.*;

    public class StyleManager {

        private static var _instance:StyleManager;

        private var styleToClassesHash:Object;
        private var classToInstancesDict:Dictionary;
        private var classToStylesDict:Dictionary;
        private var classToDefaultStylesDict:Dictionary;
        private var globalStyles:Object;

        public function StyleManager(){
            styleToClassesHash = {};
            classToInstancesDict = new Dictionary(true);
            classToStylesDict = new Dictionary(true);
            classToDefaultStylesDict = new Dictionary(true);
            globalStyles = UIComponent.getStyleDefinition();
        }
        private static function getInstance(){
            if (_instance == null){
                _instance = new (StyleManager)();
            };
            return (_instance);
        }
        public static function registerInstance(_arg1:UIComponent):void{
            var target:* = null;
            var defaultStyles:* = null;
            var styleToClasses:* = null;
            var n:* = null;
            var instance:* = _arg1;
            var inst:* = getInstance();
            var classDef:* = getClassDef(instance);
            if (classDef == null){
                return;
            };
            if (inst.classToInstancesDict[classDef] == null){
                inst.classToInstancesDict[classDef] = new Dictionary(true);
                target = classDef;
                while (defaultStyles == null) {
                    if (target["getStyleDefinition"] != null){
                        defaultStyles = target["getStyleDefinition"]();
                        break;
                    };
                    try {
                        target = (instance.loaderInfo.applicationDomain.getDefinition(getQualifiedSuperclassName(target)) as Class);
                    } catch(err:Error) {
                        try {
                            target = (getDefinitionByName(getQualifiedSuperclassName(target)) as Class);
                        } catch(e:Error) {
                            defaultStyles = UIComponent.getStyleDefinition();
                            break;
                        };
                    };
                };
                styleToClasses = inst.styleToClassesHash;
                for (n in defaultStyles) {
                    if (styleToClasses[n] == null){
                        styleToClasses[n] = new Dictionary(true);
                    };
                    styleToClasses[n][classDef] = true;
                };
                inst.classToDefaultStylesDict[classDef] = defaultStyles;
                if (inst.classToStylesDict[classDef] == null){
                    inst.classToStylesDict[classDef] = {};
                };
            };
            inst.classToInstancesDict[classDef][instance] = true;
            setSharedStyles(instance);
        }
        private static function setSharedStyles(_arg1:UIComponent):void{
            var _local5:String;
            var _local2:StyleManager = getInstance();
            var _local3:Class = getClassDef(_arg1);
            var _local4:Object = _local2.classToDefaultStylesDict[_local3];
            for (_local5 in _local4) {
                _arg1.setSharedStyle(_local5, getSharedStyle(_arg1, _local5));
            };
        }
        private static function getSharedStyle(_arg1:UIComponent, _arg2:String):Object{
            var _local3:Class = getClassDef(_arg1);
            var _local4:StyleManager = getInstance();
            var _local5:Object = _local4.classToStylesDict[_local3][_arg2];
            if (_local5 != null){
                return (_local5);
            };
            _local5 = _local4.globalStyles[_arg2];
            if (_local5 != null){
                return (_local5);
            };
            return (_local4.classToDefaultStylesDict[_local3][_arg2]);
        }
        public static function getComponentStyle(_arg1:Object, _arg2:String):Object{
            var _local3:Class = getClassDef(_arg1);
            var _local4:Object = getInstance().classToStylesDict[_local3];
            return (((_local4)==null) ? null : _local4[_arg2]);
        }
        public static function clearComponentStyle(_arg1:Object, _arg2:String):void{
            var _local3:Class = getClassDef(_arg1);
            var _local4:Object = getInstance().classToStylesDict[_local3];
            if (((!((_local4 == null))) && (!((_local4[_arg2] == null))))){
                delete _local4[_arg2];
                invalidateComponentStyle(_local3, _arg2);
            };
        }
        public static function setComponentStyle(_arg1:Object, _arg2:String, _arg3:Object):void{
            var _local4:Class = getClassDef(_arg1);
            var _local5:Object = getInstance().classToStylesDict[_local4];
            if (_local5 == null){
                _local5 = (getInstance().classToStylesDict[_local4] = {});
            };
            if (_local5 == _arg3){
                return;
            };
            _local5[_arg2] = _arg3;
            invalidateComponentStyle(_local4, _arg2);
        }
        private static function getClassDef(_arg1:Object):Class{
            var component:* = _arg1;
            if ((component is Class)){
                return ((component as Class));
            };
            try {
                return ((getDefinitionByName(getQualifiedClassName(component)) as Class));
            } catch(e:Error) {
                if ((component is UIComponent)){
                    try {
                        return ((component.loaderInfo.applicationDomain.getDefinition(getQualifiedClassName(component)) as Class));
                    } catch(e:Error) {
                    };
                };
            };
            return (null);
        }
        private static function invalidateStyle(_arg1:String):void{
            var _local3:Object;
            var _local2:Dictionary = getInstance().styleToClassesHash[_arg1];
            if (_local2 == null){
                return;
            };
            for (_local3 in _local2) {
                invalidateComponentStyle(Class(_local3), _arg1);
            };
        }
        private static function invalidateComponentStyle(_arg1:Class, _arg2:String):void{
            var _local4:Object;
            var _local5:UIComponent;
            var _local3:Dictionary = getInstance().classToInstancesDict[_arg1];
            if (_local3 == null){
                return;
            };
            for (_local4 in _local3) {
                _local5 = (_local4 as UIComponent);
                if (_local5 == null){
                } else {
                    _local5.setSharedStyle(_arg2, getSharedStyle(_local5, _arg2));
                };
            };
        }
        public static function setStyle(_arg1:String, _arg2:Object):void{
            var _local3:Object = getInstance().globalStyles;
            if ((((_local3[_arg1] === _arg2)) && (!((_arg2 is TextFormat))))){
                return;
            };
            _local3[_arg1] = _arg2;
            invalidateStyle(_arg1);
        }
        public static function clearStyle(_arg1:String):void{
            setStyle(_arg1, null);
        }
        public static function getStyle(_arg1:String):Object{
            return (getInstance().globalStyles[_arg1]);
        }

    }
}//package fl.managers 
package fl.managers {
    import fl.controls.*;
    import flash.display.*;
    import flash.utils.*;
    import fl.core.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;

    public class FocusManager implements IFocusManager {

        private var _form:DisplayObjectContainer;
        private var focusableObjects:Dictionary;
        private var focusableCandidates:Array;
        private var activated:Boolean = false;
        private var calculateCandidates:Boolean = true;
        private var lastFocus:InteractiveObject;
        private var _showFocusIndicator:Boolean = true;
        private var lastAction:String;
        private var defButton:Button;
        private var _defaultButton:Button;
        private var _defaultButtonEnabled:Boolean = true;

        public function FocusManager(_arg1:DisplayObjectContainer){
            focusableObjects = new Dictionary(true);
            if (_arg1 != null){
                _form = _arg1;
                activate();
            };
        }
        private function addedHandler(_arg1:Event):void{
            var _local2:DisplayObject = DisplayObject(_arg1.target);
            if (_local2.stage){
                addFocusables(DisplayObject(_arg1.target));
            };
        }
        private function removedHandler(_arg1:Event):void{
            var _local2:int;
            var _local4:InteractiveObject;
            var _local3:DisplayObject = DisplayObject(_arg1.target);
            if ((((_local3 is IFocusManagerComponent)) && ((focusableObjects[_local3] == true)))){
                if (_local3 == lastFocus){
                    IFocusManagerComponent(lastFocus).drawFocus(false);
                    lastFocus = null;
                };
                _local3.removeEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false);
                delete focusableObjects[_local3];
                calculateCandidates = true;
            } else {
                if ((((_local3 is InteractiveObject)) && ((focusableObjects[_local3] == true)))){
                    _local4 = (_local3 as InteractiveObject);
                    if (_local4){
                        if (_local4 == lastFocus){
                            lastFocus = null;
                        };
                        delete focusableObjects[_local4];
                        calculateCandidates = true;
                    };
                    _local3.addEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false, 0, true);
                };
            };
            removeFocusables(_local3);
        }
        private function addFocusables(_arg1:DisplayObject, _arg2:Boolean=false):void{
            var focusable:* = null;
            var io:* = null;
            var doc:* = null;
            var i:* = 0;
            var child:* = null;
            var o:* = _arg1;
            var skipTopLevel:Boolean = _arg2;
            if (!skipTopLevel){
                if ((o is IFocusManagerComponent)){
                    focusable = IFocusManagerComponent(o);
                    if (focusable.focusEnabled){
                        if (((focusable.tabEnabled) && (isTabVisible(o)))){
                            focusableObjects[o] = true;
                            calculateCandidates = true;
                        };
                        o.addEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false, 0, true);
                        o.addEventListener(Event.TAB_INDEX_CHANGE, tabIndexChangeHandler, false, 0, true);
                    };
                } else {
                    if ((o is InteractiveObject)){
                        io = (o as InteractiveObject);
                        if (((((io) && (io.tabEnabled))) && ((findFocusManagerComponent(io) == io)))){
                            focusableObjects[io] = true;
                            calculateCandidates = true;
                        };
                        io.addEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false, 0, true);
                        io.addEventListener(Event.TAB_INDEX_CHANGE, tabIndexChangeHandler, false, 0, true);
                    };
                };
            };
            if ((o is DisplayObjectContainer)){
                doc = DisplayObjectContainer(o);
                o.addEventListener(Event.TAB_CHILDREN_CHANGE, tabChildrenChangeHandler, false, 0, true);
                if ((((((doc is Stage)) || ((doc.parent is Stage)))) || (doc.tabChildren))){
                    i = 0;
                    while (i < doc.numChildren) {
                        try {
                            child = doc.getChildAt(i);
                            if (child != null){
                                addFocusables(doc.getChildAt(i));
                            };
                        } catch(error:SecurityError) {
                        };
                        i = (i + 1);
                    };
                };
            };
        }
        private function removeFocusables(_arg1:DisplayObject):void{
            var _local2:Object;
            var _local3:DisplayObject;
            if ((_arg1 is DisplayObjectContainer)){
                _arg1.removeEventListener(Event.TAB_CHILDREN_CHANGE, tabChildrenChangeHandler, false);
                _arg1.removeEventListener(Event.TAB_INDEX_CHANGE, tabIndexChangeHandler, false);
                for (_local2 in focusableObjects) {
                    _local3 = DisplayObject(_local2);
                    if (DisplayObjectContainer(_arg1).contains(_local3)){
                        if (_local3 == lastFocus){
                            lastFocus = null;
                        };
                        _local3.removeEventListener(Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler, false);
                        delete focusableObjects[_local2];
                        calculateCandidates = true;
                    };
                };
            };
        }
        private function isTabVisible(_arg1:DisplayObject):Boolean{
            var _local2:DisplayObjectContainer = _arg1.parent;
            while (((((_local2) && (!((_local2 is Stage))))) && (!(((_local2.parent) && ((_local2.parent is Stage))))))) {
                if (!_local2.tabChildren){
                    return (false);
                };
                _local2 = _local2.parent;
            };
            return (true);
        }
        private function isValidFocusCandidate(_arg1:DisplayObject, _arg2:String):Boolean{
            var _local3:IFocusManagerGroup;
            if (!isEnabledAndVisible(_arg1)){
                return (false);
            };
            if ((_arg1 is IFocusManagerGroup)){
                _local3 = IFocusManagerGroup(_arg1);
                if (_arg2 == _local3.groupName){
                    return (false);
                };
            };
            return (true);
        }
        private function isEnabledAndVisible(_arg1:DisplayObject):Boolean{
            var _local3:TextField;
            var _local4:SimpleButton;
            var _local2:DisplayObjectContainer = DisplayObject(form).parent;
            while (_arg1 != _local2) {
                if ((_arg1 is UIComponent)){
                    if (!UIComponent(_arg1).enabled){
                        return (false);
                    };
                } else {
                    if ((_arg1 is TextField)){
                        _local3 = TextField(_arg1);
                        if ((((_local3.type == TextFieldType.DYNAMIC)) || (!(_local3.selectable)))){
                            return (false);
                        };
                    } else {
                        if ((_arg1 is SimpleButton)){
                            _local4 = SimpleButton(_arg1);
                            if (!_local4.enabled){
                                return (false);
                            };
                        };
                    };
                };
                if (!_arg1.visible){
                    return (false);
                };
                _arg1 = _arg1.parent;
            };
            return (true);
        }
        private function tabEnabledChangeHandler(_arg1:Event):void{
            calculateCandidates = true;
            var _local2:InteractiveObject = InteractiveObject(_arg1.target);
            var _local3 = (focusableObjects[_local2] == true);
            if (_local2.tabEnabled){
                if (((!(_local3)) && (isTabVisible(_local2)))){
                    if (!(_local2 is IFocusManagerComponent)){
                        _local2.focusRect = false;
                    };
                    focusableObjects[_local2] = true;
                };
            } else {
                if (_local3){
                    delete focusableObjects[_local2];
                };
            };
        }
        private function tabIndexChangeHandler(_arg1:Event):void{
            calculateCandidates = true;
        }
        private function tabChildrenChangeHandler(_arg1:Event):void{
            if (_arg1.target != _arg1.currentTarget){
                return;
            };
            calculateCandidates = true;
            var _local2:DisplayObjectContainer = DisplayObjectContainer(_arg1.target);
            if (_local2.tabChildren){
                addFocusables(_local2, true);
            } else {
                removeFocusables(_local2);
            };
        }
        public function activate():void{
            if (activated){
                return;
            };
            addFocusables(form);
            form.addEventListener(Event.ADDED, addedHandler, false, 0, true);
            form.addEventListener(Event.REMOVED, removedHandler, false, 0, true);
            form.stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
            form.stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
            form.addEventListener(FocusEvent.FOCUS_IN, focusInHandler, true, 0, true);
            form.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, true, 0, true);
            form.stage.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
            form.stage.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
            form.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
            form.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true, 0, true);
            activated = true;
            if (lastFocus){
                setFocus(lastFocus);
            };
        }
        public function deactivate():void{
            if (!activated){
                return;
            };
            focusableObjects = new Dictionary(true);
            focusableCandidates = null;
            lastFocus = null;
            defButton = null;
            form.removeEventListener(Event.ADDED, addedHandler, false);
            form.removeEventListener(Event.REMOVED, removedHandler, false);
            form.stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false);
            form.stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false);
            form.removeEventListener(FocusEvent.FOCUS_IN, focusInHandler, true);
            form.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, true);
            form.stage.removeEventListener(Event.ACTIVATE, activateHandler, false);
            form.stage.removeEventListener(Event.DEACTIVATE, deactivateHandler, false);
            form.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false);
            form.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true);
            activated = false;
        }
        private function focusInHandler(_arg1:FocusEvent):void{
            var _local3:Button;
            if (!activated){
                return;
            };
            var _local2:InteractiveObject = InteractiveObject(_arg1.target);
            if (form.contains(_local2)){
                lastFocus = findFocusManagerComponent(InteractiveObject(_local2));
                if ((lastFocus is Button)){
                    _local3 = Button(lastFocus);
                    if (defButton){
                        defButton.emphasized = false;
                        defButton = _local3;
                        _local3.emphasized = true;
                    };
                } else {
                    if (((defButton) && (!((defButton == _defaultButton))))){
                        defButton.emphasized = false;
                        defButton = _defaultButton;
                        _defaultButton.emphasized = true;
                    };
                };
            };
        }
        private function focusOutHandler(_arg1:FocusEvent):void{
            if (!activated){
                return;
            };
            var _local2:InteractiveObject = (_arg1.target as InteractiveObject);
        }
        private function activateHandler(_arg1:Event):void{
            if (!activated){
                return;
            };
            var _local2:InteractiveObject = InteractiveObject(_arg1.target);
            if (lastFocus){
                if ((lastFocus is IFocusManagerComponent)){
                    IFocusManagerComponent(lastFocus).setFocus();
                } else {
                    form.stage.focus = lastFocus;
                };
            };
            lastAction = "ACTIVATE";
        }
        private function deactivateHandler(_arg1:Event):void{
            if (!activated){
                return;
            };
            var _local2:InteractiveObject = InteractiveObject(_arg1.target);
        }
        private function mouseFocusChangeHandler(_arg1:FocusEvent):void{
            if (!activated){
                return;
            };
            if ((_arg1.relatedObject is TextField)){
                return;
            };
            _arg1.preventDefault();
        }
        private function keyFocusChangeHandler(_arg1:FocusEvent):void{
            if (!activated){
                return;
            };
            showFocusIndicator = true;
            if ((((((_arg1.keyCode == Keyboard.TAB)) || ((_arg1.keyCode == 0)))) && (!(_arg1.isDefaultPrevented())))){
                setFocusToNextObject(_arg1);
                _arg1.preventDefault();
            };
        }
        private function keyDownHandler(_arg1:KeyboardEvent):void{
            if (!activated){
                return;
            };
            if (_arg1.keyCode == Keyboard.TAB){
                lastAction = "KEY";
                if (calculateCandidates){
                    sortFocusableObjects();
                    calculateCandidates = false;
                };
            };
            if (((((((defaultButtonEnabled) && ((_arg1.keyCode == Keyboard.ENTER)))) && (defaultButton))) && (defButton.enabled))){
                sendDefaultButtonEvent();
            };
        }
        private function mouseDownHandler(_arg1:MouseEvent):void{
            if (!activated){
                return;
            };
            if (_arg1.isDefaultPrevented()){
                return;
            };
            var _local2:InteractiveObject = getTopLevelFocusTarget(InteractiveObject(_arg1.target));
            if (!_local2){
                return;
            };
            showFocusIndicator = false;
            if (((((!((_local2 == lastFocus))) || ((lastAction == "ACTIVATE")))) && (!((_local2 is TextField))))){
                setFocus(_local2);
            };
            lastAction = "MOUSEDOWN";
        }
        public function get defaultButton():Button{
            return (_defaultButton);
        }
        public function set defaultButton(_arg1:Button):void{
            var _local2:Button = ((_arg1) ? Button(_arg1) : null);
            if (_local2 != _defaultButton){
                if (_defaultButton){
                    _defaultButton.emphasized = false;
                };
                if (defButton){
                    defButton.emphasized = false;
                };
                _defaultButton = _local2;
                defButton = _local2;
                if (_local2){
                    _local2.emphasized = true;
                };
            };
        }
        public function sendDefaultButtonEvent():void{
            defButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }
        private function setFocusToNextObject(_arg1:FocusEvent):void{
            if (!hasFocusableObjects()){
                return;
            };
            var _local2:InteractiveObject = getNextFocusManagerComponent(_arg1.shiftKey);
            if (_local2){
                setFocus(_local2);
            };
        }
        private function hasFocusableObjects():Boolean{
            var _local1:Object;
            for (_local1 in focusableObjects) {
                return (true);
            };
            return (false);
        }
        public function getNextFocusManagerComponent(_arg1:Boolean=false):InteractiveObject{
            var _local8:IFocusManagerGroup;
            if (!hasFocusableObjects()){
                return (null);
            };
            if (calculateCandidates){
                sortFocusableObjects();
                calculateCandidates = false;
            };
            var _local2:DisplayObject = form.stage.focus;
            _local2 = DisplayObject(findFocusManagerComponent(InteractiveObject(_local2)));
            var _local3 = "";
            if ((_local2 is IFocusManagerGroup)){
                _local8 = IFocusManagerGroup(_local2);
                _local3 = _local8.groupName;
            };
            var _local4:int = getIndexOfFocusedObject(_local2);
            var _local5:Boolean;
            var _local6:int = _local4;
            if (_local4 == -1){
                if (_arg1){
                    _local4 = focusableCandidates.length;
                };
                _local5 = true;
            };
            var _local7:int = getIndexOfNextObject(_local4, _arg1, _local5, _local3);
            return (findFocusManagerComponent(focusableCandidates[_local7]));
        }
        private function getIndexOfFocusedObject(_arg1:DisplayObject):int{
            var _local2:int = focusableCandidates.length;
            var _local3:int;
            _local3 = 0;
            while (_local3 < _local2) {
                if (focusableCandidates[_local3] == _arg1){
                    return (_local3);
                };
                _local3++;
            };
            return (-1);
        }
        private function getIndexOfNextObject(_arg1:int, _arg2:Boolean, _arg3:Boolean, _arg4:String):int{
            var _local7:DisplayObject;
            var _local8:IFocusManagerGroup;
            var _local9:int;
            var _local10:DisplayObject;
            var _local11:IFocusManagerGroup;
            var _local5:int = focusableCandidates.length;
            var _local6:int = _arg1;
            while (true) {
                if (_arg2){
                    _arg1--;
                } else {
                    _arg1++;
                };
                if (_arg3){
                    if (((_arg2) && ((_arg1 < 0)))){
                        break;
                    };
                    if (((!(_arg2)) && ((_arg1 == _local5)))){
                        break;
                    };
                } else {
                    _arg1 = ((_arg1 + _local5) % _local5);
                    if (_local6 == _arg1){
                        break;
                    };
                };
                if (isValidFocusCandidate(focusableCandidates[_arg1], _arg4)){
                    _local7 = DisplayObject(findFocusManagerComponent(focusableCandidates[_arg1]));
                    if ((_local7 is IFocusManagerGroup)){
                        _local8 = IFocusManagerGroup(_local7);
                        _local9 = 0;
                        while (_local9 < focusableCandidates.length) {
                            _local10 = focusableCandidates[_local9];
                            if ((_local10 is IFocusManagerGroup)){
                                _local11 = IFocusManagerGroup(_local10);
                                if ((((_local11.groupName == _local8.groupName)) && (_local11.selected))){
                                    _arg1 = _local9;
                                    break;
                                };
                            };
                            _local9++;
                        };
                    };
                    return (_arg1);
                };
            };
            return (_arg1);
        }
        private function sortFocusableObjects():void{
            var _local1:Object;
            var _local2:InteractiveObject;
            focusableCandidates = [];
            for (_local1 in focusableObjects) {
                _local2 = InteractiveObject(_local1);
                if (((((_local2.tabIndex) && (!(isNaN(Number(_local2.tabIndex)))))) && ((_local2.tabIndex > 0)))){
                    sortFocusableObjectsTabIndex();
                    return;
                };
                focusableCandidates.push(_local2);
            };
            focusableCandidates.sort(sortByDepth);
        }
        private function sortFocusableObjectsTabIndex():void{
            var _local1:Object;
            var _local2:InteractiveObject;
            focusableCandidates = [];
            for (_local1 in focusableObjects) {
                _local2 = InteractiveObject(_local1);
                if (((_local2.tabIndex) && (!(isNaN(Number(_local2.tabIndex)))))){
                    focusableCandidates.push(_local2);
                };
            };
            focusableCandidates.sort(sortByTabIndex);
        }
        private function sortByDepth(_arg1:InteractiveObject, _arg2:InteractiveObject):Number{
            var _local5:int;
            var _local6:String;
            var _local7:String;
            var _local3 = "";
            var _local4 = "";
            var _local8 = "0000";
            var _local9:DisplayObject = DisplayObject(_arg1);
            var _local10:DisplayObject = DisplayObject(_arg2);
            while (((!((_local9 == DisplayObject(form)))) && (_local9.parent))) {
                _local5 = getChildIndex(_local9.parent, _local9);
                _local6 = _local5.toString(16);
                if (_local6.length < 4){
                    _local7 = (_local8.substring(0, (4 - _local6.length)) + _local6);
                };
                _local3 = (_local7 + _local3);
                _local9 = _local9.parent;
            };
            while (((!((_local10 == DisplayObject(form)))) && (_local10.parent))) {
                _local5 = getChildIndex(_local10.parent, _local10);
                _local6 = _local5.toString(16);
                if (_local6.length < 4){
                    _local7 = (_local8.substring(0, (4 - _local6.length)) + _local6);
                };
                _local4 = (_local7 + _local4);
                _local10 = _local10.parent;
            };
            return ((((_local3 > _local4)) ? 1 : (((_local3 < _local4)) ? -1 : 0)));
        }
        private function getChildIndex(_arg1:DisplayObjectContainer, _arg2:DisplayObject):int{
            return (_arg1.getChildIndex(_arg2));
        }
        private function sortByTabIndex(_arg1:InteractiveObject, _arg2:InteractiveObject):int{
            return ((((_arg1.tabIndex > _arg2.tabIndex)) ? 1 : (((_arg1.tabIndex < _arg2.tabIndex)) ? -1 : sortByDepth(_arg1, _arg2))));
        }
        public function get defaultButtonEnabled():Boolean{
            return (_defaultButtonEnabled);
        }
        public function set defaultButtonEnabled(_arg1:Boolean):void{
            _defaultButtonEnabled = _arg1;
        }
        public function get nextTabIndex():int{
            return (0);
        }
        public function get showFocusIndicator():Boolean{
            return (_showFocusIndicator);
        }
        public function set showFocusIndicator(_arg1:Boolean):void{
            _showFocusIndicator = _arg1;
        }
        public function get form():DisplayObjectContainer{
            return (_form);
        }
        public function set form(_arg1:DisplayObjectContainer):void{
            _form = _arg1;
        }
        public function getFocus():InteractiveObject{
            var _local1:InteractiveObject = form.stage.focus;
            return (findFocusManagerComponent(_local1));
        }
        public function setFocus(_arg1:InteractiveObject):void{
            if ((_arg1 is IFocusManagerComponent)){
                IFocusManagerComponent(_arg1).setFocus();
            } else {
                form.stage.focus = _arg1;
            };
        }
        public function showFocus():void{
        }
        public function hideFocus():void{
        }
        public function findFocusManagerComponent(_arg1:InteractiveObject):InteractiveObject{
            var _local2:InteractiveObject = _arg1;
            while (_arg1) {
                if ((((_arg1 is IFocusManagerComponent)) && (IFocusManagerComponent(_arg1).focusEnabled))){
                    return (_arg1);
                };
                _arg1 = _arg1.parent;
            };
            return (_local2);
        }
        private function getTopLevelFocusTarget(_arg1:InteractiveObject):InteractiveObject{
            while (_arg1 != InteractiveObject(form)) {
                if ((((((((_arg1 is IFocusManagerComponent)) && (IFocusManagerComponent(_arg1).focusEnabled))) && (IFocusManagerComponent(_arg1).mouseFocusEnabled))) && (UIComponent(_arg1).enabled))){
                    return (_arg1);
                };
                _arg1 = _arg1.parent;
                if (_arg1 == null){
                    break;
                };
            };
            return (null);
        }

    }
}//package fl.managers 
package fl.managers {
    import fl.controls.*;
    import flash.display.*;

    public interface IFocusManager {

        function get defaultButton():Button;
        function set defaultButton(_arg1:Button):void;
        function get defaultButtonEnabled():Boolean;
        function set defaultButtonEnabled(_arg1:Boolean):void;
        function get nextTabIndex():int;
        function get showFocusIndicator():Boolean;
        function set showFocusIndicator(_arg1:Boolean):void;
        function getFocus():InteractiveObject;
        function setFocus(_arg1:InteractiveObject):void;
        function showFocus():void;
        function hideFocus():void;
        function activate():void;
        function deactivate():void;
        function findFocusManagerComponent(_arg1:InteractiveObject):InteractiveObject;
        function getNextFocusManagerComponent(_arg1:Boolean=false):InteractiveObject;

    }
}//package fl.managers 
package fl.managers {

    public interface IFocusManagerGroup {

        function get groupName():String;
        function set groupName(_arg1:String):void;
        function get selected():Boolean;
        function set selected(_arg1:Boolean):void;

    }
}//package fl.managers 
package fl.managers {

    public interface IFocusManagerComponent {

        function get focusEnabled():Boolean;
        function set focusEnabled(_arg1:Boolean):void;
        function get mouseFocusEnabled():Boolean;
        function get tabEnabled():Boolean;
        function get tabIndex():int;
        function setFocus():void;
        function drawFocus(_arg1:Boolean):void;

    }
}//package fl.managers 
package fl.core {

    public class InvalidationType {

        public static const ALL:String = "all";
        public static const SIZE:String = "size";
        public static const STYLES:String = "styles";
        public static const RENDERER_STYLES:String = "rendererStyles";
        public static const STATE:String = "state";
        public static const DATA:String = "data";
        public static const SCROLL:String = "scroll";
        public static const SELECTED:String = "selected";

    }
}//package fl.core 
package fl.core {
    import flash.display.*;

    public dynamic class ComponentShim extends MovieClip {

    }
}//package fl.core 
package fl.core {
    import flash.display.*;
    import flash.utils.*;
    import flash.events.*;
    import fl.managers.*;
    import flash.text.*;
    import fl.events.*;
    import flash.system.*;

    public class UIComponent extends Sprite {

        public static var inCallLaterPhase:Boolean = false;
        private static var defaultStyles:Object = {
            focusRectSkin:"focusRectSkin",
            focusRectPadding:2,
            textFormat:new TextFormat("_sans", 11, 0, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0),
            disabledTextFormat:new TextFormat("_sans", 11, 0x999999, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0),
            defaultTextFormat:new TextFormat("_sans", 11, 0, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0),
            defaultDisabledTextFormat:new TextFormat("_sans", 11, 0x999999, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0)
        };
        private static var focusManagers:Dictionary = new Dictionary(true);
        private static var focusManagerUsers:Dictionary = new Dictionary(true);
        public static var createAccessibilityImplementation:Function;

        public const version:String = "3.0.2.3";

        public var focusTarget:IFocusManagerComponent;
        protected var isLivePreview:Boolean = false;
        private var tempText:TextField;
        protected var instanceStyles:Object;
        protected var sharedStyles:Object;
        protected var callLaterMethods:Dictionary;
        protected var invalidateFlag:Boolean = false;
        protected var _enabled:Boolean = true;
        protected var invalidHash:Object;
        protected var uiFocusRect:DisplayObject;
        protected var isFocused:Boolean = false;
        private var _focusEnabled:Boolean = true;
        private var _mouseFocusEnabled:Boolean = true;
        protected var _width:Number;
        protected var _height:Number;
        protected var _x:Number;
        protected var _y:Number;
        protected var startWidth:Number;
        protected var startHeight:Number;
        protected var _imeMode:String = null;
        protected var _oldIMEMode:String = null;
        protected var errorCaught:Boolean = false;
        protected var _inspector:Boolean = false;

        public function UIComponent(){
            instanceStyles = {};
            sharedStyles = {};
            invalidHash = {};
            callLaterMethods = new Dictionary();
            StyleManager.registerInstance(this);
            configUI();
            invalidate(InvalidationType.ALL);
            tabEnabled = (this is IFocusManagerComponent);
            focusRect = false;
            if (tabEnabled){
                addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
                addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
                addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
            };
            initializeFocusManager();
            addEventListener(Event.ENTER_FRAME, hookAccessibility, false, 0, true);
        }
        public static function getStyleDefinition():Object{
            return (defaultStyles);
        }
        public static function mergeStyles(... _args):Object{
            var _local5:Object;
            var _local6:String;
            var _local2:Object = {};
            var _local3:uint = _args.length;
            var _local4:uint;
            while (_local4 < _local3) {
                _local5 = _args[_local4];
                for (_local6 in _local5) {
                    if (_local2[_local6] != null){
                    } else {
                        _local2[_local6] = _args[_local4][_local6];
                    };
                };
                _local4++;
            };
            return (_local2);
        }

        public function get componentInspectorSetting():Boolean{
            return (_inspector);
        }
        public function set componentInspectorSetting(_arg1:Boolean):void{
            _inspector = _arg1;
            if (_inspector){
                beforeComponentParameters();
            } else {
                afterComponentParameters();
            };
        }
        protected function beforeComponentParameters():void{
        }
        protected function afterComponentParameters():void{
        }
        public function get enabled():Boolean{
            return (_enabled);
        }
        public function set enabled(_arg1:Boolean):void{
            if (_arg1 == _enabled){
                return;
            };
            _enabled = _arg1;
            invalidate(InvalidationType.STATE);
        }
        public function setSize(_arg1:Number, _arg2:Number):void{
            _width = _arg1;
            _height = _arg2;
            invalidate(InvalidationType.SIZE);
            dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE, false));
        }
        override public function get width():Number{
            return (_width);
        }
        override public function set width(_arg1:Number):void{
            if (_width == _arg1){
                return;
            };
            setSize(_arg1, height);
        }
        override public function get height():Number{
            return (_height);
        }
        override public function set height(_arg1:Number):void{
            if (_height == _arg1){
                return;
            };
            setSize(width, _arg1);
        }
        public function setStyle(_arg1:String, _arg2:Object):void{
            if ((((instanceStyles[_arg1] === _arg2)) && (!((_arg2 is TextFormat))))){
                return;
            };
            instanceStyles[_arg1] = _arg2;
            invalidate(InvalidationType.STYLES);
        }
        public function clearStyle(_arg1:String):void{
            setStyle(_arg1, null);
        }
        public function getStyle(_arg1:String):Object{
            return (instanceStyles[_arg1]);
        }
        public function move(_arg1:Number, _arg2:Number):void{
            _x = _arg1;
            _y = _arg2;
            super.x = Math.round(_arg1);
            super.y = Math.round(_arg2);
            dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
        }
        override public function get x():Number{
            return (((isNaN(_x)) ? super.x : _x));
        }
        override public function set x(_arg1:Number):void{
            move(_arg1, _y);
        }
        override public function get y():Number{
            return (((isNaN(_y)) ? super.y : _y));
        }
        override public function set y(_arg1:Number):void{
            move(_x, _arg1);
        }
        override public function get scaleX():Number{
            return ((width / startWidth));
        }
        override public function set scaleX(_arg1:Number):void{
            setSize((startWidth * _arg1), height);
        }
        override public function get scaleY():Number{
            return ((height / startHeight));
        }
        override public function set scaleY(_arg1:Number):void{
            setSize(width, (startHeight * _arg1));
        }
        protected function getScaleY():Number{
            return (super.scaleY);
        }
        protected function setScaleY(_arg1:Number):void{
            super.scaleY = _arg1;
        }
        protected function getScaleX():Number{
            return (super.scaleX);
        }
        protected function setScaleX(_arg1:Number):void{
            super.scaleX = _arg1;
        }
        override public function get visible():Boolean{
            return (super.visible);
        }
        override public function set visible(_arg1:Boolean):void{
            if (super.visible == _arg1){
                return;
            };
            super.visible = _arg1;
            var _local2:String = ((_arg1) ? ComponentEvent.SHOW : ComponentEvent.HIDE);
            dispatchEvent(new ComponentEvent(_local2, true));
        }
        public function validateNow():void{
            invalidate(InvalidationType.ALL, false);
            draw();
        }
        public function invalidate(_arg1:String="all", _arg2:Boolean=true):void{
            invalidHash[_arg1] = true;
            if (_arg2){
                this.callLater(draw);
            };
        }
        public function setSharedStyle(_arg1:String, _arg2:Object):void{
            if ((((sharedStyles[_arg1] === _arg2)) && (!((_arg2 is TextFormat))))){
                return;
            };
            sharedStyles[_arg1] = _arg2;
            if (instanceStyles[_arg1] == null){
                invalidate(InvalidationType.STYLES);
            };
        }
        public function get focusEnabled():Boolean{
            return (_focusEnabled);
        }
        public function set focusEnabled(_arg1:Boolean):void{
            _focusEnabled = _arg1;
        }
        public function get mouseFocusEnabled():Boolean{
            return (_mouseFocusEnabled);
        }
        public function set mouseFocusEnabled(_arg1:Boolean):void{
            _mouseFocusEnabled = _arg1;
        }
        public function get focusManager():IFocusManager{
            var _local1:DisplayObject = this;
            while (_local1) {
                if (UIComponent.focusManagers[_local1] != null){
                    return (IFocusManager(UIComponent.focusManagers[_local1]));
                };
                _local1 = _local1.parent;
            };
            return (null);
        }
        public function set focusManager(_arg1:IFocusManager):void{
            UIComponent.focusManagers[this] = _arg1;
        }
        public function drawFocus(_arg1:Boolean):void{
            var _local2:Number;
            isFocused = _arg1;
            if (((!((uiFocusRect == null))) && (contains(uiFocusRect)))){
                removeChild(uiFocusRect);
                uiFocusRect = null;
            };
            if (_arg1){
                uiFocusRect = (getDisplayObjectInstance(getStyleValue("focusRectSkin")) as Sprite);
                if (uiFocusRect == null){
                    return;
                };
                _local2 = Number(getStyleValue("focusRectPadding"));
                uiFocusRect.x = -(_local2);
                uiFocusRect.y = -(_local2);
                uiFocusRect.width = (width + (_local2 * 2));
                uiFocusRect.height = (height + (_local2 * 2));
                addChildAt(uiFocusRect, 0);
            };
        }
        public function setFocus():void{
            if (stage){
                stage.focus = this;
            };
        }
        public function getFocus():InteractiveObject{
            if (stage){
                return (stage.focus);
            };
            return (null);
        }
        protected function setIMEMode(_arg1:Boolean){
            var enabled:* = _arg1;
            if (_imeMode != null){
                if (enabled){
                    IME.enabled = true;
                    _oldIMEMode = IME.conversionMode;
                    try {
                        if (((!(errorCaught)) && (!((IME.conversionMode == IMEConversionMode.UNKNOWN))))){
                            IME.conversionMode = _imeMode;
                        };
                        errorCaught = false;
                    } catch(e:Error) {
                        errorCaught = true;
                        throw (new Error(("IME mode not supported: " + _imeMode)));
                    };
                } else {
                    if (((!((IME.conversionMode == IMEConversionMode.UNKNOWN))) && (!((_oldIMEMode == IMEConversionMode.UNKNOWN))))){
                        IME.conversionMode = _oldIMEMode;
                    };
                    IME.enabled = false;
                };
            };
        }
        public function drawNow():void{
            draw();
        }
        protected function configUI():void{
            isLivePreview = checkLivePreview();
            var _local1:Number = rotation;
            rotation = 0;
            var _local2:Number = super.width;
            var _local3:Number = super.height;
            var _local4 = 1;
            super.scaleY = _local4;
            super.scaleX = _local4;
            setSize(_local2, _local3);
            move(super.x, super.y);
            rotation = _local1;
            startWidth = _local2;
            startHeight = _local3;
            if (numChildren > 0){
                removeChildAt(0);
            };
        }
        protected function checkLivePreview():Boolean{
            var className:* = null;
            if (parent == null){
                return (false);
            };
            try {
                className = getQualifiedClassName(parent);
            } catch(e:Error) {
            };
            return ((className == "fl.livepreview::LivePreviewParent"));
        }
        protected function isInvalid(_arg1:String, ... _args):Boolean{
            if (((invalidHash[_arg1]) || (invalidHash[InvalidationType.ALL]))){
                return (true);
            };
            while (_args.length > 0) {
                if (invalidHash[_args.pop()]){
                    return (true);
                };
            };
            return (false);
        }
        protected function validate():void{
            invalidHash = {};
        }
        protected function draw():void{
            if (isInvalid(InvalidationType.SIZE, InvalidationType.STYLES)){
                if (((isFocused) && (focusManager.showFocusIndicator))){
                    drawFocus(true);
                };
            };
            validate();
        }
        protected function getDisplayObjectInstance(_arg1:Object):DisplayObject{
            var skin:* = _arg1;
            var classDef:* = null;
            if ((skin is Class)){
                return ((new (skin)() as DisplayObject));
            };
            if ((skin is DisplayObject)){
                (skin as DisplayObject).x = 0;
                (skin as DisplayObject).y = 0;
                return ((skin as DisplayObject));
            };
            try {
                classDef = getDefinitionByName(skin.toString());
            } catch(e:Error) {
                try {
                    classDef = (loaderInfo.applicationDomain.getDefinition(skin.toString()) as Object);
                } catch(e:Error) {
                };
            };
            if (classDef == null){
                return (null);
            };
            return ((new (classDef)() as DisplayObject));
        }
        protected function getStyleValue(_arg1:String):Object{
            return (((instanceStyles[_arg1])==null) ? sharedStyles[_arg1] : instanceStyles[_arg1]);
        }
        protected function copyStylesToChild(_arg1:UIComponent, _arg2:Object):void{
            var _local3:String;
            for (_local3 in _arg2) {
                _arg1.setStyle(_local3, getStyleValue(_arg2[_local3]));
            };
        }
        protected function callLater(_arg1:Function):void{
            if (inCallLaterPhase){
                return;
            };
            callLaterMethods[_arg1] = true;
            if (stage != null){
                stage.addEventListener(Event.RENDER, callLaterDispatcher, false, 0, true);
                stage.invalidate();
            } else {
                addEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
            };
        }
        private function callLaterDispatcher(_arg1:Event):void{
            var _local3:Object;
            if (_arg1.type == Event.ADDED_TO_STAGE){
                removeEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher);
                stage.addEventListener(Event.RENDER, callLaterDispatcher, false, 0, true);
                stage.invalidate();
                return;
            };
            _arg1.target.removeEventListener(Event.RENDER, callLaterDispatcher);
            if (stage == null){
                addEventListener(Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
                return;
            };
            inCallLaterPhase = true;
            var _local2:Dictionary = callLaterMethods;
            for (_local3 in _local2) {
                _local3();
                delete _local2[_local3];
            };
            inCallLaterPhase = false;
        }
        private function initializeFocusManager():void{
            var _local1:IFocusManager;
            var _local2:Dictionary;
            if (stage == null){
                addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
            } else {
                createFocusManager();
                _local1 = focusManager;
                if (_local1 != null){
                    _local2 = focusManagerUsers[_local1];
                    if (_local2 == null){
                        _local2 = new Dictionary(true);
                        focusManagerUsers[_local1] = _local2;
                    };
                    _local2[this] = true;
                };
            };
            addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
        }
        private function addedHandler(_arg1:Event):void{
            removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
            initializeFocusManager();
        }
        private function removedHandler(_arg1:Event):void{
            var _local3:Dictionary;
            var _local4:Boolean;
            var _local5:*;
            var _local6:*;
            var _local7:IFocusManager;
            removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
            addEventListener(Event.ADDED_TO_STAGE, addedHandler);
            var _local2:IFocusManager = focusManager;
            if (_local2 != null){
                _local3 = focusManagerUsers[_local2];
                if (_local3 != null){
                    delete _local3[this];
                    _local4 = true;
                    for (_local5 in _local3) {
                        _local4 = false;
                        break;
                    };
                    if (_local4){
                        delete focusManagerUsers[_local2];
                        _local3 = null;
                    };
                };
                if (_local3 == null){
                    _local2.deactivate();
                    for (_local6 in focusManagers) {
                        _local7 = focusManagers[_local6];
                        if (_local2 == _local7){
                            delete focusManagers[_local6];
                        };
                    };
                };
            };
        }
        protected function createFocusManager():void{
            if (focusManagers[stage] == null){
                focusManagers[stage] = new FocusManager(stage);
            };
        }
        protected function isOurFocus(_arg1:DisplayObject):Boolean{
            return ((_arg1 == this));
        }
        protected function focusInHandler(_arg1:FocusEvent):void{
            var _local2:IFocusManager;
            if (isOurFocus((_arg1.target as DisplayObject))){
                _local2 = focusManager;
                if (((_local2) && (_local2.showFocusIndicator))){
                    drawFocus(true);
                    isFocused = true;
                };
            };
        }
        protected function focusOutHandler(_arg1:FocusEvent):void{
            if (isOurFocus((_arg1.target as DisplayObject))){
                drawFocus(false);
                isFocused = false;
            };
        }
        protected function keyDownHandler(_arg1:KeyboardEvent):void{
        }
        protected function keyUpHandler(_arg1:KeyboardEvent):void{
        }
        protected function hookAccessibility(_arg1:Event):void{
            removeEventListener(Event.ENTER_FRAME, hookAccessibility);
            initializeAccessibility();
        }
        protected function initializeAccessibility():void{
            if (UIComponent.createAccessibilityImplementation != null){
                UIComponent.createAccessibilityImplementation(this);
            };
        }

    }
}//package fl.core 
package fl.events {
    import flash.events.*;

    public class ComponentEvent extends Event {

        public static const BUTTON_DOWN:String = "buttonDown";
        public static const LABEL_CHANGE:String = "labelChange";
        public static const HIDE:String = "hide";
        public static const SHOW:String = "show";
        public static const RESIZE:String = "resize";
        public static const MOVE:String = "move";
        public static const ENTER:String = "enter";

        public function ComponentEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false){
            super(_arg1, _arg2, _arg3);
        }
        override public function toString():String{
            return (formatToString("ComponentEvent", "type", "bubbles", "cancelable"));
        }
        override public function clone():Event{
            return (new ComponentEvent(type, bubbles, cancelable));
        }

    }
}//package fl.events 
package fl.events {
    import flash.events.*;

    public class ScrollEvent extends Event {

        public static const SCROLL:String = "scroll";

        private var _direction:String;
        private var _delta:Number;
        private var _position:Number;

        public function ScrollEvent(_arg1:String, _arg2:Number, _arg3:Number){
            super(ScrollEvent.SCROLL, false, false);
            _direction = _arg1;
            _delta = _arg2;
            _position = _arg3;
        }
        public function get direction():String{
            return (_direction);
        }
        public function get delta():Number{
            return (_delta);
        }
        public function get position():Number{
            return (_position);
        }
        override public function toString():String{
            return (formatToString("ScrollEvent", "type", "bubbles", "cancelable", "direction", "delta", "position"));
        }
        override public function clone():Event{
            return (new ScrollEvent(_direction, _delta, _position));
        }

    }
}//package fl.events 
package fl.controls {

    public class ScrollBarDirection {

        public static const VERTICAL:String = "vertical";
        public static const HORIZONTAL:String = "horizontal";

    }
}//package fl.controls 
package fl.controls {

    public class ScrollPolicy {

        public static const ON:String = "on";
        public static const AUTO:String = "auto";
        public static const OFF:String = "off";

    }
}//package fl.controls 
package fl.controls {
    import flash.display.*;
    import fl.core.*;
    import flash.events.*;
    import fl.managers.*;
    import flash.text.*;
    import fl.events.*;
    import flash.ui.*;

    public class LabelButton extends BaseButton implements IFocusManagerComponent {

        private static var defaultStyles:Object = {
            icon:null,
            upIcon:null,
            downIcon:null,
            overIcon:null,
            disabledIcon:null,
            selectedDisabledIcon:null,
            selectedUpIcon:null,
            selectedDownIcon:null,
            selectedOverIcon:null,
            textFormat:null,
            disabledTextFormat:null,
            textPadding:5,
            embedFonts:false
        };
        public static var createAccessibilityImplementation:Function;

        public var textField:TextField;
        protected var _labelPlacement:String = "right";
        protected var _toggle:Boolean = false;
        protected var icon:DisplayObject;
        protected var oldMouseState:String;
        protected var _label:String = "Label";
        protected var mode:String = "center";

        public static function getStyleDefinition():Object{
            return (mergeStyles(defaultStyles, BaseButton.getStyleDefinition()));
        }

        public function get label():String{
            return (_label);
        }
        public function set label(_arg1:String):void{
            _label = _arg1;
            if (textField.text != _label){
                textField.text = _label;
                dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
            };
            invalidate(InvalidationType.SIZE);
            invalidate(InvalidationType.STYLES);
        }
        public function get labelPlacement():String{
            return (_labelPlacement);
        }
        public function set labelPlacement(_arg1:String):void{
            _labelPlacement = _arg1;
            invalidate(InvalidationType.SIZE);
        }
        public function get toggle():Boolean{
            return (_toggle);
        }
        public function set toggle(_arg1:Boolean):void{
            if (((!(_arg1)) && (super.selected))){
                selected = false;
            };
            _toggle = _arg1;
            if (_toggle){
                addEventListener(MouseEvent.CLICK, toggleSelected, false, 0, true);
            } else {
                removeEventListener(MouseEvent.CLICK, toggleSelected);
            };
            invalidate(InvalidationType.STATE);
        }
        protected function toggleSelected(_arg1:MouseEvent):void{
            selected = !(selected);
            dispatchEvent(new Event(Event.CHANGE, true));
        }
        override public function get selected():Boolean{
            return (((_toggle) ? _selected : false));
        }
        override public function set selected(_arg1:Boolean):void{
            _selected = _arg1;
            if (_toggle){
                invalidate(InvalidationType.STATE);
            };
        }
        override protected function configUI():void{
            super.configUI();
            textField = new TextField();
            textField.type = TextFieldType.DYNAMIC;
            textField.selectable = false;
            addChild(textField);
        }
        override protected function draw():void{
            if (textField.text != _label){
                label = _label;
            };
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE)){
                drawBackground();
                drawIcon();
                drawTextFormat();
                invalidate(InvalidationType.SIZE, false);
            };
            if (isInvalid(InvalidationType.SIZE)){
                drawLayout();
            };
            if (isInvalid(InvalidationType.SIZE, InvalidationType.STYLES)){
                if (((isFocused) && (focusManager.showFocusIndicator))){
                    drawFocus(true);
                };
            };
            validate();
        }
        protected function drawIcon():void{
            var _local1:DisplayObject = icon;
            var _local2:String = ((enabled) ? mouseState : "disabled");
            if (selected){
                _local2 = (("selected" + _local2.substr(0, 1).toUpperCase()) + _local2.substr(1));
            };
            _local2 = (_local2 + "Icon");
            var _local3:Object = getStyleValue(_local2);
            if (_local3 == null){
                _local3 = getStyleValue("icon");
            };
            if (_local3 != null){
                icon = getDisplayObjectInstance(_local3);
            };
            if (icon != null){
                addChildAt(icon, 1);
            };
            if (((!((_local1 == null))) && (!((_local1 == icon))))){
                removeChild(_local1);
            };
        }
        protected function drawTextFormat():void{
            var _local1:Object = UIComponent.getStyleDefinition();
            var _local2:TextFormat = ((enabled) ? (_local1.defaultTextFormat as TextFormat) : (_local1.defaultDisabledTextFormat as TextFormat));
            textField.setTextFormat(_local2);
            var _local3:TextFormat = (getStyleValue(((enabled) ? "textFormat" : "disabledTextFormat")) as TextFormat);
            if (_local3 != null){
                textField.setTextFormat(_local3);
            } else {
                _local3 = _local2;
            };
            textField.defaultTextFormat = _local3;
            setEmbedFont();
        }
        protected function setEmbedFont(){
            var _local1:Object = getStyleValue("embedFonts");
            if (_local1 != null){
                textField.embedFonts = _local1;
            };
        }
        override protected function drawLayout():void{
            var _local7:Number;
            var _local8:Number;
            var _local1:Number = Number(getStyleValue("textPadding"));
            var _local2:String = (((((icon == null)) && ((mode == "center")))) ? ButtonLabelPlacement.TOP : _labelPlacement);
            textField.height = (textField.textHeight + 4);
            var _local3:Number = (textField.textWidth + 4);
            var _local4:Number = (textField.textHeight + 4);
            var _local5:Number = ((icon)==null) ? 0 : (icon.width + _local1);
            var _local6:Number = ((icon)==null) ? 0 : (icon.height + _local1);
            textField.visible = (label.length > 0);
            if (icon != null){
                icon.x = Math.round(((width - icon.width) / 2));
                icon.y = Math.round(((height - icon.height) / 2));
            };
            if (textField.visible == false){
                textField.width = 0;
                textField.height = 0;
            } else {
                if ((((_local2 == ButtonLabelPlacement.BOTTOM)) || ((_local2 == ButtonLabelPlacement.TOP)))){
                    _local7 = Math.max(0, Math.min(_local3, (width - (2 * _local1))));
                    if ((height - 2) > _local4){
                        _local8 = _local4;
                    } else {
                        _local8 = (height - 2);
                    };
                    _local3 = _local7;
                    textField.width = _local3;
                    _local4 = _local8;
                    textField.height = _local4;
                    textField.x = Math.round(((width - _local3) / 2));
                    textField.y = Math.round(((((height - textField.height) - _local6) / 2) + ((_local2)==ButtonLabelPlacement.BOTTOM) ? _local6 : 0));
                    if (icon != null){
                        icon.y = Math.round(((_local2)==ButtonLabelPlacement.BOTTOM) ? (textField.y - _local6) : ((textField.y + textField.height) + _local1));
                    };
                } else {
                    _local7 = Math.max(0, Math.min(_local3, ((width - _local5) - (2 * _local1))));
                    _local3 = _local7;
                    textField.width = _local3;
                    textField.x = Math.round(((((width - _local3) - _local5) / 2) + ((_local2)!=ButtonLabelPlacement.LEFT) ? _local5 : 0));
                    textField.y = Math.round(((height - textField.height) / 2));
                    if (icon != null){
                        icon.x = Math.round(((_local2)!=ButtonLabelPlacement.LEFT) ? (textField.x - _local5) : ((textField.x + _local3) + _local1));
                    };
                };
            };
            super.drawLayout();
        }
        override protected function keyDownHandler(_arg1:KeyboardEvent):void{
            if (!enabled){
                return;
            };
            if (_arg1.keyCode == Keyboard.SPACE){
                if (oldMouseState == null){
                    oldMouseState = mouseState;
                };
                setMouseState("down");
                startPress();
            };
        }
        override protected function keyUpHandler(_arg1:KeyboardEvent):void{
            if (!enabled){
                return;
            };
            if (_arg1.keyCode == Keyboard.SPACE){
                setMouseState(oldMouseState);
                oldMouseState = null;
                endPress();
                dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
        }
        override protected function initializeAccessibility():void{
            if (LabelButton.createAccessibilityImplementation != null){
                LabelButton.createAccessibilityImplementation(this);
            };
        }

    }
}//package fl.controls 
package fl.controls {
    import flash.display.*;
    import flash.utils.*;
    import fl.core.*;
    import flash.events.*;
    import fl.events.*;

    public class BaseButton extends UIComponent {

        private static var defaultStyles:Object = {
            upSkin:"Button_upSkin",
            downSkin:"Button_downSkin",
            overSkin:"Button_overSkin",
            disabledSkin:"Button_disabledSkin",
            selectedDisabledSkin:"Button_selectedDisabledSkin",
            selectedUpSkin:"Button_selectedUpSkin",
            selectedDownSkin:"Button_selectedDownSkin",
            selectedOverSkin:"Button_selectedOverSkin",
            focusRectSkin:null,
            focusRectPadding:null,
            repeatDelay:500,
            repeatInterval:35
        };

        protected var background:DisplayObject;
        protected var mouseState:String;
        protected var _selected:Boolean = false;
        protected var _autoRepeat:Boolean = false;
        protected var pressTimer:Timer;
        private var _mouseStateLocked:Boolean = false;
        private var unlockedMouseState:String;

        public function BaseButton(){
            buttonMode = true;
            mouseChildren = false;
            useHandCursor = false;
            setupMouseEvents();
            setMouseState("up");
            pressTimer = new Timer(1, 0);
            pressTimer.addEventListener(TimerEvent.TIMER, buttonDown, false, 0, true);
        }
        public static function getStyleDefinition():Object{
            return (defaultStyles);
        }

        override public function get enabled():Boolean{
            return (super.enabled);
        }
        override public function set enabled(_arg1:Boolean):void{
            super.enabled = _arg1;
            mouseEnabled = _arg1;
        }
        public function get selected():Boolean{
            return (_selected);
        }
        public function set selected(_arg1:Boolean):void{
            if (_selected == _arg1){
                return;
            };
            _selected = _arg1;
            invalidate(InvalidationType.STATE);
        }
        public function get autoRepeat():Boolean{
            return (_autoRepeat);
        }
        public function set autoRepeat(_arg1:Boolean):void{
            _autoRepeat = _arg1;
        }
        public function set mouseStateLocked(_arg1:Boolean):void{
            _mouseStateLocked = _arg1;
            if (_arg1 == false){
                setMouseState(unlockedMouseState);
            } else {
                unlockedMouseState = mouseState;
            };
        }
        public function setMouseState(_arg1:String):void{
            if (_mouseStateLocked){
                unlockedMouseState = _arg1;
                return;
            };
            if (mouseState == _arg1){
                return;
            };
            mouseState = _arg1;
            invalidate(InvalidationType.STATE);
        }
        protected function setupMouseEvents():void{
            addEventListener(MouseEvent.ROLL_OVER, mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_UP, mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, mouseEventHandler, false, 0, true);
        }
        protected function mouseEventHandler(_arg1:MouseEvent):void{
            if (_arg1.type == MouseEvent.MOUSE_DOWN){
                setMouseState("down");
                startPress();
            } else {
                if ((((_arg1.type == MouseEvent.ROLL_OVER)) || ((_arg1.type == MouseEvent.MOUSE_UP)))){
                    setMouseState("over");
                    endPress();
                } else {
                    if (_arg1.type == MouseEvent.ROLL_OUT){
                        setMouseState("up");
                        endPress();
                    };
                };
            };
        }
        protected function startPress():void{
            if (_autoRepeat){
                pressTimer.delay = Number(getStyleValue("repeatDelay"));
                pressTimer.start();
            };
            dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
        }
        protected function buttonDown(_arg1:TimerEvent):void{
            if (!_autoRepeat){
                endPress();
                return;
            };
            if (pressTimer.currentCount == 1){
                pressTimer.delay = Number(getStyleValue("repeatInterval"));
            };
            dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
        }
        protected function endPress():void{
            pressTimer.reset();
        }
        override protected function draw():void{
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE)){
                drawBackground();
                invalidate(InvalidationType.SIZE, false);
            };
            if (isInvalid(InvalidationType.SIZE)){
                drawLayout();
            };
            super.draw();
        }
        protected function drawBackground():void{
            var _local1:String = ((enabled) ? mouseState : "disabled");
            if (selected){
                _local1 = (("selected" + _local1.substr(0, 1).toUpperCase()) + _local1.substr(1));
            };
            _local1 = (_local1 + "Skin");
            var _local2:DisplayObject = background;
            background = getDisplayObjectInstance(getStyleValue(_local1));
            addChildAt(background, 0);
            if (((!((_local2 == null))) && (!((_local2 == background))))){
                removeChild(_local2);
            };
        }
        protected function drawLayout():void{
            background.width = width;
            background.height = height;
        }

    }
}//package fl.controls 
package fl.controls {

    public class ButtonLabelPlacement {

        public static const BOTTOM:String = "bottom";
        public static const TOP:String = "top";
        public static const LEFT:String = "left";
        public static const RIGHT:String = "right";

    }
}//package fl.controls 
package fl.controls {
    import fl.core.*;
    import flash.events.*;
    import fl.events.*;

    public class ScrollBar extends UIComponent {

        public static const WIDTH:Number = 15;
        protected static const DOWN_ARROW_STYLES:Object = {
            disabledSkin:"downArrowDisabledSkin",
            downSkin:"downArrowDownSkin",
            overSkin:"downArrowOverSkin",
            upSkin:"downArrowUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };
        protected static const THUMB_STYLES:Object = {
            disabledSkin:"thumbDisabledSkin",
            downSkin:"thumbDownSkin",
            overSkin:"thumbOverSkin",
            upSkin:"thumbUpSkin",
            icon:"thumbIcon",
            textPadding:0
        };
        protected static const TRACK_STYLES:Object = {
            disabledSkin:"trackDisabledSkin",
            downSkin:"trackDownSkin",
            overSkin:"trackOverSkin",
            upSkin:"trackUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };
        protected static const UP_ARROW_STYLES:Object = {
            disabledSkin:"upArrowDisabledSkin",
            downSkin:"upArrowDownSkin",
            overSkin:"upArrowOverSkin",
            upSkin:"upArrowUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };

        private static var defaultStyles:Object = {
            downArrowDisabledSkin:"ScrollArrowDown_disabledSkin",
            downArrowDownSkin:"ScrollArrowDown_downSkin",
            downArrowOverSkin:"ScrollArrowDown_overSkin",
            downArrowUpSkin:"ScrollArrowDown_upSkin",
            thumbDisabledSkin:"ScrollThumb_upSkin",
            thumbDownSkin:"ScrollThumb_downSkin",
            thumbOverSkin:"ScrollThumb_overSkin",
            thumbUpSkin:"ScrollThumb_upSkin",
            trackDisabledSkin:"ScrollTrack_skin",
            trackDownSkin:"ScrollTrack_skin",
            trackOverSkin:"ScrollTrack_skin",
            trackUpSkin:"ScrollTrack_skin",
            upArrowDisabledSkin:"ScrollArrowUp_disabledSkin",
            upArrowDownSkin:"ScrollArrowUp_downSkin",
            upArrowOverSkin:"ScrollArrowUp_overSkin",
            upArrowUpSkin:"ScrollArrowUp_upSkin",
            thumbIcon:"ScrollBar_thumbIcon",
            repeatDelay:500,
            repeatInterval:35
        };

        private var _pageSize:Number = 10;
        private var _pageScrollSize:Number = 0;
        private var _lineScrollSize:Number = 1;
        private var _minScrollPosition:Number = 0;
        private var _maxScrollPosition:Number = 0;
        private var _scrollPosition:Number = 0;
        private var _direction:String = "vertical";
        private var thumbScrollOffset:Number;
        protected var inDrag:Boolean = false;
        protected var upArrow:BaseButton;
        protected var downArrow:BaseButton;
        protected var thumb:LabelButton;
        protected var track:BaseButton;

        public function ScrollBar(){
            setStyles();
            focusEnabled = false;
        }
        public static function getStyleDefinition():Object{
            return (defaultStyles);
        }

        override public function setSize(_arg1:Number, _arg2:Number):void{
            if (_direction == ScrollBarDirection.HORIZONTAL){
                super.setSize(_arg2, _arg1);
            } else {
                super.setSize(_arg1, _arg2);
            };
        }
        override public function get width():Number{
            return (((_direction)==ScrollBarDirection.HORIZONTAL) ? super.height : super.width);
        }
        override public function get height():Number{
            return (((_direction)==ScrollBarDirection.HORIZONTAL) ? super.width : super.height);
        }
        override public function get enabled():Boolean{
            return (super.enabled);
        }
        override public function set enabled(_arg1:Boolean):void{
            super.enabled = _arg1;
            downArrow.enabled = (track.enabled = (thumb.enabled = (upArrow.enabled = ((enabled) && ((_maxScrollPosition > _minScrollPosition))))));
            updateThumb();
        }
        public function setScrollProperties(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number=0):void{
            this.pageSize = _arg1;
            _minScrollPosition = _arg2;
            _maxScrollPosition = _arg3;
            if (_arg4 >= 0){
                _pageScrollSize = _arg4;
            };
            enabled = (_maxScrollPosition > _minScrollPosition);
            setScrollPosition(_scrollPosition, false);
            updateThumb();
        }
        public function get scrollPosition():Number{
            return (_scrollPosition);
        }
        public function set scrollPosition(_arg1:Number):void{
            setScrollPosition(_arg1, true);
        }
        public function get minScrollPosition():Number{
            return (_minScrollPosition);
        }
        public function set minScrollPosition(_arg1:Number):void{
            setScrollProperties(_pageSize, _arg1, _maxScrollPosition);
        }
        public function get maxScrollPosition():Number{
            return (_maxScrollPosition);
        }
        public function set maxScrollPosition(_arg1:Number):void{
            setScrollProperties(_pageSize, _minScrollPosition, _arg1);
        }
        public function get pageSize():Number{
            return (_pageSize);
        }
        public function set pageSize(_arg1:Number):void{
            if (_arg1 > 0){
                _pageSize = _arg1;
            };
        }
        public function get pageScrollSize():Number{
            return (((_pageScrollSize)==0) ? _pageSize : _pageScrollSize);
        }
        public function set pageScrollSize(_arg1:Number):void{
            if (_arg1 >= 0){
                _pageScrollSize = _arg1;
            };
        }
        public function get lineScrollSize():Number{
            return (_lineScrollSize);
        }
        public function set lineScrollSize(_arg1:Number):void{
            if (_arg1 > 0){
                _lineScrollSize = _arg1;
            };
        }
        public function get direction():String{
            return (_direction);
        }
        public function set direction(_arg1:String):void{
            if (_direction == _arg1){
                return;
            };
            _direction = _arg1;
            if (isLivePreview){
                return;
            };
            setScaleY(1);
            var _local2 = (_direction == ScrollBarDirection.HORIZONTAL);
            if (((_local2) && (componentInspectorSetting))){
                if (rotation == 90){
                    return;
                };
                setScaleX(-1);
                rotation = -90;
            };
            if (!componentInspectorSetting){
                if (((_local2) && ((rotation == 0)))){
                    rotation = -90;
                    setScaleX(-1);
                } else {
                    if (((!(_local2)) && ((rotation == -90)))){
                        rotation = 0;
                        setScaleX(1);
                    };
                };
            };
            invalidate(InvalidationType.SIZE);
        }
        override protected function configUI():void{
            super.configUI();
            track = new BaseButton();
            track.move(0, 14);
            track.useHandCursor = false;
            track.autoRepeat = true;
            track.focusEnabled = false;
            addChild(track);
            thumb = new LabelButton();
            thumb.label = "";
            thumb.setSize(WIDTH, 15);
            thumb.move(0, 15);
            thumb.focusEnabled = false;
            addChild(thumb);
            downArrow = new BaseButton();
            downArrow.setSize(WIDTH, 14);
            downArrow.autoRepeat = true;
            downArrow.focusEnabled = false;
            addChild(downArrow);
            upArrow = new BaseButton();
            upArrow.setSize(WIDTH, 14);
            upArrow.move(0, 0);
            upArrow.autoRepeat = true;
            upArrow.focusEnabled = false;
            addChild(upArrow);
            upArrow.addEventListener(ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
            downArrow.addEventListener(ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
            track.addEventListener(ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
            thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbPressHandler, false, 0, true);
            enabled = false;
        }
        override protected function draw():void{
            var _local1:Number;
            if (isInvalid(InvalidationType.SIZE)){
                _local1 = super.height;
                downArrow.move(0, Math.max(upArrow.height, (_local1 - downArrow.height)));
                track.setSize(WIDTH, Math.max(0, (_local1 - (downArrow.height + upArrow.height))));
                updateThumb();
            };
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE)){
                setStyles();
            };
            downArrow.drawNow();
            upArrow.drawNow();
            track.drawNow();
            thumb.drawNow();
            validate();
        }
        protected function scrollPressHandler(_arg1:ComponentEvent):void{
            var _local2:Number;
            var _local3:Number;
            _arg1.stopImmediatePropagation();
            if (_arg1.currentTarget == upArrow){
                setScrollPosition((_scrollPosition - _lineScrollSize));
            } else {
                if (_arg1.currentTarget == downArrow){
                    setScrollPosition((_scrollPosition + _lineScrollSize));
                } else {
                    _local2 = (((track.mouseY / track.height) * (_maxScrollPosition - _minScrollPosition)) + _minScrollPosition);
                    _local3 = ((pageScrollSize)==0) ? pageSize : pageScrollSize;
                    if (_scrollPosition < _local2){
                        setScrollPosition(Math.min(_local2, (_scrollPosition + _local3)));
                    } else {
                        if (_scrollPosition > _local2){
                            setScrollPosition(Math.max(_local2, (_scrollPosition - _local3)));
                        };
                    };
                };
            };
        }
        protected function thumbPressHandler(_arg1:MouseEvent):void{
            inDrag = true;
            thumbScrollOffset = (mouseY - thumb.y);
            thumb.mouseStateLocked = true;
            mouseChildren = false;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, handleThumbDrag, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler, false, 0, true);
        }
        protected function handleThumbDrag(_arg1:MouseEvent):void{
            var _local2:Number = Math.max(0, Math.min((track.height - thumb.height), ((mouseY - track.y) - thumbScrollOffset)));
            setScrollPosition((((_local2 / (track.height - thumb.height)) * (_maxScrollPosition - _minScrollPosition)) + _minScrollPosition));
        }
        protected function thumbReleaseHandler(_arg1:MouseEvent):void{
            inDrag = false;
            mouseChildren = true;
            thumb.mouseStateLocked = false;
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleThumbDrag);
            stage.removeEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler);
        }
        public function setScrollPosition(_arg1:Number, _arg2:Boolean=true):void{
            var _local3:Number = scrollPosition;
            _scrollPosition = Math.max(_minScrollPosition, Math.min(_maxScrollPosition, _arg1));
            if (_local3 == _scrollPosition){
                return;
            };
            if (_arg2){
                dispatchEvent(new ScrollEvent(_direction, (scrollPosition - _local3), scrollPosition));
            };
            updateThumb();
        }
        protected function setStyles():void{
            copyStylesToChild(downArrow, DOWN_ARROW_STYLES);
            copyStylesToChild(thumb, THUMB_STYLES);
            copyStylesToChild(track, TRACK_STYLES);
            copyStylesToChild(upArrow, UP_ARROW_STYLES);
        }
        protected function updateThumb():void{
            var _local1:Number = ((_maxScrollPosition - _minScrollPosition) + _pageSize);
            if ((((((track.height <= 12)) || ((_maxScrollPosition <= _minScrollPosition)))) || ((((_local1 == 0)) || (isNaN(_local1)))))){
                thumb.height = 12;
                thumb.visible = false;
            } else {
                thumb.height = Math.max(13, ((_pageSize / _local1) * track.height));
                thumb.y = (track.y + ((track.height - thumb.height) * ((_scrollPosition - _minScrollPosition) / (_maxScrollPosition - _minScrollPosition))));
                thumb.visible = enabled;
            };
        }

    }
}//package fl.controls 
package fl.controls {
    import flash.display.*;
    import fl.core.*;
    import flash.events.*;
    import fl.events.*;

    public class UIScrollBar extends ScrollBar {

        private static var defaultStyles:Object = {};

        protected var _scrollTarget:DisplayObject;
        protected var inEdit:Boolean = false;
        protected var inScroll:Boolean = false;
        protected var _targetScrollProperty:String;
        protected var _targetMaxScrollProperty:String;

        public static function getStyleDefinition():Object{
            return (UIComponent.mergeStyles(defaultStyles, ScrollBar.getStyleDefinition()));
        }

        override public function set minScrollPosition(_arg1:Number):void{
            super.minScrollPosition = ((_arg1)<0) ? 0 : _arg1;
        }
        override public function set maxScrollPosition(_arg1:Number):void{
            var _local2:Number = _arg1;
            if (_scrollTarget != null){
                _local2 = Math.min(_local2, _scrollTarget[_targetMaxScrollProperty]);
            };
            super.maxScrollPosition = _local2;
        }
        public function get scrollTarget():DisplayObject{
            return (_scrollTarget);
        }
        public function set scrollTarget(_arg1:DisplayObject):void{
            var target:* = _arg1;
            if (_scrollTarget != null){
                _scrollTarget.removeEventListener(Event.CHANGE, handleTargetChange, false);
                _scrollTarget.removeEventListener(TextEvent.TEXT_INPUT, handleTargetChange, false);
                _scrollTarget.removeEventListener(Event.SCROLL, handleTargetScroll, false);
            };
            _scrollTarget = target;
            var blockProg:* = null;
            var textDir:* = null;
            if (_scrollTarget != null){
                try {
                    if (_scrollTarget.hasOwnProperty("blockProgression")){
                        blockProg = _scrollTarget["blockProgression"];
                    };
                    if (_scrollTarget.hasOwnProperty("direction")){
                        textDir = _scrollTarget["direction"];
                    };
                } catch(e:Error) {
                    blockProg = null;
                    textDir = null;
                };
            };
            var scrollHoriz:* = (this.direction == ScrollBarDirection.HORIZONTAL);
            var rot:* = Math.abs(this.rotation);
            if (((scrollHoriz) && ((((blockProg == "rl")) || ((textDir == "rtl")))))){
                if ((((getScaleY() > 0)) && ((rotation == 90)))){
                    x = (x + width);
                };
                setScaleY(-1);
            } else {
                if (((((!(scrollHoriz)) && ((blockProg == "rl")))) && ((textDir == "rtl")))){
                    if ((((getScaleY() > 0)) && (!((rotation == 90))))){
                        y = (y + height);
                    };
                    setScaleY(-1);
                } else {
                    if (getScaleY() < 0){
                        if (scrollHoriz){
                            if (rotation == 90){
                                x = (x - width);
                            };
                        } else {
                            if (rotation != 90){
                                y = (y - height);
                            };
                        };
                    };
                    setScaleY(1);
                };
            };
            setTargetScrollProperties(scrollHoriz, blockProg);
            if (_scrollTarget != null){
                _scrollTarget.addEventListener(Event.CHANGE, handleTargetChange, false, 0, true);
                _scrollTarget.addEventListener(TextEvent.TEXT_INPUT, handleTargetChange, false, 0, true);
                _scrollTarget.addEventListener(Event.SCROLL, handleTargetScroll, false, 0, true);
            };
            invalidate(InvalidationType.DATA);
        }
        public function get scrollTargetName():String{
            return (_scrollTarget.name);
        }
        public function set scrollTargetName(_arg1:String):void{
            var target:* = _arg1;
            try {
                scrollTarget = parent.getChildByName(target);
            } catch(error:Error) {
                throw (new Error("ScrollTarget not found, or is not a valid target"));
            };
        }
        override public function get direction():String{
            return (super.direction);
        }
        override public function set direction(_arg1:String):void{
            var _local2:DisplayObject;
            if (isLivePreview){
                return;
            };
            if (((!(componentInspectorSetting)) && (!((_scrollTarget == null))))){
                _local2 = _scrollTarget;
                scrollTarget = null;
            };
            super.direction = _arg1;
            if (_local2 != null){
                scrollTarget = _local2;
            } else {
                updateScrollTargetProperties();
            };
        }
        public function update():void{
            inEdit = true;
            updateScrollTargetProperties();
            inEdit = false;
        }
        override protected function draw():void{
            if (isInvalid(InvalidationType.DATA)){
                updateScrollTargetProperties();
            };
            super.draw();
        }
        protected function updateScrollTargetProperties():void{
            var blockProg:* = null;
            var pageSize:* = NaN;
            var minScroll:* = NaN;
            var minScrollVValue:* = undefined;
            if (_scrollTarget == null){
                setScrollProperties(pageSize, minScrollPosition, maxScrollPosition);
                scrollPosition = 0;
            } else {
                blockProg = null;
                try {
                    if (_scrollTarget.hasOwnProperty("blockProgression")){
                        blockProg = _scrollTarget["blockProgression"];
                    };
                } catch(e1:Error) {
                };
                setTargetScrollProperties((this.direction == ScrollBarDirection.HORIZONTAL), blockProg);
                if (_targetScrollProperty == "scrollH"){
                    minScroll = 0;
                    try {
                        if (((_scrollTarget.hasOwnProperty("controller")) && (_scrollTarget["controller"].hasOwnProperty("compositionWidth")))){
                            pageSize = _scrollTarget["controller"]["compositionWidth"];
                        } else {
                            pageSize = _scrollTarget.width;
                        };
                    } catch(e2:Error) {
                        pageSize = _scrollTarget.width;
                    };
                } else {
                    try {
                        if (blockProg != null){
                            minScrollVValue = _scrollTarget["minScrollV"];
                            if ((minScrollVValue is int)){
                                minScroll = minScrollVValue;
                            } else {
                                minScroll = 1;
                            };
                        } else {
                            minScroll = 1;
                        };
                    } catch(e3:Error) {
                        minScroll = 1;
                    };
                    pageSize = 10;
                };
                setScrollProperties(pageSize, minScroll, scrollTarget[_targetMaxScrollProperty]);
                scrollPosition = _scrollTarget[_targetScrollProperty];
            };
        }
        override public function setScrollProperties(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number=0):void{
            var _local5:Number = _arg3;
            var _local6:Number = ((_arg2)<0) ? 0 : _arg2;
            if (_scrollTarget != null){
                _local5 = Math.min(_arg3, _scrollTarget[_targetMaxScrollProperty]);
            };
            super.setScrollProperties(_arg1, _local6, _local5, _arg4);
        }
        override public function setScrollPosition(_arg1:Number, _arg2:Boolean=true):void{
            super.setScrollPosition(_arg1, _arg2);
            if (!_scrollTarget){
                inScroll = false;
                return;
            };
            updateTargetScroll();
        }
        protected function updateTargetScroll(_arg1:ScrollEvent=null):void{
            if (inEdit){
                return;
            };
            _scrollTarget[_targetScrollProperty] = scrollPosition;
        }
        protected function handleTargetChange(_arg1:Event):void{
            inEdit = true;
            setScrollPosition(_scrollTarget[_targetScrollProperty], true);
            updateScrollTargetProperties();
            inEdit = false;
        }
        protected function handleTargetScroll(_arg1:Event):void{
            if (inDrag){
                return;
            };
            if (!enabled){
                return;
            };
            inEdit = true;
            updateScrollTargetProperties();
            scrollPosition = _scrollTarget[_targetScrollProperty];
            inEdit = false;
        }
        private function setTargetScrollProperties(_arg1:Boolean, _arg2:String):void{
            if (_arg2 == "rl"){
                if (_arg1){
                    _targetScrollProperty = "scrollV";
                    _targetMaxScrollProperty = "maxScrollV";
                } else {
                    _targetScrollProperty = "scrollH";
                    _targetMaxScrollProperty = "maxScrollH";
                };
            } else {
                if (_arg1){
                    _targetScrollProperty = "scrollH";
                    _targetMaxScrollProperty = "maxScrollH";
                } else {
                    _targetScrollProperty = "scrollV";
                    _targetMaxScrollProperty = "maxScrollV";
                };
            };
        }

    }
}//package fl.controls 
package fl.controls {
    import flash.display.*;
    import fl.core.*;
    import fl.managers.*;

    public class Button extends LabelButton implements IFocusManagerComponent {

        private static var defaultStyles:Object = {
            emphasizedSkin:"Button_emphasizedSkin",
            emphasizedPadding:2
        };
        public static var createAccessibilityImplementation:Function;

        protected var _emphasized:Boolean = false;
        protected var emphasizedBorder:DisplayObject;

        public static function getStyleDefinition():Object{
            return (UIComponent.mergeStyles(LabelButton.getStyleDefinition(), defaultStyles));
        }

        public function get emphasized():Boolean{
            return (_emphasized);
        }
        public function set emphasized(_arg1:Boolean):void{
            _emphasized = _arg1;
            invalidate(InvalidationType.STYLES);
        }
        override protected function draw():void{
            if (((isInvalid(InvalidationType.STYLES)) || (isInvalid(InvalidationType.SIZE)))){
                drawEmphasized();
            };
            super.draw();
            if (emphasizedBorder != null){
                setChildIndex(emphasizedBorder, (numChildren - 1));
            };
        }
        protected function drawEmphasized():void{
            var _local2:Number;
            if (emphasizedBorder != null){
                removeChild(emphasizedBorder);
            };
            emphasizedBorder = null;
            if (!_emphasized){
                return;
            };
            var _local1:Object = getStyleValue("emphasizedSkin");
            if (_local1 != null){
                emphasizedBorder = getDisplayObjectInstance(_local1);
            };
            if (emphasizedBorder != null){
                addChildAt(emphasizedBorder, 0);
                _local2 = Number(getStyleValue("emphasizedPadding"));
                emphasizedBorder.x = (emphasizedBorder.y = -(_local2));
                emphasizedBorder.width = (width + (_local2 * 2));
                emphasizedBorder.height = (height + (_local2 * 2));
            };
        }
        override public function drawFocus(_arg1:Boolean):void{
            var _local2:Number;
            var _local3:*;
            super.drawFocus(_arg1);
            if (_arg1){
                _local2 = Number(getStyleValue("emphasizedPadding"));
                if ((((_local2 < 0)) || (!(_emphasized)))){
                    _local2 = 0;
                };
                _local3 = getStyleValue("focusRectPadding");
                _local3 = ((_local3)==null) ? 2 : _local3;
                _local3 = (_local3 + _local2);
                uiFocusRect.x = -(_local3);
                uiFocusRect.y = -(_local3);
                uiFocusRect.width = (width + (_local3 * 2));
                uiFocusRect.height = (height + (_local3 * 2));
            };
        }
        override protected function initializeAccessibility():void{
            if (Button.createAccessibilityImplementation != null){
                Button.createAccessibilityImplementation(this);
            };
        }

    }
}//package fl.controls 
package fl.controls {
    import flash.display.*;
    import fl.core.*;
    import flash.events.*;
    import fl.managers.*;
    import flash.text.*;
    import fl.events.*;
    import flash.ui.*;
    import flash.system.*;

    public class TextArea extends UIComponent implements IFocusManagerComponent {

        protected static const SCROLL_BAR_STYLES:Object = {
            downArrowDisabledSkin:"downArrowDisabledSkin",
            downArrowDownSkin:"downArrowDownSkin",
            downArrowOverSkin:"downArrowOverSkin",
            downArrowUpSkin:"downArrowUpSkin",
            upArrowDisabledSkin:"upArrowDisabledSkin",
            upArrowDownSkin:"upArrowDownSkin",
            upArrowOverSkin:"upArrowOverSkin",
            upArrowUpSkin:"upArrowUpSkin",
            thumbDisabledSkin:"thumbDisabledSkin",
            thumbDownSkin:"thumbDownSkin",
            thumbOverSkin:"thumbOverSkin",
            thumbUpSkin:"thumbUpSkin",
            thumbIcon:"thumbIcon",
            trackDisabledSkin:"trackDisabledSkin",
            trackDownSkin:"trackDownSkin",
            trackOverSkin:"trackOverSkin",
            trackUpSkin:"trackUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };

        private static var defaultStyles:Object = {
            upSkin:"TextArea_upSkin",
            disabledSkin:"TextArea_disabledSkin",
            focusRectSkin:null,
            focusRectPadding:null,
            textFormat:null,
            disabledTextFormat:null,
            textPadding:3,
            embedFonts:false
        };
        public static var createAccessibilityImplementation:Function;

        public var textField:TextField;
        protected var _editable:Boolean = true;
        protected var _wordWrap:Boolean = true;
        protected var _horizontalScrollPolicy:String = "auto";
        protected var _verticalScrollPolicy:String = "auto";
        protected var _horizontalScrollBar:UIScrollBar;
        protected var _verticalScrollBar:UIScrollBar;
        protected var background:DisplayObject;
        protected var _html:Boolean = false;
        protected var _savedHTML:String;
        protected var textHasChanged:Boolean = false;

        public static function getStyleDefinition():Object{
            return (UIComponent.mergeStyles(defaultStyles, ScrollBar.getStyleDefinition()));
        }

        public function get horizontalScrollBar():UIScrollBar{
            return (_horizontalScrollBar);
        }
        public function get verticalScrollBar():UIScrollBar{
            return (_verticalScrollBar);
        }
        override public function get enabled():Boolean{
            return (super.enabled);
        }
        override public function set enabled(_arg1:Boolean):void{
            super.enabled = _arg1;
            mouseChildren = enabled;
            invalidate(InvalidationType.STATE);
        }
        public function get text():String{
            return (textField.text);
        }
        public function set text(_arg1:String):void{
            if (((componentInspectorSetting) && ((_arg1 == "")))){
                return;
            };
            textField.text = _arg1;
            _html = false;
            invalidate(InvalidationType.DATA);
            invalidate(InvalidationType.STYLES);
            textHasChanged = true;
        }
        public function get htmlText():String{
            return (textField.htmlText);
        }
        public function set htmlText(_arg1:String):void{
            if (((componentInspectorSetting) && ((_arg1 == "")))){
                return;
            };
            if (_arg1 == ""){
                text = "";
                return;
            };
            _html = true;
            _savedHTML = _arg1;
            textField.htmlText = _arg1;
            invalidate(InvalidationType.DATA);
            invalidate(InvalidationType.STYLES);
            textHasChanged = true;
        }
        public function get condenseWhite():Boolean{
            return (textField.condenseWhite);
        }
        public function set condenseWhite(_arg1:Boolean):void{
            textField.condenseWhite = _arg1;
            invalidate(InvalidationType.DATA);
        }
        public function get horizontalScrollPolicy():String{
            return (_horizontalScrollPolicy);
        }
        public function set horizontalScrollPolicy(_arg1:String):void{
            _horizontalScrollPolicy = _arg1;
            invalidate(InvalidationType.SIZE);
        }
        public function get verticalScrollPolicy():String{
            return (_verticalScrollPolicy);
        }
        public function set verticalScrollPolicy(_arg1:String):void{
            _verticalScrollPolicy = _arg1;
            invalidate(InvalidationType.SIZE);
        }
        public function get horizontalScrollPosition():Number{
            return (textField.scrollH);
        }
        public function set horizontalScrollPosition(_arg1:Number):void{
            drawNow();
            textField.scrollH = _arg1;
        }
        public function get verticalScrollPosition():Number{
            return (textField.scrollV);
        }
        public function set verticalScrollPosition(_arg1:Number):void{
            drawNow();
            textField.scrollV = _arg1;
        }
        public function get textWidth():Number{
            drawNow();
            return (textField.textWidth);
        }
        public function get textHeight():Number{
            drawNow();
            return (textField.textHeight);
        }
        public function get length():Number{
            return (textField.text.length);
        }
        public function get restrict():String{
            return (textField.restrict);
        }
        public function set restrict(_arg1:String):void{
            if (((componentInspectorSetting) && ((_arg1 == "")))){
                _arg1 = null;
            };
            textField.restrict = _arg1;
        }
        public function get maxChars():int{
            return (textField.maxChars);
        }
        public function set maxChars(_arg1:int):void{
            textField.maxChars = _arg1;
        }
        public function get maxHorizontalScrollPosition():int{
            return (textField.maxScrollH);
        }
        public function get maxVerticalScrollPosition():int{
            return (textField.maxScrollV);
        }
        public function get wordWrap():Boolean{
            return (_wordWrap);
        }
        public function set wordWrap(_arg1:Boolean):void{
            _wordWrap = _arg1;
            invalidate(InvalidationType.STATE);
        }
        public function get selectionBeginIndex():int{
            return (textField.selectionBeginIndex);
        }
        public function get selectionEndIndex():int{
            return (textField.selectionEndIndex);
        }
        public function get displayAsPassword():Boolean{
            return (textField.displayAsPassword);
        }
        public function set displayAsPassword(_arg1:Boolean):void{
            textField.displayAsPassword = _arg1;
        }
        public function get editable():Boolean{
            return (_editable);
        }
        public function set editable(_arg1:Boolean):void{
            _editable = _arg1;
            invalidate(InvalidationType.STATE);
        }
        public function get imeMode():String{
            return (IME.conversionMode);
        }
        public function set imeMode(_arg1:String):void{
            _imeMode = _arg1;
        }
        public function get alwaysShowSelection():Boolean{
            return (textField.alwaysShowSelection);
        }
        public function set alwaysShowSelection(_arg1:Boolean):void{
            textField.alwaysShowSelection = _arg1;
        }
        override public function drawFocus(_arg1:Boolean):void{
            if (focusTarget != null){
                focusTarget.drawFocus(_arg1);
                return;
            };
            super.drawFocus(_arg1);
        }
        public function getLineMetrics(_arg1:int):TextLineMetrics{
            return (textField.getLineMetrics(_arg1));
        }
        public function setSelection(_arg1:int, _arg2:int):void{
            textField.setSelection(_arg1, _arg2);
        }
        public function appendText(_arg1:String):void{
            textField.appendText(_arg1);
            invalidate(InvalidationType.DATA);
        }
        override protected function configUI():void{
            super.configUI();
            tabChildren = true;
            textField = new TextField();
            addChild(textField);
            updateTextFieldType();
            _verticalScrollBar = new UIScrollBar();
            _verticalScrollBar.name = "V";
            _verticalScrollBar.visible = false;
            _verticalScrollBar.focusEnabled = false;
            copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
            _verticalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
            addChild(_verticalScrollBar);
            _horizontalScrollBar = new UIScrollBar();
            _horizontalScrollBar.name = "H";
            _horizontalScrollBar.visible = false;
            _horizontalScrollBar.focusEnabled = false;
            _horizontalScrollBar.direction = ScrollBarDirection.HORIZONTAL;
            copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
            _horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
            addChild(_horizontalScrollBar);
            textField.addEventListener(TextEvent.TEXT_INPUT, handleTextInput, false, 0, true);
            textField.addEventListener(Event.CHANGE, handleChange, false, 0, true);
            textField.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
            _horizontalScrollBar.scrollTarget = textField;
            _verticalScrollBar.scrollTarget = textField;
            addEventListener(MouseEvent.MOUSE_WHEEL, handleWheel, false, 0, true);
        }
        protected function updateTextFieldType():void{
            textField.type = ((((enabled) && (_editable))) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
            textField.selectable = enabled;
            textField.wordWrap = _wordWrap;
            textField.multiline = true;
        }
        protected function handleKeyDown(_arg1:KeyboardEvent):void{
            if (_arg1.keyCode == Keyboard.ENTER){
                dispatchEvent(new ComponentEvent(ComponentEvent.ENTER, true));
            };
        }
        protected function handleChange(_arg1:Event):void{
            _arg1.stopPropagation();
            dispatchEvent(new Event(Event.CHANGE, true));
            invalidate(InvalidationType.DATA);
        }
        protected function handleTextInput(_arg1:TextEvent):void{
            _arg1.stopPropagation();
            dispatchEvent(new TextEvent(TextEvent.TEXT_INPUT, true, false, _arg1.text));
        }
        protected function handleScroll(_arg1:ScrollEvent):void{
            dispatchEvent(_arg1);
        }
        protected function handleWheel(_arg1:MouseEvent):void{
            if (((!(enabled)) || (!(_verticalScrollBar.visible)))){
                return;
            };
            _verticalScrollBar.scrollPosition = (_verticalScrollBar.scrollPosition - (_arg1.delta * _verticalScrollBar.lineScrollSize));
            dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, (_arg1.delta * _verticalScrollBar.lineScrollSize), _verticalScrollBar.scrollPosition));
        }
        protected function setEmbedFont(){
            var _local1:Object = getStyleValue("embedFonts");
            if (_local1 != null){
                textField.embedFonts = _local1;
            };
        }
        override protected function draw():void{
            if (isInvalid(InvalidationType.STATE)){
                updateTextFieldType();
            };
            if (isInvalid(InvalidationType.STYLES)){
                setStyles();
                setEmbedFont();
            };
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE)){
                drawTextFormat();
                drawBackground();
                invalidate(InvalidationType.SIZE, false);
            };
            if (isInvalid(InvalidationType.SIZE, InvalidationType.DATA)){
                drawLayout();
            };
            super.draw();
        }
        protected function setStyles():void{
            copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
            copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
        }
        protected function drawTextFormat():void{
            var _local1:Object = UIComponent.getStyleDefinition();
            var _local2:TextFormat = ((enabled) ? (_local1.defaultTextFormat as TextFormat) : (_local1.defaultDisabledTextFormat as TextFormat));
            textField.setTextFormat(_local2);
            var _local3:TextFormat = (getStyleValue(((enabled) ? "textFormat" : "disabledTextFormat")) as TextFormat);
            if (_local3 != null){
                textField.setTextFormat(_local3);
            } else {
                _local3 = _local2;
            };
            textField.defaultTextFormat = _local3;
            setEmbedFont();
            if (_html){
                textField.htmlText = _savedHTML;
            };
        }
        protected function drawBackground():void{
            var _local1:DisplayObject = background;
            var _local2:String = ((enabled) ? "upSkin" : "disabledSkin");
            background = getDisplayObjectInstance(getStyleValue(_local2));
            if (background != null){
                addChildAt(background, 0);
            };
            if (((((!((_local1 == null))) && (!((_local1 == background))))) && (contains(_local1)))){
                removeChild(_local1);
            };
        }
        protected function drawLayout():void{
            var _local1:Number = Number(getStyleValue("textPadding"));
            textField.x = (textField.y = _local1);
            background.width = width;
            background.height = height;
            var _local2:Number = height;
            var _local3:Boolean = needVScroll();
            var _local4:Number = (width - ((_local3) ? _verticalScrollBar.width : 0));
            var _local5:Boolean = needHScroll();
            if (_local5){
                _local2 = (_local2 - _horizontalScrollBar.height);
            };
            setTextSize(_local4, _local2, _local1);
            if (((((_local5) && (!(_local3)))) && (needVScroll()))){
                _local3 = true;
                _local4 = (_local4 - _verticalScrollBar.width);
                setTextSize(_local4, _local2, _local1);
            };
            if (_local3){
                _verticalScrollBar.visible = true;
                _verticalScrollBar.x = (width - _verticalScrollBar.width);
                _verticalScrollBar.height = _local2;
                _verticalScrollBar.visible = true;
                _verticalScrollBar.enabled = enabled;
            } else {
                _verticalScrollBar.visible = false;
            };
            if (_local5){
                _horizontalScrollBar.visible = true;
                _horizontalScrollBar.y = (height - _horizontalScrollBar.height);
                _horizontalScrollBar.width = _local4;
                _horizontalScrollBar.visible = true;
                _horizontalScrollBar.enabled = enabled;
            } else {
                _horizontalScrollBar.visible = false;
            };
            updateScrollBars();
            addEventListener(Event.ENTER_FRAME, delayedLayoutUpdate, false, 0, true);
        }
        protected function delayedLayoutUpdate(_arg1:Event):void{
            if (textHasChanged){
                textHasChanged = false;
                drawLayout();
                return;
            };
            removeEventListener(Event.ENTER_FRAME, delayedLayoutUpdate);
        }
        protected function updateScrollBars(){
            _horizontalScrollBar.update();
            _verticalScrollBar.update();
            _verticalScrollBar.enabled = enabled;
            _horizontalScrollBar.enabled = enabled;
            _horizontalScrollBar.drawNow();
            _verticalScrollBar.drawNow();
        }
        protected function needVScroll():Boolean{
            if (_verticalScrollPolicy == ScrollPolicy.OFF){
                return (false);
            };
            if (_verticalScrollPolicy == ScrollPolicy.ON){
                return (true);
            };
            return ((textField.maxScrollV > 1));
        }
        protected function needHScroll():Boolean{
            if (_horizontalScrollPolicy == ScrollPolicy.OFF){
                return (false);
            };
            if (_horizontalScrollPolicy == ScrollPolicy.ON){
                return (true);
            };
            return ((textField.maxScrollH > 0));
        }
        protected function setTextSize(_arg1:Number, _arg2:Number, _arg3:Number):void{
            var _local4:Number = (_arg1 - (_arg3 * 2));
            var _local5:Number = (_arg2 - (_arg3 * 2));
            if (_local4 != textField.width){
                textField.width = _local4;
            };
            if (_local5 != textField.height){
                textField.height = _local5;
            };
        }
        override protected function isOurFocus(_arg1:DisplayObject):Boolean{
            return ((((_arg1 == textField)) || (super.isOurFocus(_arg1))));
        }
        override protected function focusInHandler(_arg1:FocusEvent):void{
            setIMEMode(true);
            if (_arg1.target == this){
                stage.focus = textField;
            };
            var _local2:IFocusManager = focusManager;
            if (_local2){
                if (editable){
                    _local2.showFocusIndicator = true;
                };
                _local2.defaultButtonEnabled = false;
            };
            super.focusInHandler(_arg1);
            if (editable){
                setIMEMode(true);
            };
        }
        override protected function focusOutHandler(_arg1:FocusEvent):void{
            var _local2:IFocusManager = focusManager;
            if (_local2){
                _local2.defaultButtonEnabled = true;
            };
            setSelection(0, 0);
            super.focusOutHandler(_arg1);
            if (editable){
                setIMEMode(false);
            };
        }

    }
}//package fl.controls 
package pack {
    import flash.utils.*;

    public class WAVEncoder {

        public function addHeaders(_arg1:ByteArray, _arg2:uint=44100, _arg3:uint=1, _arg4:uint=16):ByteArray{
            var _local5:ByteArray = new ByteArray();
            _local5.endian = Endian.LITTLE_ENDIAN;
            _local5.writeUTFBytes("RIFF");
            _local5.writeInt(((_arg1.length + 44) - 8));
            _local5.writeUTFBytes("WAVE");
            _local5.writeUTFBytes("fmt ");
            _local5.writeInt(16);
            _local5.writeShort(1);
            _local5.writeShort(_arg3);
            _local5.writeInt(_arg2);
            _local5.writeInt((((_arg2 * _arg3) * _arg4) / 8));
            _local5.writeShort(((_arg3 * _arg4) / 8));
            _local5.writeShort(_arg4);
            _local5.writeUTFBytes("data");
            _local5.writeInt(_arg1.length);
            _local5.writeBytes(_arg1);
            return (_local5);
        }

    }
}//package pack 
package {
    import flash.display.*;

    public dynamic class Button_overSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class Button_disabledSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class Button_downSkin extends MovieClip {

    }
}//package 
package webVoiceRec_fla {
    import flash.display.*;
    import flash.utils.*;
    import flash.events.*;
    import pack.*;
    import com.dynamicflash.util.*;
    import flash.media.*;
    import flash.external.*;

    public dynamic class MainTimeline extends MovieClip {

        public var soundBytes:ByteArray;
        public var mic:Microphone;

        public function MainTimeline(){
            addFrameScript(0, this.frame1);
        }
        public function startRecording():void{
            this.mic.addEventListener(StatusEvent.STATUS, this.onMicStatus);
            this.mic.addEventListener(SampleDataEvent.SAMPLE_DATA, this.micSampleDataHandler);
        }
        public function onMicStatus(_arg1:StatusEvent):void{
            ExternalInterface.call("AudioManager.recordingStarted", _arg1.code);
        }
        public function micSampleDataHandler(_arg1:SampleDataEvent):void{
            var _local2:Number;
            while (_arg1.data.bytesAvailable) {
                _local2 = _arg1.data.readFloat();
                this.soundBytes.writeFloat(_local2);
            };
        }
        public function stopRecording():String{
            this.mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.micSampleDataHandler);
            var _local1:WAVEncoder = new WAVEncoder();
            var _local2:ByteArray = _local1.addHeaders(this.convert(this.soundBytes));
            var _local3:String = Base64.encodeByteArray(_local2);
            this.soundBytes = new ByteArray();
            return (_local3);
        }
        public function convert(_arg1:ByteArray):ByteArray{
            var _local2:ByteArray = new ByteArray();
            _local2.endian = Endian.LITTLE_ENDIAN;
            _arg1.position = 0;
            while (_arg1.position < _arg1.length) {
                _local2.writeShort((_arg1.readFloat() * 32767));
            };
            return (_local2);
        }
        function frame1(){
            this.soundBytes = new ByteArray();
            this.soundBytes.endian = Endian.LITTLE_ENDIAN;
            this.mic = Microphone.getMicrophone();
            this.mic.gain = 100;
            this.mic.rate = 44;
            ExternalInterface.addCallback("startRecord", this.startRecording);
            ExternalInterface.addCallback("stopRecord", this.stopRecording);
        }

    }
}//package webVoiceRec_fla 
package {
    import flash.display.*;

    public dynamic class focusRectSkin extends MovieClip {

    }
}//package 
package {
    import flash.display.*;

    public dynamic class Button_selectedDownSkin extends MovieClip {

    }
}//package
