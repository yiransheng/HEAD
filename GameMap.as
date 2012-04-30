package  {
	
	import GameFundation.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	
	public class GameMap extends Sprite {
		
		// Constants:
		public const WIDTH:uint = 1024;
		public const HEIGHT:uint = 768;
		public const ORIGIN:Point =  new Point(0,0);
		public var _container:Sprite= new Sprite;
		
		// Public Properties:
		public var mBounceables:Vector.<IBounceable>=new Vector.<IBounceable>;
		//public var mFieldSources:Vector.<IMagnetic>=new Vector.<IMagnetic>;
		public var mStarlikes:Vector.<Starlike>=new Vector.<Starlike>;
		
		public var mScore:int = 0;
		public var mHp:int = 3;
		
		public var mMainCharacter:ShowableStar;
		public var mCustomWall:ShowableWall;
		// Private Properties:

		// Initialization:
		public function GameMap(map_config_file:String, _parent:Sprite) {
			//// load map
			_parent.addChild(this);
			mMainCharacter =new ShowableStar(this,new Point(50,200),new Point(1.8,1.75),new Point(0,.02),20,false);
			
			var wall1=new ShowableWall(new Point(200,100),new Point(250,100),new Point(250,50),new Point(200,50),this);
			mBounceables.push(wall1);
			var wall2=new ShowableWall(new Point(0,350),new Point(550,350),new Point(550,400),new Point(0,400),this);
			mBounceables.push(wall2);
			var wall3=new ShowableWall(new Point(10,0),new Point(-10,0),new Point(-10,350),new Point(10,350),this);
			mBounceables.push(wall3);
			
			var wall5=new ShowableWall(new Point(300,200),new Point(350,200),new Point(350,150),new Point(300,150),this);
			mBounceables.push(wall5);
			var wall6=new ShowableWall(new Point(100,200),new Point(150,200),new Point(150,150),new Point(100,150),this);
			mBounceables.push(wall6);
			

			var ss =new ShowableStar(this,new Point(70,120),new Point(0,0),new Point(0.02,-0.02),20,false);
			mBounceables.push(ss);
			mStarlikes.push(ss);
			
			mCustomWall=new ShowableWall(new Point(0,0),new Point(0,0),new Point(0,0),new Point(0,0),this);
			mBounceables.push(mCustomWall);
			var mMouseHandler=new MouseHandler(this);
			addChild(mMouseHandler);
			
			// add listeners
			var i;
			for(i = 0; i< mBounceables.length; i++ ){
				mBounceables[i].addEventListener(GameEvents.BOUNCE, on_bounce);
			}
			for(i = 0; i< mStarlikes.length; i++ ){
				mStarlikes[i].addEventListener(GameEvents.REWARD, on_reward);
			}
			/*for(var i = 0; i< mFieldSources.length; i++ ){
				mFieldSources[i].addEventListener(GameEvents.FORCE, on_force);
			}*/
			this.addEventListener(Event.ENTER_FRAME,update);
		}
	
		// Public Methods:
		public function free(_parent:Sprite)
		{
			_parent.removeChild(this);
		}
		
		public function on_bounce(e:GameEvents){
			
			mMainCharacter.velocity = e.params as Point;
			
			
		}
		
		public function on_force(e:GameEvents){
		
		}
		
		public function on_reward(e:GameEvents){
			var s:ShowableStar = e.params as ShowableStar;
			var e:GameEvents;
			if(s.isDevil){
				mHp --;
				if(mHp == 0)
				{
					e =new GameEvents(GameEvents.FAIL,this);
					dispatchEvent(e);
				}				
			}
			else{
				mScore ++;
				if(mScore == 1)
				{
					trace(mScore);
					e =new GameEvents(GameEvents.NEXTLEVEL,this);
					dispatchEvent(e);
				}
			}
		}
		public function update(e:Event){
			mMainCharacter.update();
			
			var i;
			for(i = 0; i< mBounceables.length; i++ ){
				mBounceables[i].bounce(mMainCharacter);
			}
			for(i = 0; i< mStarlikes.length; i++ ){
				mStarlikes[i].reward();
			}
			/*for(i = 0; i< mFieldSources.length; i++ ){
				mFieldSources[i].bounce(mMainCharacter);
			}*/
		}
		
		public function modifyCustomWall(_wall:Wall)
		{
			trace ("modifying custom wall.");
			mCustomWall.Vertex0= _wall.Vertex0;
			mCustomWall.Vertex1= _wall.Vertex1;
			mCustomWall.Vertex2= _wall.Vertex2;
			mCustomWall.Vertex3= _wall.Vertex3;
			mCustomWall.mActions["static"]=mCustomWall.drawWall();
			mCustomWall.state_change("static",false);
		}
		
		// Protected Methods:
	}
	
}