package 
{
	import flash.utils.*;
	import flash.display.MovieClip;
	import flash.display.MorphShape;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.media.SoundMixer;
	
	public class Utils extends MovieClip
	{
		
		
		
		
		// spatial functions
		
		
			// returns distance between two given movieclips
		public static function dist(a :Object,b :Object)
		{
			return Math.sqrt(Math.pow(a.x - b.x,2) + Math.pow(a.y - b.y,2));
		}
		
			// returns angle between two given movieclips
		public static function ang(a :Object,b :Object)
		{
			var angulo = Math.atan((a.y - b.y)/(a.x - b.x));
			if(!angulo) angulo = 0;
			
			if(a.x < b.x)
				return angulo;
			else
				return Math.PI + angulo;
		}
		
			// returns a objects with given x and y coorinates
		public static function pAt(a,b)
		{
			var obj = new Object();
				obj.x = a;
				obj.y = b;
			return obj;
		}
		
		
		
		
		// movieclip array functions
		
		
			// returns id of movieclip in an array given the two
		public static function getID(item,array)
		{
			for(var i=0;i<array.length;i++)
				if(array[i] == item)
					return  i;
			return null;
		}
		
			// removes a movieclip fomr an array given the two
		public static function removeObject(target,array)
		{
			array.splice(getID(target,array),1);
		}
		
			// deletes a given movieclip if it still exists
		public static function kill(target)
		{
			if(target)
			{
				target.parent.removeChild(target);
				target.stop();
				target = null;
			}
		}
		
			// returns class of given movieclip
		public static function getClass(obj)
		{
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
		
		
		
		
		// number and array funcitons
		
		
			// returns averange value given a array
		public static function averange(array)
		{
			var n = 0;
			for(var i=0; i<array.length; i++)
				n += array[i];
			return n/array.length;
		}
		
			// returns highest number of a given array
		public static function max(array)
		{
			var n = array[0];
			for(var i=0; i<array.length; i++)
				if(n < array[i])
					n = array[i];
			return n;
		}
		
			// returns smaller number of a given array
		public static function min(array)
		{
			var n = array[0];
			for(var i=0; i<array.length; i++)
				if(n > array[i])
					n = array[i];
			return n;
		}
		
			// initialize given array with given default value and length
		public static function init(array,len,def = 0)
		{
			for(var i=0; i<len; i++)
				array[i] = def;
		}
		
			// copy given array
		public static function copy(array)
		{
			var copy = new Array();
			for(var i=0; i<array.length; i++)
				copy.push(array[i]);
			return copy;
		}
		
			/*
			* pile up an element at the end of an array
			* moving the subsequent values in order to
			* not change length
			*/
		public static function pile(array,val)
		{
			for(var i=0; i<array.length-1; i++)
				array[i] = array[i+1];
			array[array.length-1] = val;
		}
		
			// returns random number given a range
		public static function random(from,to)
		{
			return Math.random()*(to-from) + from;
		}
		
			// returns given number positive or negative
		public static function randSig(n)
		{
			if(Math.round(random(1,0)) == true)
				return n;
			else
				return -n;
		}
		
		
		
		
		// movieclip animation
		
		
			// changes alpha of a given movieclip with a given value and a max and min range
		public static function alph(target :Object,min :Number,max :Number,val :Number)
		{
			if(val > 0)
			{
				if(target.alpha + val <= max)
					target.alpha += val;
				else
					target.alpha = max;
			}else{
				if(target.alpha + val >= min)
					target.alpha += val;
				else
					target.alpha = min;
			}
		}
		
			// returns relatice difference between two given numbers and easy
		public static function difFactor(a,b,easy = 0)
		{
			return (a - b)*easy;
		}
		
			// animate alpha of a given movieclip with given offset and callback
		public static function fade(obj,offset = -0.05,callback = null,min = 0,max = 1)
		{
			if(getClass(obj) != Event)
			{
				if(!obj.hasEventListener('fade'))
				{
					obj.minAlpha = min;
					obj.maxAlpha = max;
					obj.offsetAlpha = offset;
					obj.callbackAlpha = callback;
					
					obj.addEventListener(Event.ENTER_FRAME,fade);
				}
			}else{
				
				var mc = obj.target;
						
				//alph(mc,mc.minAlpha,mc.maxAlpha,mc.offsetAlpha);
				mc.alpha += mc.offsetAlpha;
				
				if(mc.alpha <= mc.minAlpha || mc.alpha >= mc.maxAlpha)
				{
					mc.removeEventListener(Event.ENTER_FRAME,fade);
					
					if(mc.alpha < mc.minAlpha) mc.alpha = mc.minAlpha; 
					if(mc.alpha > mc.maxAlpha) mc.alpha = mc.maxAlpha; 
					if(mc.callbackAlpha) mc.callbackAlpha();
				}
			}
		}
		
			// animate position of a given movieclip to a given point with a given easy and callback
		public static function move(obj,point = null,easy = 0.5,callback = null)
		{
			if(getClass(obj) != Event)
			{
				if(!obj.hasEventListener('move'))
				{
					obj.pointMove = point;
					obj.easyMove = easy; 
					obj.callbackMove = callback;
					
					obj.addEventListener(Event.ENTER_FRAME,move);
				}
			}else{
						
				var mc = obj.target;
				
				mc.x += difFactor(mc.pointMove.x,mc.x,mc.easyMove);
				mc.y += difFactor(mc.pointMove.y,mc.y,mc.easyMove);
				
				if(dist(mc,mc.pointMove) <= 1)
				{
					mc.removeEventListener(Event.ENTER_FRAME,move);
					
					mc.x = mc.pointMove.x;
					mc.y = mc.pointMove.y;
					if(mc.callbackMove) mc.callbackMove();
				}
			}
		}
		
		public static function resize(obj,size = null,easy = 0.1,callback = null)
		{
			if(getClass(obj) != Event)
			{
				if(!obj.hasEventListener('resize'))
				{
					obj.resizeSize = size;
					obj.resizeEasy = easy; 
					obj.resizeCallback = callback;
					
					obj.addEventListener(Event.ENTER_FRAME,resize);
				}
			}else{
					
				var mc = obj.target;
				
				mc.width += difFactor(mc.resizeSize.x,mc.width,mc.resizeEasy);
				mc.height += difFactor(mc.resizeSize.y,mc.height,mc.resizeEasy);
				
				if(dist(mc.resizeSize,pAt(mc.width,mc.height)) <= 1)
				{
					mc.removeEventListener(Event.ENTER_FRAME,resize);
					
					mc.width = mc.resizeSize.x;
					mc.height = mc.resizeSize.y;
					if(mc.resizeCallback) mc.resizeCallback();
				}
			}
		}
		
			// template
		/*public static function <function>(obj,<arg>,..)
		{
			if(getClass(obj) != Event)
			{
				if(!obj.hasEventListener('<function>'))
				{
					obj.<parameters> = <arg>;
					..
					
					obj.addEventListener(Event.ENTER_FRAME,<function>);
				}
			}else{
						
				var mc = obj.target;
				
				code
			
				if(mc.<value> == mc.<trigger>)
				{
					mc.removeEventListener(Event.ENTER_FRAME,<function>);
					
					if(mc.callback) mc.callback();
				}
			}
		}*/
		
		
		
		
		// sound functions
		
		
			/*
			* returns timestamp of the sound computed
			* spectrum sound in a array 512 length with float
			* numbers from 0 to 2.0
			*/
		public static function readSpecStereo()
		{
			var spec = new Array();
				var bytes:ByteArray = new ByteArray();
					SoundMixer.computeSpectrum(bytes,true);
				for(var i=0; i<512; i++)
					spec.push(Math.abs(bytes.readFloat()));
			
			return spec;
		}
		
			// returns left input of given stereo spectrum
		public static function leftSpec(spec)
		{
			return spec.slice(0,256);
		}
		
			// returns right input of given stereo spectrum
		public static function rightSpec(spec)
		{
			return spec.slice(256,512);
		}
		
			/*
			* returns timestamp of the sound computed
			* spectrum sound in a array 256 length with float
			* numbers from 0 to 2.0
			*/
		public static function readSpecMono()
		{
			var spec = readSpecStereo();
					
			var mono = new Array();
			var left = leftSpec(spec);
			var right = rightSpec(spec);
			for(var i=0; i<256; i++)
				mono.push((left[i] + right[i])/2);
				
			return mono;
		}

	}
	
}
