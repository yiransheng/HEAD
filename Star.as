package  {
	
	import GameFundation.*;
	import flash.events.*;
	import flash.geom.*;
	public class Star extends Starlike implements IBounceable{
		
		// Constants:
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		public function Star(p:Point,v:Point,a:Point,r: uint) 
		{ 
			position=p;
			velocity=v;
			acceleration=a;
			radius=r;
		}
	
		// Public Methods:
		public function bounce(p:Character):Boolean{
			
			////if bounce occur
			if( Point.distance(p.position, this.position) <= p.radius + this.radius)
			{				
				var e:GameEvents = new GameEvents(GameEvents.BOUNCE, p.velocity);
				dispatchEvent(e);
				return true;
			}
			else
			{
				return false;
			}
		}
		// Protected Methods:
	}
	
}