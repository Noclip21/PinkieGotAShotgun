package
{
	
	public class Vehicle extends BaseMc
	{
		var vel = 1;
		
		public function Vehicle()
		{
			
		}
		function Vehicle_display()
		{
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
			Vehicle_display();
			BaseMc_display();
		}
	}
	
}
