package GameFundation {
	
	import flash.events.*;
	
	public class MovingObject{
		public var position:Point;
		public var velocity:Point;
		public var acceleration:Point;
		
		public function move(){
			velocity += acceleration;
			position += velocity;
		}
	}
	
	public class Character extends MovingObject{
		public var raidus:uint;
		public var mass:uint;
	}
	
	public interface IBounceable extends IEventDispatcher {
		function bounce(p : Character):Boolean;		
	}
	
	public interface IMagnetic extends IEventDispatcher {
		function force(p:Character):Boolean;
	}
	
	public class Starlike extends Character implements IEventDispatcher{
		
		public function Starlike(){
			
		}

		public function reward(){
		
		}
	}
	
	public interface IShowable {
		function setParent(p :DisplayObject);
		function act();
	}
	
}