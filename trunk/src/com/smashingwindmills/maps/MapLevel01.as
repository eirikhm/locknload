//Code generated by Flan. http://www.tbam.com.ar/utility--flan.php

package com.smashingwindmills.maps {
	import com.smashingwindmills.game.Enemy;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	public class MapLevel01 extends MapBase {
		//Media content declarations
		[Embed(source="../../../../media/maps/MapCSV_Level01_NewLayer.txt", mimeType="application/octet-stream")] public var CSV_NewLayer:Class;
		[Embed(source="../../../../media/maps/tiles.png")] public var Img_NewLayer:Class;
		[Embed(source="../../../../media/maps/MapCSV_Level01_Fg.txt", mimeType="application/octet-stream")] public var CSV_Fg:Class;
		[Embed(source="../../../../media/maps/tiles.png")] public var Img_Fg:Class;
		[Embed(source="../../../../media/maps/MapCSV_Level01_Bg.txt", mimeType="application/octet-stream")] public var CSV_Bg:Class;
		[Embed(source="../../../../media/maps/tiles_bg.png")] public var Img_Bg:Class;
		
		public function MapLevel01() {

			_setCustomValues();

			bgColor = 0xffda0205;

			layerNewLayer = new FlxTilemap();
			layerNewLayer.loadMap(new CSV_NewLayer, Img_NewLayer);
			layerNewLayer.collideIndex = 3;
			layerNewLayer.drawIndex = 1;
			layerNewLayer.x = 0;
			layerNewLayer.y = 0;
			layerNewLayer.scrollFactor.x = 1.000000;
			layerNewLayer.scrollFactor.y = 1.000000;
			
			layerFg = new FlxTilemap();
			layerFg.loadMap(new CSV_Fg, Img_Fg);
			layerFg.collideIndex = 3;
			layerFg.drawIndex = 1;
			layerFg.x = 0;
			layerFg.y = 0;
			layerFg.scrollFactor.x = 1.000000;
			layerFg.scrollFactor.y = 1.000000;
			
			layerBg = new FlxTilemap();
			layerBg.loadMap(new CSV_Bg, Img_Bg);
			layerBg.collideIndex = 1;
			layerBg.drawIndex = 1;
			layerBg.x = 0;
			layerBg.y = 0;
			layerBg.scrollFactor.x = 0.500000;
			layerBg.scrollFactor.y = 0.500000;

			allLayers = [ layerNewLayer, layerFg, layerBg ];

			mainLayer = layerFg;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 2560;
			boundsMaxY = 1280;
		}

		override public function addSpritesToLayerNewLayer(onAddCallback:Function = null):void {
			var obj:FlxSprite;
			
			obj = new Enemy(496, 251);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(208, 347);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(431, 354);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(1052, 218);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(1116, 198);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(743, 573);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(272, 228);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(318, 256);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(220, 224);
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
		}

		override public function addSpritesToLayerFg(onAddCallback:Function = null):void {
			var obj:FlxSprite;
			
			obj = new Enemy(94, 260);;
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(61, 253);;
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
			obj = new Enemy(29, 254);;
			obj.x+=obj.offset.x;
			obj.y+=obj.offset.y;
			FlxG.state.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj);
		}

		override public function customFunction(param:* = null):* {

		}

		private function _setCustomValues():void {
		}
	}
}
