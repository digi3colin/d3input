package com.fastframework.module.d3input {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;

	/**
	 * @author digi3colin
	 */
	public class TextInputValidator extends FASTEventDispatcher implements ISmartInput {
		public static const EVENT_VALID : String = "EVENT_VALID";
		public static const EVENT_INVALID : String = "EVENT_INVALID";
		public static const EVENT_RESET : String = "EVENT_RESET";
		public static const EVENT_CHANGE : String = "EVENT_CHANGE";
		public static const EVENT_FOCUS_OUT : String = "EVENT_FOCUS_OUT";
		public static const EVENT_FOCUS_IN : String = "EVENT_FOCUS_IN";

		private var liveUpdate:Boolean;
		private var focusClear:Boolean;
		private var base : ITextInput;
		private var impValidate : Function;
		private var impSubmit : Function;
		private var oText : String;

		public function TextInputValidator(textInput:ITextInput,alwaysCheck:Boolean,focusClear:Boolean=false){
			base = textInput;
			oText = base.getText();
			base.when(KeyboardEvent.KEY_DOWN, onKeyDown);
			base.when(FocusEvent.FOCUS_OUT, focusOut);
			base.when(FocusEvent.FOCUS_IN, focusIn);
			base.when(Event.CHANGE, onChange);

			this.liveUpdate = alwaysCheck;
			this.focusClear = focusClear;
		}
		
		public function setValidateFunction(fnt : Function) : void {
			impValidate = fnt;
		}

		public function validate(...e : *) : Boolean {
			if(validateWithoutEventDispatch()){
				dispatchEvent(new Event(TextInputValidator.EVENT_VALID));
				return true;
			}else{
				dispatchEvent(new Event(TextInputValidator.EVENT_INVALID));
				return false;
			}
			return false;
		}

		public function validateWithoutEventDispatch() : Boolean {
			if(impValidate!=null){
				return impValidate(getValue());
			}
			return true;
		}

		public function setSubmit(fnt : Function) : void {
			impSubmit = fnt;
		}

		public function getValue() : String {
			if(base.getText()==oText && focusClear==true)return '';
			return base.getText();
		}

		public function clear() : void {
			base.setText('');
			dispatchEvent(new Event(TextInputValidator.EVENT_RESET));
		}

		public function focus() : void {
			if(!base.isOnStage()){
				base.once(Event.ADDED_TO_STAGE, onAddStage);
				return;
			}
			doFocus();
		}

		private function onAddStage(e:Event):void{
			doFocus();
		}

		private function doFocus():void{
			base.focus();

		}

		private function onChange(e:Event):void{
			dispatchEvent(new Event(TextInputValidator.EVENT_CHANGE));
		}

		private function onKeyDown(e:KeyboardEvent):void{
			if(liveUpdate==true){
				validate();
			}
			if(e.keyCode==13)submit();
		}

		private function submit():Boolean{
			if(validate()==false)return false;
			if(impSubmit==null)return false;

			impSubmit();
			return true;
		}
		
		private function focusOut(e:FocusEvent):void{
			validate();
			if(base.getText()=="")base.setText(oText);
			dispatchEvent(new Event(TextInputValidator.EVENT_FOCUS_OUT));
		}
		
		private function focusIn(e:FocusEvent):void{
			if(focusClear==true && (oText==base.getText()||base.getText()=="-"||base.getText()=="0")){
				base.setText("");
			}
			dispatchEvent(new Event(TextInputValidator.EVENT_FOCUS_IN));	
		}
	}
}

