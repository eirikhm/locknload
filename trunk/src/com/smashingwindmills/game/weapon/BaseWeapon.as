package com.smashingwindmills.game.weapon
{
	import com.smashingwindmills.game.Player;
	
	import flash.geom.Point;
	
	import org.flixel.FlxSprite;
	
	public class BaseWeapon extends FlxSprite
	{
		protected var _damageType:String;
		
		protected var _baseDamage:int;
		
		protected var _baseVelocity:Point = new Point(100,0);
		
		protected var _bullets:Array = new Array();
		
		protected var currentBullet:uint = 0;

		public function BaseWeapon()
		{
			
		}		
		
		public function shoot(player:Player):void
		{
			var bXVel:int = 0;
			var bYVel:int = 0;
			var bX:int = player.x;
			var bY:int = player.y;

			if (player.facing == RIGHT)
			{
				bX += player.width -4;
				bXVel = baseVelocity.x;
				bYVel = baseVelocity.y;
			}
			else
			{
				bX -= bullets[currentBullet].width -4;
				bXVel = -baseVelocity.x;
				bYVel = baseVelocity.y;
			}
				
			bullets[currentBullet].shoot(bX,bY,bXVel,bYVel);
			++currentBullet;
			currentBullet %= bullets.length;	
		}
		
		public function get baseDamage():int
		{
			return _baseDamage;
		}
		
		public function set baseDamage(value:int):void
		{
			_baseDamage = value;
		}
		
		public function get baseVelocity():Point
		{
			return _baseVelocity;
		}
		
		public function set baseVelocity(value:Point):void
		{
			_baseVelocity = value;
		}
		
		public function get bullets():Array
		{
			return _bullets;
		}
		
		public function set bullets(value:Array):void
		{
			_bullets = value;
		}
	}
}