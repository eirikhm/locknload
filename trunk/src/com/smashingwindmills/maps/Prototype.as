package com.smashingwindmills.maps
{
	import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	
	public class Prototype extends BaseMap
	{
		[Embed(source="../media/levels/prototype/prototypeBackground.txt", mimeType="application/octet-stream")]
		public var mapDataBg:Class;
		
		[Embed(source="../media/levels/prototype/prototypeMain.txt", mimeType="application/octet-stream")]
		public var mapDataMain:Class;

		[Embed(source="../media/levels/prototype/prototypeForeground.txt", mimeType="application/octet-stream")]
		public var mapDataFg:Class;
		
		[Embed(source="../media/levels/prototype/HomeBase.png")]
		public var mapTiles:Class;


		private var layerBg:FlxTilemap;
		private var layerMain:FlxTilemap;
		private var layerFg:FlxTilemap;
		
		public function Prototype()
		{
			
			layerBg = new FlxTilemap();
			layerBg.loadMap(new mapDataBg, mapTiles,32,32);
			layerBg.x = 0;
			layerBg.y = 0;
			layerBg.scrollFactor.x = 0.600000;
			layerBg.scrollFactor.y = 1.000000;
			
			layerMain = new FlxTilemap();
			layerMain.loadMap(new mapDataMain, mapTiles,32,32);
			layerMain.x = 0;
			layerMain.y = 0;
			layerMain.scrollFactor.x = 1.000000;
			layerMain.scrollFactor.y = 1.000000;
			
			layerFg = new FlxTilemap();
			layerFg.loadMap(new mapDataFg, mapTiles,32,32);
			layerFg.x = 0;
			layerFg.y = 0;
			layerFg.scrollFactor.x = 1.000000;
			layerFg.scrollFactor.y = 1.000000;
			
			layers.push(layerBg);
			layers.push(layerMain);
			layers.push(layerFg);
			
			_mainLayerIndex = layers.indexOf(layerMain);
		}
	}
}