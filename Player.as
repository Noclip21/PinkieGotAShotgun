package
{
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	public class Player extends BaseMc
	{
		var mousePressed :Boolean;
		var vel = 1;
		public var weapon :Weapon;
		
		public function Player()
		{
			Main.stage.addEventListener(MouseEvent.MOUSE_DOWN,function(){ mousePressed = true;  });
			Main.stage.addEventListener(MouseEvent.MOUSE_UP,function()  { mousePressed = false; });
		}
		function Player_display()
		{
			character.limb.rotation = Utils.ang(character.limb,new Point(character.mouseX,character.mouseY))*180/Math.PI;
			
			if(mousePressed)
				weapon.shoot();
			
			
			if(key.isDown(key.LEFT) || key.isDown(key.RIGHT))
			{
				if(key.isDown(key.LEFT))
					_avelx -= vel;
				if(key.isDown(key.RIGHT))
					_avelx += vel;
			}else{
				_avelx *= 0.8;
				_avely *= 0.8;
			}
		}
		override public function display()
		{
			Player_display();
			BaseMc_display();
		}
	}
	
}
