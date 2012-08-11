package
{
	import flash.display.MovieClip;
	
	public class World extends Screen
	{
		
		var front :MovieClip;
		var mid   :MovieClip;
		var back  :MovieClip;
		
		
		public var player :MovieClip;
		
		
		var Qdist 	:Number;
		var distMin :Number;
		var distMax :Number;
		
		
		public function World()
		{
			front = new MovieClip();
			mid	  = new MovieClip();
			back  = new MovieClip();
				addChild(back);
				addChild(mid);
				addChild(front);
			
			Qdist = 0;
			distMin = 10;
			distMax = 200;
			
			player = new Vehicle();
				mid.addChild(player);
				cam = player;
		}
		function World_display()
		{
			for(var i=0;
				Qdist - player.x <= _screenW;
				i += Utils.random(distMin,distMax))
			{
				createbBackground(Qdist);
				Qdist += i;
			}
		}
		function createbBackground(posx)
		{
			var mc = new MovieClip();
			with(mc)
			{
				var h = Utils.random(50,100);
				graphics.beginFill(0x333333);
				graphics.drawRect(posx,-h,10,h);
			}
			back.addChild(mc);
		}
		override public function display()
		{
			World_display();
			BaseMc_display();
		}

	}
	
}
