package com.smashingwindmills.game
{
	import org.flixel.FlxSprite;
	
	public class Ladder extends FlxSprite
	{
		[Embed(source="../media/temp/ladder.png")]
		protected var img:Class;
		public function Ladder(X:int, Y:int)
		{
			super(X,Y);
			loadGraphic(img,true);
			addAnimation("idle",[0]);
			play("idle");	
		}

	}
}