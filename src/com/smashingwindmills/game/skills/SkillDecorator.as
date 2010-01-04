package com.smashingwindmills.game.skills
{
	import com.smashingwindmills.game.Player;
	
	import flash.geom.Point;
	
	public class SkillDecorator
	{
		protected var _player:Player;
		
		protected var _playerHealth:Number;
		protected var _playerRunSpeed:Number;
		protected var _playerJumpVelocity:Number;
		protected var _playerRegenRate:Number;
		
		protected var _weaponDamage:Number;
		protected var _weaponVelocity:Point;
		protected var _weaponFireRate:Number;
		protected var _weaponAmmoRegen:Number;
		protected var _weaponMaxAmmo:int;
		
		/**
		 * Use this to target a given weapon class. If null, it will be avilable
		 */
		protected var weaponClass:Class;		
		
		/**
		 * use this to set up bonuses for given weapons
		 */ 
		 
		protected var weaponDecorators:Array;
		

		protected var weaponType:*;
		
		public var requirementCounter:int = 0;
		
		public function SkillDecorator()
		{
			
		}
		
		
		public function get player():Player
		{
			return _player;
		}
		
		public function set player(value:Player):void
		{
			_player = value;
		}
		
		public function get playerHealth():Number
		{
			return _playerHealth;
		}
		
		public function set playerHealth(value:Number):void
		{
			_playerHealth = value;
		}
		
		public function get playerRunSpeed():Number
		{
			return _playerRunSpeed;
		}
		
		public function set playerRunSpeed(value:Number):void
		{
			_playerRunSpeed = value;
		}
		
		public function get playerJumpVelocity():Number
		{
			return _playerJumpVelocity;
		}
		
		public function set playerJumpVelocity(value:Number):void
		{
			_playerJumpVelocity = value;
		}
		
		public function get playerRegenRate():Number
		{
			return _playerRegenRate;
		}
		
		public function set playerRegenRate(value:Number):void
		{
			_playerRegenRate = value;
		}
		
		public function get weaponDamage():Number
		{
			return _weaponDamage;
		}
		
		public function set weaponDamage(value:Number):void
		{
			_weaponDamage = value;
		}
		
		public function get weaponVelocity():Point
		{
			return _weaponVelocity;
		}
		
		public function set weaponVelocity(value:Point):void
		{
			_weaponVelocity = value;
		}
		
		public function get weaponFireRate():Number
		{
			return _weaponFireRate;
		}
		
		public function set weaponFireRate(value:Number):void
		{
			_weaponFireRate = value;
		}
		
		public function get weaponAmmoRegen():Number
		{
			return _weaponAmmoRegen;
		}
		
		public function set weaponAmmoRegen(value:Number):void
		{
			_weaponAmmoRegen = value;
		}
		
		public function get weaponMaxAmmo():int
		{
			return _weaponMaxAmmo;
		}
		
		public function set weaponMaxAmmo(value:int):void
		{
			_weaponMaxAmmo = value;
		}

	}
}