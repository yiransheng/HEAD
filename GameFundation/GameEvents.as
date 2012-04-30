package GameFundation {
	
	import flash.events.*;
	
	public class GameEvents extends Event {
		
		// Constants:
		public static const BOUNCE = "bounce";
		public static const REWARD = "reward";
		public static const FORCE = "force";
		public static const WALLDRAWN = "walldrawn";
		public static const NEXTLEVEL = "nextlevel";
		public static const FAIL = "fail";
		// Public Properties:
		public var params:Object;
		
		// Private Properties:
	
		// Initialization:
		public function GameEvents($type:String, $params:Object, $bubbles:Boolean = false, $cancelable:Boolean = false)
        {
            super($type, $bubbles, $cancelable);
           
            this.params = $params;
        }
		// Public Methods:
		public override function clone():Event
        {
            return new GameEvents(type, this.params, bubbles, cancelable);
        }
       
        public override function toString():String
        {
            return formatToString("GameEvents", "params", "type", "bubbles", "cancelable");
        }
		// Protected Methods:
	}
	
}