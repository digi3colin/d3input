package com.fastframework.module.d3input {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Digi3
	 */
	public class HoldButton extends FASTEventDispatcher {
		public static const EVENT_ACTIVATE : String = "EVENT_ACTIVATE";
		private var activateTimer:Timer;
		public function HoldButton(btn:SimpleButton,elapseTime:int){
			btn.addEventListener(MouseEvent.MOUSE_DOWN, pendingActivate,false,0,true);
			btn.addEventListener(MouseEvent.MOUSE_UP, 	clearActivate,	false,0,true);
			activateTimer = new Timer(elapseTime,1);
			activateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dispatchActivate, false,0,true);	
		}
	
		private function pendingActivate(e:Event):void{
			activateTimer.reset();
			activateTimer.start();
		}
	
		private function clearActivate(e:Event):void{
			activateTimer.stop();
		}
	
		private function dispatchActivate(e:Event):void{
			dispatchEvent(new Event(EVENT_ACTIVATE));
		}
	}
}