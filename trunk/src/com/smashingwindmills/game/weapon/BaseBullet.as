package com.smashingwindmills.game.weapon
{
	import flash.geom.Point;
	
	import org.flixel.FlxCore;
	import org.flixel.FlxSprite;
	
	public class BaseBullet extends FlxSprite
	{
		/**
		 * Start position of the bullet
		 */
		protected var _startPosition:Point;
		
		/**
		 * Range the bullet can travel
		 */
		protected var _range:Point;
		
		/**
		 * Damage value this bullet instance will do
		 */
		protected var _damage:int;
		
		public function BaseBullet()
		{
			super(0,0);
			exists = false;
			startPosition = new Point(0,0);
		}
		
		override public function update():void
		{
			// if range, check for range
			if (range)
			{
				var deltaX:int = startPosition.x - x;
				var deltaY:int = startPosition.y -y;
				
				if (deltaX > range.x || deltaX < -range.x || deltaX > range.y || deltaY < -range.y)
				{
					dead = true;
					finished = true;
				}
			}

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
		
		public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int,r:Point = null,charge:Number = 0):void
		{
			super.reset(X,Y);
			if (range)
				range = r
				
			startPosition.x = X;
			startPosition.y = Y;
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
		
		public function get startPosition():Point
		{
			return _startPosition;
		}
		
		public function set startPosition(value:Point):void
		{
			_startPosition = value;
		}
		
		public function get range():Point
		{
			return _range;
		}
		
		public function set range(value:Point):void
		{
			_range = value;
		}
		
		public function get damage():int
		{
			return _damage;
		}
		
		public function set damage(value:int):void
		{
			_damage = value;
		}
	}
}