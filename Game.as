package  {
	
	import GameFundation.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	
	public class Game {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		var levels:Array = new Array;
		var curMap:GameMap;
		var curLevel:int;
		var m_parent:Sprite;
		// Initialization:
		
		public function Game(_parent:Sprite) { 
			m_parent = _parent;
			
			levels[1] = "first.map";
			levels[2] = "second.map";

			curLevel = 1;
			curMap = new GameMap(levels[1],_parent);
			curMap.addEventListener(GameEvents.NEXTLEVEL, next_level);
			curMap.addEventListener(GameEvents.FAIL, die);
		}
		
		public function next_level(e:GameEvents){
			curMap.removeEventListener(GameEvents.NEXTLEVEL, next_level);
			curMap.removeEventListener(GameEvents.FAIL, die);
			curMap.free(m_parent);
			curMap = null;
			
			curLevel = curLevel+1;
			curMap = new GameMap(levels[curLevel],m_parent);
			curMap.addEventListener(GameEvents.NEXTLEVEL, next_level);
			curMap.addEventListener(GameEvents.FAIL, die);
		}
		
		public function die(e:GameEvents){
			
		}
	
		// Public Methods:
		// Protected Methods:
	}
	
}