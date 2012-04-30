package GameFundation {
	
	import flash.events.*;
	public class Starlike extends Character implements IEventDispatcher{
		
		public function Starlike(){
			
		}

		public function reward(){
		
		}
		
		protected var mEp:EventDispatcher = new EventDispatcher ();
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			mEp.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return mEp.dispatchEvent(event);
		}
		public function	hasEventListener(type:String):Boolean
		{
			return mEp.hasEventListener(type);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			mEp.removeEventListener(type,listener,useCapture);
		}
		public function willTrigger(type:String):Boolean{
			return mEp.willTrigger(type);
		}

	}

}