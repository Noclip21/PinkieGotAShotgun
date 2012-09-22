package
{
	
	import flash.display.MovieClip;
	
	
	public class Target extends BaseMc
	{
		static var _objects : Array;
		
		var hp :Number;
		
		public static function get objects(){ return _objects; }
		
		
		public function Target(hitpoints :Number = 1)
		{
			if(!_objects) _objects = new Array();
			_objects.push(this);
			
			hp = hitpoints;
		}
		
		public function dmg(damage :Number)
		{
			if(damage >= hp)
			{
				Utils.removeObject(this,_objects);
				Utils.kill(this);
			}else
				hp -= damage;
		}
	}
	
}
