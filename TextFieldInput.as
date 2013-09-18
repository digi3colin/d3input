package com.fastframework.module.d3input {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.log.FASTLog;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	/**
	 * @author digi3colin
	 */
	public class TextFieldInput extends FASTEventDispatcher implements ITextInput {
		private var base:TextField;
		private var autoCapitalizeWord:Boolean;
		public static var TEXT_AUTO_CAPTIALIZE_WORD_IMP:Function;
		
		public function TextFieldInput(txf:TextField,autoCapitalizeWord:Boolean = false){
			base = txf;
			base.addEventListener(KeyboardEvent.KEY_DOWN, forward,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_OUT, forward,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_IN, forward,false,0,true);
			base.addEventListener(Event.CHANGE, onChange,false,0,true);
			base.addEventListener(Event.ADDED_TO_STAGE, forward,false,0,true);

			this.autoCapitalizeWord = autoCapitalizeWord;
		}

		private function redraw():void{
			base.text = base.text;
			base.visible = true;
			FASTLog.instance().log('redraw',FASTLog.LOG_LEVEL_ACTION);
		}
		
		public function setText(str : String) : void {
			base.text = str;
		}
	
		public function getText() : String {
			return base.text;
		}
	
		public function isOnStage() : Boolean {
			return (base.stage!=null);
		}
	
		public function focus() : void {
			base.stage.focus = base;
			base.setSelection(0, 0);
		}

		private function forward(e:Event):void{
			dispatchEvent(e);
			
			if(e is KeyboardEvent && KeyboardEvent(e).keyCode == 13){
				setTimeout(redraw, 1000);
				base.visible = false;
			}
		}
		
		private function onChange(e:Event):void{
			if(autoCapitalizeWord&&TEXT_AUTO_CAPTIALIZE_WORD_IMP!=null){
				TextFieldInput.TEXT_AUTO_CAPTIALIZE_WORD_IMP(base);
			}
			forward(e);
		}
	}
}