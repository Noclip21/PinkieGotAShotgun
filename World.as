package
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class World extends Screen
	{
		
		public var front :Screen;
		public var mid   :Screen;
		public var back  :Screen;
		
		
		public var player :MovieClip;
		
		
		var point :Point;
		
		public function World()
		{
			front = new Screen();
			mid	  = new Screen();
			back  = new Screen();
				addChild(back);
				addChild(mid);
				addChild(front);
			
			player = new Player();
				mid.addChild(player);
				cam = player;
				
			point = new Point(0,0);
			
			var bg = new Background('map1');
				back.addChild(bg);
				player.y = 0;
				bg.cam = point;
				
			var weapon = new Weapon('type3',player.character.limb,this);
				player.character.limb.addChild(weapon);
				weapon.x += 100;
				player.weapon = weapon;
				
				createTarget(player.x);
		}
		function World_display()
		{
			point.x += 10;
		}
		/*function createbBackground(posx)
		{
			var mc = new MovieClip();
			with(mc)
			{
				var h = Utils.random(50,100);
				graphics.beginFill(0x333333);
				graphics.drawRect(posx,-h,10,h);
			}
			back.addChild(mc);
		}*/
		function createTarget(posx)
		{
			var mc = new Target(5);
				mc.x = posx;
				mc.y = Utils.random(-100,50);
			front.addChild(mc);
		}
		override public function display()
		{
			World_display();
			BaseMc_display();
		}

	}
	
}
