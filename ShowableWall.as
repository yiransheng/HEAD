package  {
	import flash.display.Sprite;
	import flash.display.*;
	import GameFundation.*;
	import flash.events.*;
	import flash.geom.*;
	
	
	public class ShowableWall extends Wall implements IShowable{
		public var mParent :Sprite;
		public var displayMC:MovieClip;
		public var mActions:Array = new Array;
		
		public function ShowableWall(v0:Point, v1:Point, v2:Point, v3:Point,p: Sprite){
			super(v0, v1, v2, v3);
			mActions["static"]=drawWall();
			setParent(p);
			state_change("static",false);
		}
		
		public override function bounce(p:Character):Boolean{
			if (super.bounce(p))
			{
				//state_change();
				return true;
			}
			else
			{
				return false;
			}  
		}
		
		public function state_change(_state:String,playit:Boolean)
		{
			if(displayMC)mParent.removeChild(displayMC);
			displayMC=mActions[_state];
			mParent.addChild(displayMC);
			update();
			if(playit){
				displayMC.gotoAndPlay(2);
				displayMC.addEventListener(Event.ENTER_FRAME,dmcOnEnterFrame);
				}
			else{
				displayMC.gotoAndStop(1);
				}
			//-------	
			function dmcOnEnterFrame(e:Event){
				if (displayMC.currentFrame==1 && playit){
					displayMC.stop();
					removeEventListener(Event.ENTER_FRAME,dmcOnEnterFrame);
					}
				}
			
		}
		public function setParent(p :Sprite)
		{
			mParent = p;
			
		}
		public function update()
		{
			
		}
		public function drawWall(){
			var mc=new MovieClip;
			var _shape=new Shape;
			_shape.graphics.beginFill(0xff0000);
			_shape.graphics.moveTo(Vertex0.x,Vertex0.y);
			_shape.graphics.lineTo(Vertex1.x,Vertex1.y);
			_shape.graphics.lineTo(Vertex2.x,Vertex2.y);
			_shape.graphics.lineTo(Vertex3.x,Vertex3.y);
			_shape.graphics.endFill();
			mc.addChild(_shape);
			return mc;
		}
	}
}