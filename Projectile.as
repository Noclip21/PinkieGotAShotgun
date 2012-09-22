package
{
	import flash.geom.Point;
	
	public class Projectile extends BaseMc
	{
		var _damage  :Number;
		var _pierce	 :Number;
		var _ratius  :Number;
		var _speed	 :Number;
		var _angle   :Number;
		var _maxDist :Number;
		
		
		var origin  :Point;
		var dist	:Number;
		
		public function get damage() { return _angle;	 }
		public function get pierece(){ return _pierce;	 }
		public function get ratius() { return _ratius;	 }
		public function get speed()  { return _speed;	 }
		public function get angle()  { return _angle;	 }
		public function get maxDist(){ return _maxDist;  }
		

		public function set damage(n) { _damage = n;  }
		public function set pierece(n){ _pierce = n;  }
		public function set ratius(n) { _ratius = n;  }
		public function set speed(n)  { _speed = n;   }
		public function set angle(n)  { _angle = n;   }
		public function set maxDist(n){ _maxDist = n; }
		
		
		public function Projectile(	pos	 :Point,
							   		ang	 :Number = 0,
							   		dmg	 :Number = 1,
							   		sp	 :Number = 50,
							   		pierc :Number = 1,
							   		r	 :Number = 0,
							   		maxD  :Number = 999)
		{
			_damage	 = dmg;
			_pierce	 = pierc;
			_ratius	 = r;
			_speed	 = sp;
			_angle	 = ang;
			_maxDist = maxD;
			
			origin = pos;
				x = pos.x;
				y = pos.y;
				
			dist = 0;
		}
		function Bullet_display()
		{
			rotation = _angle*180/Math.PI;
			
			_avelx = Math.cos(_angle)*_speed;
			_avely = Math.sin(_angle)*_speed;
			
			
			for(var i=0; i<Target.objects.length; i++)
			{
				var target = Target.objects[i];
				
				var bTrace = new Array(new Point(x,y), new Point(x+_avelx,y+_avely));
				var tTrace = new Array(new Point(target.x,target.y),new Point(target.x,target.y+target.height));
				
				if(Utils.segIntersec(bTrace,tTrace))
				{
				   target.dmg(_damage);
				   _pierce--;
				   if(_pierce <= 0) Utils.kill(this); break;
				}
			}
			
			
			dist += _speed;
			
			if(dist > _maxDist)
				Utils.kill(this);
		}
		override public function display()
		{
			Bullet_display();
			BaseMc_display();
		}
	}
	
}
