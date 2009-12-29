package com.smashingwindmills.maps
{
	import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	
	public class BaseMap
	{
		protected var _layers:Array = new Array();
		
		protected var _mainLayerIndex:int;
		
		public var boundsMinX:int = 0;
		public var boundsMinY:int = 0;
		public var boundsMaxX:int = 8192;
		public var boundsMaxY:int = 1120;

		public function BaseMap()
		{
			
		}
		
		public function initialize():void
		{
			for (var i:int = 0; i < layers.length; i++)
			{
				FlxG.state.add(layers[i]);	
			}
			trace("added " + layers.length + " layers");
		}

		
		public function get layers():Array
		{
			return _layers;
		}
		
		public function set layers(value:Array):void
		{
			_layers = value;
		}
		
		
		public function get mainLayer():FlxTilemap
		{
			return layers[_mainLayerIndex];
		}
		
		public function set mainLayerIndex(value:int):void
		{
			_mainLayerIndex = value;
		}

	}
}