package com.smashingwindmills.game.weapon
{
	import org.flixel.FlxCore;
	import org.flixel.FlxSprite;
	
	public class BaseBullet extends FlxSprite
	{
		
		public function BaseBullet()
		{
			super(0,0);
			
			exists = false;
			

		}
		
		override public function update():void
		{
			if (dead && finished)
				exists = false;
			else
			{				
				super.update();
			}
		}
		
		override public function hitWall(Contact:FlxCore=null):Boolean { hurt(0); return true; }
		override public function hitFloor(Contact:FlxCore=null):Boolean { hurt(0); return true; }
		override public function hitCeiling(Contact:FlxCore=null):Boolean { hurt(0); return true; }
	
		override public function hurt(Damage:Number):void
		{
			if (dead)
			{
				return;
			}
			velocity.x = 0;
			velocity.y = 0;
			dead = true;
			play("poof");
		}
		
		public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):void
		{
			super.reset(X,Y);
			velocity.x = VelocityX;
			velocity.y = VelocityY;
			
			if (velocity.y < 0)
			{
				play("down");
			}
			else if (velocity.x < 0)
			{
				play("right");
			}
		}
	}
}