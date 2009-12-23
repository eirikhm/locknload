package com.smashingwindmills.game.enemy
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class BaseEnemy extends FlxSprite
	{
  
  		protected var GRAVITY_ACCELERATION:int = 420;

		protected var startingX:int;


		protected var level:int = 1;
		protected var xpValue:int = 10;

		public function BaseEnemy(X:int, Y:int)
		{
			super(0,0);
			y = Y;
			x = X;
			acceleration.y = GRAVITY_ACCELERATION;
		}
		
		
		// child will do all movement. this just adjusts facing
		override public function update():void
		{
			if (this.velocity.x > 0)
			{
				facing = RIGHT;
			}
			else if (this.velocity.x < 0)
			{
				facing = LEFT;
			}
	
			super.update();
		}
		
		
		// child will invoke emitters etc. just update XP and kill off enemy
		override public function kill():void
		{
			FlxG.score += xpValue;
			super.kill();
		}
	}
}