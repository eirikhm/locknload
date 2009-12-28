package com.smashingwindmills.states.layers
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class LevelUpLayer extends FlxLayer
	{
		private var textMain:FlxText;

		[Embed (source = "../media/temp/level_up.png")]
		protected var backgroundImage:Class;
		
		public function LevelUpLayer()
		{
			super();
			var bg:FlxSprite = new FlxSprite(0,0);
			bg.loadGraphic(backgroundImage);
			bg.y = 240;
			add(bg);
			
			textMain = new FlxText(300, 20, 200, "This is a test: ");
	    	textMain.setFormat(null, 16, 0x0FFF15, "right");
            textMain.scrollFactor = new Point(0, 0);
		          		
            add(textMain);
		}
	}
}