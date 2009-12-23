package com.smashingwindmills.game.effects
{
	import org.flixel.FlxEmitter;
	
	public class BaseBloodGibs extends FlxEmitter
	{
		[Embed(source="../media/temp/enemygibs.png")]
		protected var EnemyGibsImage:Class;
		public function BaseBloodGibs()
		{
			createSprites(EnemyGibsImage);
  			x = 0;
  			y = 0;
  			delay = -1.5;
  			width = 0;
  			minVelocity.y = -250;
  			maxVelocity.x = 250;
  			minRotation = -200;
  			maxRotation = 200;
  			gravity = 720;
  			drag = 200;
		}

	}
}