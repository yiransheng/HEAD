package GameFundation {
	
	import flash.events.*;
	import flash.geom.Point;
	
	public class MovingObject{
		public var position:Point=new Point(10,200);
		public var velocity:Point=new Point(0,0);
		public var acceleration:Point=new Point(.01,-.01);
		
		public function move(){
			velocity=velocity.add(acceleration);
			position=position.add(velocity);
		}
	}
	
	
	
}