package com.smashingwindmills.game.weapon
{
	import flash.geom.Point;
	
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class BaseWeapon extends FlxSprite
	{
		protected var _damageType:String;
		
		/**
		 * Base damage for weapon
		 */
		protected var _baseDamage:int;
		
		protected var _baseVelocity:Point = new Point(100,0);
		
		protected var _bullets:Array = new Array();
		
		protected var _currentBullet:uint = 0;
		
		protected var _bulletCount:int;
		
		protected var _range:Point = new Point(150,150);

		protected var _bulletType:Class;
		
		public function BaseWeapon(numOfBullets:int = 8)
		{
			bulletCount = numOfBullets;
			bullets = new Array();
		}
		
		public function buildBullets(state:FlxState):void
		{
			for (var i:int = 0; i < bulletCount; i++)
			{
				var bullet:BaseBullet = new bulletType();
				
				bullets.push(state.add(bullet));
			}
		}
		
		public function shoot(equipper:FlxSprite):void
		{
			var bXVel:int = 0;
			var bYVel:int = 0;
			var bX:int = equipper.x;
			var bY:int = equipper.y;

			
			if (equipper.facing == RIGHT)
			{
				bX += equipper.width -4;
				bXVel = baseVelocity.x;
				bYVel = baseVelocity.y;
			}
			else
			{
				bX -= bullets[_currentBullet].width -4;
				bXVel = -baseVelocity.x;
				bYVel = baseVelocity.y;
			}
				
			bullets[_currentBullet].shoot(bX,bY,bXVel,bYVel,range);
			++_currentBullet;
			_currentBullet %= bullets.length;	
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
		
		public function get bulletCount():int
		{
			return _bulletCount;
		}
		
		public function set bulletCount(value:int):void
		{
			_bulletCount = value;	
		}
		
		public function get range():Point
		{
			return _range;	
		}
		
		public function set range(value:Point):void
		{
			_range = value;
		}
		
		public function get bulletType():Class
		{
			return _bulletType;
		}
		
		public function set bulletType(value:Class):void
		{
			_bulletType = value;
		}
	}
}