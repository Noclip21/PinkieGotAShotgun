﻿package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		public static var GUI	:MovieClip;
		public static var game	:MovieClip;
		public static var key	:KeyObject;
		
		
		static var _PAUSE	:Boolean;
		static var _TIME	:Number;
		static var _objects :Array;
		static var _screens	:Array;
		static var _stage	:Object;
		
		
		public static function get PAUSE()	{ return _PAUSE;   }
		public static function get TIME()	{ return _TIME;	   }
		public static function get objects(){ return _objects; }
		public static function get screens(){ return _screens; }
		
		public static function set PAUSE(n)	 { _PAUSE = n;		 }
		public static function set TIME(n)	 { _TIME = n;		 }
		public static function set objects(n){ _objects.push(n); }
		public static function set screens(n){ _screens.push(n); }
		
		public static function get stage() { return _stage;				}
		public static function get width() { return _stage.stageWidth;  }
		public static function get height(){ return _stage.stageHeight; }
		public static function get mouseX(){ return _stage.mouseX;      }
		public static function get mouseY(){ return _stage.mouseY;      }
		
		
		public function Main()
		{
			GUI	 = new MovieClip();
			game = new MovieClip();
			key  = new KeyObject(stage);
		
				addChild(game);
				addChild(GUI);
				
			_PAUSE 		= false;
			_TIME 		= 1.0;
			_objects 	= new Array();
			_screens	= new Array();
			_stage		= stage;
			
			stage.addEventListener(Event.ENTER_FRAME,eventEnterFrame);
			
			// Begin code
			
			var world = new World();
				game.addChild(world);
				
			// End code
		}
		function eventEnterFrame(e :Event)
		{
			for(var i=0; i<_objects.length; i++)
				_objects[i].display();
		}
	}
	
}
