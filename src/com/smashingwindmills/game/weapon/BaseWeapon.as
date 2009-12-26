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
		
		/**
		 * Base velocity for bullets
		 */
		protected var _baseVelocity:Point = new Point(100,0);
		
		/**
		 * Array of bullets
		 */
		protected var _bullets:Array = new Array();
		
		/**
		 * Keep track of current bullet
		 */
		protected var _currentBullet:uint = 0;
		
		/**
		 * Number of bullets to create
		 */
		protected var _bulletCount:int;
		
		/**
		 * Fire Range
		 * TODO: Create rectangle here
		 */
		protected var _range:Point = new Point(150,150);

		/**
		 * Type of bullets to use for this weapon
		 */
		protected var _bulletType:Class;
		
		/**
		 *  min number of seconds a weapon can charge
		 */
		protected var _minChargeTime:Number = 0;
		
		/**
		 * max number of seconds a weapon can charge
		 */
		protected var _maxChargeTime:Number = 0;
		
		/**
		 * keeps track of how long the weapon has charged (if weapon suppors charge)
		 */
		protected var _chargeTime:Number = 0;
		
		public function BaseWeapon(numOfBullets:int = 8)
		{
			bulletCount = numOfBullets;
			bullets = new Array();
		}
		
		/**
		 * Build array of bullets and add them to the state
		 */
		public function buildBullets(state:FlxState):void
		{
			for (var i:int = 0; i < bulletCount; i++)
			{
				var bullet:BaseBullet = new bulletType();
				bullets.push(state.add(bullet));
			}
		}
		
		/**
		 *  override to give visual feedback on charge
		 */
		public function charge(value:Number):void
		{
			chargeTime += value;
			trace("charginf: " + chargeTime);
		}
		
		/**
		 * Fire the weapon
		 */
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
			
			
		trace("bullet fired with charge :" + chargeTime);
		
			// this will be reset when bullet hits target, so might need to store damage in bullet?
			//
			chargeTime = 0;
				
		}
		
		/**
		 * Determine if this weapon can be charged
		 */
		public function canCharge():Boolean
		{
			if (minChargeTime > 0)
				return true;
			return false;
		}
		
		public function calculateDamange():Number
		{
			return baseDamage;
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
		
		public function get minChargeTime():Number
		{
			return _minChargeTime;
		}
		
		public function set minChargeTime(value:Number):void
		{
			_minChargeTime = value;
		}
		
		public function get maxChargeTime():Number
		{
			return _maxChargeTime;
		}
		
		public function set maxChargeTime(value:Number):void
		{
			_maxChargeTime = value;
		}
	
		public function get chargeTime():Number
		{
			return _chargeTime;
		}
		public function set chargeTime(value:Number):void
		{
			_chargeTime = value;
		}
	}
}