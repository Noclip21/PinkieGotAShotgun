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
			
			player = new Player();
				mid.addChild(player);
				cam = player;
				
			var weapon = new Weapon('type3',player.character.limb,this);
				player.character.limb.addChild(weapon);
				weapon.x += 100;
				player.weapon = weapon;
		}
		function World_display()
		{
			for(var i=0;
				Qdist - player.x <= _screenW;
				i += Utils.random(distMin,distMax))
			{
				createbBackground(Qdist);
				createTarget(Qdist);
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
