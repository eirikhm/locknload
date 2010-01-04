package com.smashingwindmills.ui
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;
	
	public class ProgressMeter 
	{
		protected var _backgroundColor:uint = 0xFFAAAA;
		
		protected var _foregroundColor:uint = 0x000000;
		
		protected var _borderColor:uint = 0xFF0000;
		
		protected var _currentValue:Number = 0;
		
		
		public var width:int = 50;
		public var height:int = 50;
		
		public var x:int;
		public var y:int;
		
		
		private var _holder:FlxSprite;
		private var _bg:FlxSprite;
		private var _fg:FlxSprite;
		
		public function ProgressMeter(X:int, Y:int, W:int,H:int)
		{
			x = X;
			y = Y;
			width = W;
			height = H;
		}
		
		public function draw(layer:FlxLayer):void
		{
			
			_holder = new FlxSprite(x,y);
			_holder.createGraphic(width,height,borderColor);
			_holder.scrollFactor = new Point(0,0);
			layer.add(_holder);
			
			_bg = new FlxSprite(x+1,y+1);
			_bg.createGraphic(width-2,height-2,backgroundColor);
			_bg.scrollFactor = new Point(0,0);
			layer.add(_bg);
			
			_fg = new FlxSprite(x+1,y+1);
			_fg.createGraphic(width-2,height-2,foregroundColor);
			_fg.scrollFactor = new Point(0,0);
			layer.add(_fg);
		
		}
		public function get currentValue():Number
		{
			return _currentValue;
		}
		
		// % of bar size
		public function set currentValue(value:Number):void
		{
			_currentValue = value;
			var scale:int = (height-2)/100*value;
			if (scale > 0)
				_fg.createGraphic(width-2,scale,foregroundColor);

		}
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		
		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
		}
		
		public function get foregroundColor():uint
		{
			return _foregroundColor;
		}
		
		public function set foregroundColor(value:uint):void
		{
			_foregroundColor = value;
		}
		
		public function get borderColor():uint
		{
			return _borderColor;
		}
		
		public function set borderColor(value:uint):void
		{
			_borderColor = value;
		}

	}
}