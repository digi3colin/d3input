package com.fastframework.module.d3input{
	import com.fastframework.core.IFASTEventDispatcher;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface ISmartInput extends IFASTEventDispatcher{
		function setValidateFunction(fnt:Function):void;
		function validate(...e):Boolean;
		function validateWithoutEventDispatch():Boolean;
		function setSubmit(fnt:Function):void;
		function getValue():String;
		function clear():void;
		function focus():void;
	}
}