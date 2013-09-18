package com.fastframework.module.d3input {
	import com.fastframework.core.IFASTEventDispatcher;
	/**
	 * @author digi3colin
	 */
	public interface ITextInput extends IFASTEventDispatcher{
		function setText(str:String):void;
		function getText():String;
		function isOnStage():Boolean;
		function focus():void;
	}
}
