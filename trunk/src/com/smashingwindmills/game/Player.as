package com.smashingwindmills.game
{
	import com.smashingwindmills.game.effects.BaseBloodGibs;
	import com.smashingwindmills.game.weapon.BaseWeapon;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite
	{
		[Embed(source="../media/player/player.png")]
		protected var playerSprite:Class;
		
  		protected var gibs:FlxEmitter;

		// can be moved into level 
		protected static const PLAYER_START_X:int = 300;
		protected static const PLAYER_START_Y:int = 300;
		
		protected static const PLAYER_RUN_SPEED:int = 100;
		protected static const GRAVITY_ACCELERATION:int = 420;
		protected static const JUMP_ACCELERATION:int = 200;

		// current player level
		protected var _level:int = 1;
			
		// number of XP point sto next level
		protected var _xpToNextLevel:int = 100;
		
		// flag for double jump
		protected var is_double_jump:Boolean = false;
		
		// reference to current weapon
		protected var _currentWeapon:BaseWeapon;
		
		// flags if the player is on a ladder
		protected var _onLadder:Boolean = false;
		
		// flags if the player is in water
		protected var _inWater:Boolean = false;
		
		public function Player()
		{
			super(0,0);
		
			loadGraphic(playerSprite,true,true);
			
			drag.x = PLAYER_RUN_SPEED * 8;
			
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 0], 12);
			addAnimation("jump", [4]);
			addAnimation("idle_up", [5]);
			addAnimation("run_up", [6, 7, 8, 5], 12);
			addAnimation("jump_up", [9]);
			addAnimation("jump_down", [10]);

 			this.gibs = FlxG.state.add(new BaseBloodGibs) as FlxEmitter; 
		}
		
		private function calculateLevelUp():int
		{
			var score:int = FlxG.score;
			var newLevel:int = 0;
			
			if (score >= 7000)
			{
				newLevel = 10;
				xpToNextLevel = 9999;
			}
			else if (score >= 5200)
			{
				newLevel = 9;
				xpToNextLevel = 7000;
			}
			else if (score >= 4000)
			{
				newLevel = 8;	
				xpToNextLevel = 5200;
			}
			else if (score >= 2900)
			{
				newLevel = 7; 	
				xpToNextLevel = 4000;
			}
			else if (score >= 1900)
			{
				newLevel = 6;
				xpToNextLevel = 2900;	
			}
			else if (score >= 1200)
			{
				newLevel = 5;
				xpToNextLevel = 1900;
			}  
			else if (score >= 750)
			{
				newLevel = 4; 
				xpToNextLevel = 1200;
			}
			else if (score >= 300)
			{
				newLevel = 3;
				xpToNextLevel = 750;
			}
			else if (score >= 100)
			{
				newLevel = 2;
				xpToNextLevel = 300;
			}
			return newLevel;
		}
		
		override public function update():void
		{
			if (FlxG.score >= xpToNextLevel)
			{
				level = calculateLevelUp();
			}

			// if current weapon can charge, init charge timer			
			if (FlxG.keys.C && currentWeapon.canCharge())
			{
				var chargeValue:Number = 0;
				if (FlxG.keys.justPressed("C"))
				{
					chargeValue = 0;
				}
				else
				{
					chargeValue = FlxG.elapsed;
				}	
				currentWeapon.charge(chargeValue);			
			}
			
			if (FlxG.keys.justReleased("C"))
			{
				currentWeapon.shoot(this);
			}
			
			acceleration.x = 0;
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x = -drag.x;
			}
			else if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				acceleration.x = drag.x;				
			}
			
			if (onLadder)
			{
				acceleration.y = 0;
				play("idle");
				
				if (FlxG.keys.UP)
				{
					velocity.y -= 40;
					
				}
				else if (FlxG.keys.DOWN)
				{
					velocity.y = 40;
				}
				else
				{
					velocity.y = 0;
				}
			}
			else if (inWater)
			{
				acceleration.y = 0;
				// add some drag here.
			}
			else
			{
				acceleration.y = GRAVITY_ACCELERATION;

				if (FlxG.keys.justPressed("X") && !velocity.y)
				{
					velocity.y = -JUMP_ACCELERATION;
				}
				else if (FlxG.keys.justPressed("X") && velocity.y)
				{
					if (!is_double_jump)
					{
						velocity.y = -JUMP_ACCELERATION;
						is_double_jump = true;	
					}
				}
				
				if (velocity.y != 0)
				{
					play("jump");
				}
				else if (velocity.x == 0) // will reset if player hits cealing now..
				{
					is_double_jump = false;
					play("idle");
				}
				else
				{
					is_double_jump = false;
					play("run");
				}
			}
			
			onLadder = false;
			
			if (y >= 640)
				kill();
				
			super.update();
		}
		
		/**
		 * Get weapon damage calculated (charge bonus etc)
		 */
		public function calculateWeaponDamage():Number
		{
			return currentWeapon.calculateDamange();
		}
		
		/**
		 * kills the player and plays a quake effect
		 */
		override public function kill():void
		{
			FlxG.quake(0.05,2);
			this.gibs.x = this.x + (this.width>>1);
			this.gibs.y = this.y + (this.height>>1);
			this.gibs.restart();
			super.kill();
		}
		
		public function get currentWeapon():BaseWeapon
		{
			return _currentWeapon;
		}
		
		public function set currentWeapon(value:BaseWeapon):void
		{
			_currentWeapon = value;
		}
		
		public function get level():int
		{
			return _level;	
		}
		
		public function set level(value:int):void
		{
			_level = value;
		}
		
		public function get xpToNextLevel():int
		{
			return _xpToNextLevel;
		}
		
		public function set xpToNextLevel(value:int):void
		{
			_xpToNextLevel = value;
		}
		
		public function get onLadder():Boolean
		{
			return _onLadder;
		}
		
		public function set onLadder(value:Boolean):void
		{
			_onLadder = value;
		}
		
		public function get inWater():Boolean
		{
			return _inWater;
		}
		
		public function set inWater(value:Boolean):void
		{
			_inWater = value;
		}
	}
}