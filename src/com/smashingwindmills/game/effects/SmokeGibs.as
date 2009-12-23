package com.smashingwindmills.game.effects
{
	import org.flixel.FlxEmitter;
	
	public class SmokeGibs extends FlxEmitter
	{
		[Embed(source="../media/temp/smoke_gibs.png")]
		protected var EnemyGibsImage:Class;
		public function SmokeGibs()
		{
			createSprites(EnemyGibsImage);
  			x = 0;
  			y = 0;
  			delay = -2.5;
  			width = 0;
  			minVelocity.y = -250;
  			maxVelocity.x = 250;
  			minRotation = -200;
  			maxRotation = 200;
  			gravity = -520;
  			drag = 200;
		}
	}
}