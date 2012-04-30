package {

	import GameFundation.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class Wall extends MovingObject implements IBounceable {

		// Constants:
		// Public Properties:
		public var Vertex0:Point;
		public var Vertex1:Point;
		public var Vertex2:Point;
		public var Vertex3:Point;
		// Private Properties:

		// Initialization:
		public function Wall(v0:Point, v1:Point, v2:Point, v3:Point) {
			Vertex0=v0.clone();
			Vertex1=v1.clone();
			Vertex2=v2.clone();
			Vertex3=v3.clone();
		}

		// Public Methods:
		public function bounce(p:Character):Boolean {

			////if bounce occur
			var v1:Point=Vertex0.subtract(Vertex1);
			var v2:Point=Vertex1.subtract(Vertex2);
			v1.normalize(p.radius);
			v2.normalize(p.radius);
			
			if (isIn(p.position,Vertex0.add(v1),Vertex1.subtract(v1),Vertex2.subtract(v1),Vertex3.add(v1))){
				trace ("false");
				return false;
			}
			
			if (isIn(p.position, Vertex0.add(v2),Vertex1.add(v2),Vertex2.subtract(v2),Vertex3.subtract(v2))){
				trace ("false");
				return false;
			}
			
			if (Point.distance(p.position,Vertex0)<=p.radius) {
				trace ("false");
				return false;
			}
			
			if (Point.distance(p.position,Vertex1)<=p.radius) {
				trace ("false");
				return false;
			}
			
			if (Point.distance(p.position,Vertex2)<=p.radius) {
				trace ("false");
				return false;
			}
			
			if (Point.distance(p.position,Vertex3)<=p.radius) {
				trace ("false");
				return false;
			}
			
			var new_p:Point = p.position.add(p.velocity);
			var tan0:Point =new_p.add(v1);
			var tan1:Point =new_p.subtract(v1);
			var tan2:Point =new_p.add(v2);
			var tan3:Point =new_p.subtract(v2);

			var n:Point;
			
			if (isIn(tan0,Vertex0,Vertex1,Vertex2,Vertex3)||isIn(tan1,Vertex0,Vertex1,Vertex2,Vertex3)) {
				n=v1.clone();
				react(n,p);
				return true;
			}
			
			if (isIn(tan2,Vertex0,Vertex1,Vertex2,Vertex3)||isIn(tan3,Vertex0,Vertex1,Vertex2,Vertex3)) {
				n=v2.clone();
				react(n,p);				
				return true;
			}
			
			if (Point.distance(new_p,Vertex0)<=p.radius) {
				react(Vertex0.subtract(new_p),p);
				return true;
			}
			
			if (Point.distance(new_p,Vertex1)<=p.radius) {
				react(Vertex1.subtract(new_p),p);
				return true;
			}
			
			if (Point.distance(new_p,Vertex2)<=p.radius) {
				react(Vertex2.subtract(new_p),p);
				return true;
			}
			
			if (Point.distance(new_p,Vertex3)<=p.radius) {
				react(Vertex3.subtract(new_p),p);
				return true;
			}
			
			return false;

		}

		protected function react(n:Point,p:Character) {			
			n.normalize(1);
			n.normalize(n.x* p.velocity.x + n.y*p.velocity.y);

			var v:Point=p.velocity.clone();
			v=v.subtract(n);
			v=v.add(v);
			v=v.subtract(p.velocity);

			var e:GameEvents=new GameEvents(GameEvents.BOUNCE,v);
			dispatchEvent(e);
			
		}

		protected function isIn(p:Point,v0:Point, v1:Point, v2:Point, v3:Point):Boolean {
			/*var d0:Point=Vertex0.subtract(p);
			var d1:Point=Vertex1.subtract(p);
			var d2:Point=Vertex2.subtract(p);
			var d3:Point=Vertex3.subtract(p);

			if (d0.x*d1.y-d0.y*d1.x>0) {
				return false;
			}
			if (d1.x*d2.y-d1.y*d2.x>0) {
				return false;
			}
			if (d2.x*d3.y-d2.y*d3.x>0) {
				return false;
			}
			if (d3.x*d0.y-d3.y*d0.x>0) {
				return false;
			}
			return true;*/
			var box = new Shape();
			box.graphics.beginFill(0xffff00);
			box.graphics.moveTo(v0.x,v0.y);
			box.graphics.lineTo(v1.x,v1.y);
			box.graphics.lineTo(v2.x,v2.y);
			box.graphics.lineTo(v3.x,v3.y);
			box.graphics.lineTo(v0.x,v0.y)
			box.graphics.endFill();
			var w=Math.max(400,box.width);
			var h=Math.max(400,box.height);
			var bmd1:BitmapData = new BitmapData(w,h,true,0);
			bmd1.draw(box);
			return (bmd1.hitTest(new Point(0,0),255,p));
			
		}

		protected var mEp:EventDispatcher = new EventDispatcher ();

		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			mEp.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}

		public function dispatchEvent(event:Event):Boolean {
			return mEp.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean
		{
			return mEp.hasEventListener(type);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			mEp.removeEventListener(type,listener,useCapture);
		}
		public function willTrigger(type:String):Boolean {
			return mEp.willTrigger(type);
		}
		// Protected Methods:
	}

}