package com.fastframework.module.d3input {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.module.d3mobile.IStageText;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;

	/**
	 * @author digi3colin
	 */
	public class StageTextInput extends FASTEventDispatcher implements ITextInput {
		private var base:IStageText;
		public function StageTextInput(stx:IStageText){
			this.base = stx;
			base.addEventListener(KeyboardEvent.KEY_DOWN, forward,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_OUT, forward,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_IN, forward,false,0,true);
			base.addEventListener(Event.CHANGE, forward,false,0,true);
			base.addEventListener(Event.ADDED_TO_STAGE, forward,false,0,true);
	
		}
	
		public function setText(str : String) : void {
			this.base.setText(str);
		}
	
		public function getText() : String {
			return this.base.getText();
		}
	
		public function isOnStage() : Boolean {
			return this.base.getStage()!=null;
		}
	
		public function focus() : void {
			base.assignFocus();
		}

		private function forward(e:Event):void{
			dispatchEvent(e);
		}
	}
}
