package com.smashingwindmills.game
{
	import com.smashingwindmills.game.effects.BaseBloodGibs;
	import com.smashingwindmills.game.items.BaseItem;
	import com.smashingwindmills.game.weapon.BaseWeapon;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite
	{
		[Embed(source="../media/player/player.png")]
		protected var playerSprite:Class;
		
		/**
		 * Gibs emitted when player dies
		 */
  		protected var gibs:FlxEmitter;

		protected var PLAYER_RUN_SPEED:int;
		protected var GRAVITY_ACCELERATION:int;
		protected var JUMP_ACCELERATION:int;

		/**
		 * current player level
		 */
		protected var _level:int = 1;
			
		/**
		 * number of XP points next level
		 */
		protected var _xpToNextLevel:int = 100;
		
		/**
		 *  flag for double jump
		 */
		protected var is_double_jump:Boolean = false;
		
		/** 
		 * reference to current weapon
		 */
		protected var _currentWeaponIndex:int;
		
		/**
		 * flags if the player is on a ladder
		 */
		protected var _onLadder:Boolean = false;
		
		/**
		 *  flags if the player is in water
		 */
		protected var _inWater:Boolean = false;
		
		/**
		 * Array of available weapons
		 */
		protected var _weapons:Array = new Array();
		
		/**
		 * Number of available skillpoints
		 */
		protected var _availableSkillPoints:int = 0;
		
		
		// some temp skill counters
		private var skillJump:int = 0;
		private var skillShoot:int = 0;
		private var skillIdle:Number = 0;
		public function Player()
		{
			super(0,0);
		
			loadGraphic(playerSprite,true,true);
			
			PLAYER_RUN_SPEED = 80;
			GRAVITY_ACCELERATION = 420;
			JUMP_ACCELERATION = 200;
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
				
			// TODO :move this out to some kind of helper class
			var levels:Array = new Array();
			levels.push(0);
			levels.push(300);
			levels.push(750);
			levels.push(1200);
			levels.push(1900);
			levels.push(4000);
			levels.push(5200);
			levels.push(700);
			
			// start checking on current level, as we never go downwards
			for (var i:int = level; i < levels.length; i++)
			{
				// TODO: make sure we dont get above max levels
				if (score >= levels[i] && score < levels[i+1])
				{
					newLevel = i+1;
					xpToNextLevel = levels[i+1];
					break;
				}
			}
				
			// make sure we get one skill point per level
			availableSkillPoints += newLevel - level;
						
			return newLevel;
		}
		
		override public function update():void
		{
						checkSkillLevelUp();
						
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
				skillShoot++;
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
					skillJump++;
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
				else if (velocity.x == 0) // will reset if player hits ceeling now..
				{
					is_double_jump = false;
					skillIdle += FlxG.elapsed;
					play("idle");
				}
				else
				{
					is_double_jump = false;
					play("run");
				}
			}
			
			onLadder = false;

		// TODO: implement dying if the player is below the level itself.
		
		//	if (y >= 640)
		//		kill();
				
			super.update();

		}
		
		private function checkSkillLevelUp():void
		{
			// TODO: separate into some sort of usabe addons / decorators that can upgrade the needed parts
			// look at normal levelups. this will always reset ammo for the selected weapon.
			if (skillJump > 10)
			{
				JUMP_ACCELERATION = 250;
				maxVelocity.y = JUMP_ACCELERATION;
			}
			if (skillIdle > 10)
			{
				maxVelocity.x = PLAYER_RUN_SPEED;
				PLAYER_RUN_SPEED = 150;
			}
			if (skillShoot > 10)
			{
				// problem if setting maxammo to higher than ammo?
				currentWeapon.maxAmmo = 100;
				//currentWeapon.ammo = 100;
				
			}
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
		
		
		override public function hurt(Damage:Number):void
		{
			super.hurt(Damage);
			
			// TODO: make fade work.
			//FlxG.fade(0xFFFF00FF,1);
		}
		
		public function aquireLoot(item:BaseItem):void
		{
			// not used, see same method in BaseItem
		}
		
		public function get currentWeapon():BaseWeapon
		{
			return weapons[_currentWeaponIndex];
		}
		
		public function get currentWeaponIndex():int
		{
			return _currentWeaponIndex;	
		}
		public function set currentWeaponIndex(index:int):void
		{
			_currentWeaponIndex = index;
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
		
		public function get weapons():Array
		{
			return _weapons;
		}
		
		public function set weapons(value:Array):void
		{
			_weapons = value;
		}
		
		public function get availableSkillPoints():int
		{
			return _availableSkillPoints;
		}
		
		public function set availableSkillPoints(value:int):void
		{
			_availableSkillPoints = value;
		}
	}
}