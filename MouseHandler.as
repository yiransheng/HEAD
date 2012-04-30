package{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	import GameFundation.*;
	
	public class MouseHandler extends Sprite implements IEventDispatcher{
		public var mParent:GameMap;
		public var line_shape:Shape;
		private var mWall:Wall;
		private var h:uint = 10;
		
	public function MouseHandler(p:GameMap){
		setParent(p);
		var _temp:MovieClip = new box();
		_temp.alpha = .1;
		addChild(_temp);
		mParent.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		mParent.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
	
	public function setParent(p:GameMap){
		mParent = p;
		}
	
	public function onMouseDown(e:MouseEvent){
		trace ("mouse is down");
		line_shape=new Shape;
		mParent.addChild(line_shape);
		mWall=null;
		var mp=new Point(mParent.mouseX,mParent.mouseY);
		var origin= new Point(0,0);
		mWall=new Wall(mp.clone(),origin,origin,origin);
		}
	public function onMouseUp(e:MouseEvent){
		trace ("mouse is up");
		if(mWall){
			trace("wall drawn!");
			var mp=new Point(mParent.mouseX,mParent.mouseY);
			var l=mp.subtract(mWall.Vertex0);
			l=new Point(-l.y,l.x);
			l.normalize(-h);
			mWall.Vertex1=mp;
			mWall.Vertex2=mp.add(l);
			mWall.Vertex3=mWall.Vertex0.add(l);
			mParent.modifyCustomWall(mWall);
			mParent.removeChild(line_shape);
			line_shape = null;
			}
		}
	public function onEnterFrame(e:Event){
		if(line_shape)
		{
			mParent.removeChild(line_shape);
			line_shape.graphics.beginFill(0xaa0000);
			line_shape.graphics.drawCircle(mParent.mouseX,mParent.mouseY,3);
			line_shape.graphics.endFill();
			mParent.addChild(line_shape);
		}
		}
	}
}