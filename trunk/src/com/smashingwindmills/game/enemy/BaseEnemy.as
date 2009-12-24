package com.smashingwindmills.game.enemy
{
	import com.smashingwindmills.game.Player;
	import com.smashingwindmills.game.weapon.BaseWeapon;
	
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class BaseEnemy extends FlxSprite
	{
  		protected var GRAVITY_ACCELERATION:int = 420;

		protected var startingX:int;

		protected var _level:int = 1;
		protected var _xpValue:int = 10;
		protected var _player:Player;
		protected var _state:FlxState;
		protected var _weapon:BaseWeapon = null;
		protected var _detectRange:Point = new Point(150,50);


		public function BaseEnemy(X:int, Y:int, p:Player = null,s:FlxState = null)
		{
			super(0,0);
			y = Y;
			x = X;
			acceleration.y = GRAVITY_ACCELERATION;
			player = p;
			state = s;
		}
		
		public function initialize():void
		{
			
		}
		
		public function get state():FlxState
		{
			return _state;
		}
		
		public function set state(value:FlxState):void
		{
			_state = value;
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
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			_level = value;
		}
		
		public function get xpValue():int
		{
			return _xpValue;	
		}
		
		public function set xpValue(value:int):void
		{
			_xpValue = value;
		}
		
		public function get player():Player
		{
			return _player;
		}
		
		public function set player(value:Player):void
		{
			_player = value;
		}
		
		public function get weapon():BaseWeapon
		{
			return _weapon;
		}
		
		public function set weapon(value:BaseWeapon):void
		{
			_weapon = value;
		}
		
		public function get detectRange():Point
		{
			return _detectRange;
		}
		
		public function set detectRange(value:Point):void
		{
			_detectRange = value;
		}
	}
}