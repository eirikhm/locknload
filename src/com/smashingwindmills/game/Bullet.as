package com.smashingwindmills.game
{
	import org.flixel.FlxCore;
	import org.flixel.FlxSprite;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source="../media/temp/bullet.png")]
		protected var imgBullet:Class;
		
		public function Bullet()
		{
			super(0,0);
			loadGraphic(imgBullet,true);
			
			exists = false;
			
			addAnimation("up",[0]);
			addAnimation("down",[1]);
			addAnimation("left",[2]);
			addAnimation("right",[3]);
			addAnimation("poof",[4,5,6,7], 50, false);
		}
		
		override public function update():void
		{
			if (dead && finished)
				exists = false;
			else
				super.update();
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