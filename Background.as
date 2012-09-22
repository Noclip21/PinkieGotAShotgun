package
{
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import flash.geom.Point;
	
	public class Background extends Screen
	{
		
		var _map	:String;
		var target	:Object;
		
		var layer0	:MovieClip;
		var layer1	:MovieClip;
		var layer2	:MovieClip;
		
		var layer0X :Number;
		var layer1X :Number;
		var layer2X :Number;
		
		var layer0Objects :Array;
		var layer1Objects :Array;
		var layer2Objects :Array;
		
		
		public function get map() { return _map; }
		
		public function set map(n)			{ _map = n; }
		override public function set cam(n) { target = n;  }
											

		public function Background(mapName :String)
		{
			_map = mapName;
			
			layer0 = new MovieClip();
			layer1 = new MovieClip();
			layer2 = new MovieClip();
				addChild(layer0);
				addChild(layer1);
				addChild(layer2);
				
			layer0X = layer1X = layer2X = 0;
				
			layer0Objects = new Array();
			layer1Objects = new Array();
			layer2Objects = new Array();
		}
		function addMc(layer :Number)
		{
			if(target.x + _screenW*2 - this['layer'+layer+'X'] - this['layer'+layer].x >= _screenW)
			{
				var objClass :Class = Class(flash.utils.getDefinitionByName(_map+'_layer'+layer));
				
				var obj = new objClass();
					this['layer'+layer].addChild(obj);
					this['layer'+layer+'Objects'].push(obj);
					
					obj.x = this['layer'+layer+'X'];
					this['layer'+layer+'X'] += obj.width;
			}
		}
		function removeMc(layer :Number)
		{
			for(var i=0; i<this['layer'+layer+'Objects'].length; i++)
			{
				var obj = this['layer'+layer+'Objects'][i];
				if(target.x - obj.x - obj.width - this['layer'+layer].x >= _screenW)
				{
					Utils.removeObject(obj,this['layer'+layer+'Objects']);
					Utils.kill(obj);
				}
			}
		}
		function Background_display()
		{
			if(target)
			{
				layer0.x = target.x - _screenW/2;
				layer0.y = target.y - _screenH/2;
				
				layer1.x = target.x*4/5 - _screenW/2;
				layer1.y = target.y*4/5 - _screenH/2;
				
				layer2.x = - _screenW/2;
				layer2.y = - _screenH/2;
				
	
				addMc(0);
				addMc(1);
				addMc(2);
				removeMc(0);
				removeMc(1);
				removeMc(2);
			}
		}
		override public function display()
		{
			Background_display();
			BaseMc_display();
		}
	}
	
}
