package{
	import flash.display.Sprite;
	import flash.display.*;
	import GameFundation.*;
	import flash.events.*;
	import flash.geom.Point;
	
	public class ShowableStar extends Star implements IShowable{
		public var mParent :Sprite;
		public var displayMC:MovieClip;
		public var mActions:Array;
		public var hit:Boolean;
		public var isDevil:Boolean;
		
		public function ShowableStar(_parent:Sprite,p:Point,v:Point,a:Point,r: uint, devil:Boolean){
			super(p,v,a,r);
			isDevil = devil;
			hit = false;
			mParent=_parent;
			mActions=new Array;
			mActions["born"]= new star_appear();
			mActions["static"]=drawStar();
			mActions["die"]=new star_disappear();
			state_change("born",true);
		}
		
		public override function bounce(p:Character):Boolean
		{
			
			if (!hit && super.bounce(p))
			{
				state_change("die",true);
				hit = true;
				var e:GameEvents=new GameEvents(GameEvents.REWARD,this);
				dispatchEvent(e);
				return true;
			}
			else
			{
				return false;
			}
		}
		
		protected function state_change(_state:String,playit:Boolean,loop:Boolean=false)
		{
			if(displayMC)mParent.removeChild(displayMC);
			displayMC=mActions[_state];
			mParent.addChild(displayMC);
			place();
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
					if (!loop){
						state_change("static",false);
						removeEventListener(Event.ENTER_FRAME,dmcOnEnterFrame);
						}
					}
			
			}
			//----
		}
		public function setParent(p :Sprite)
		{
			mParent = p;
			
		}
		public function update()
		{
			move();
			place();
		}
		public function place(){
			displayMC.x=position.x-displayMC.width/2;
			displayMC.y=position.y-displayMC.height/2;
		}
		//---
		private function drawStar(){
			var mc=new MovieClip;
			var _shape=new Shape;
			_shape.graphics.beginFill(0xff0000);
			_shape.graphics.drawCircle(radius,radius,radius);
			_shape.graphics.endFill();
			mc.addChild(_shape);
			return mc;
		}
		//---
	}

}

