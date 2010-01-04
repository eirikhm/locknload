package com.smashingwindmills.game
{
	import com.smashingwindmills.game.effects.BaseBloodGibs;
	import com.smashingwindmills.game.items.BaseItem;
	import com.smashingwindmills.game.skills.Skill;
	import com.smashingwindmills.game.skills.SkillDecorator;
	import com.smashingwindmills.game.weapon.BaseWeapon;
	import com.smashingwindmills.states.GameState;
	
	import org.flixel.FlxCore;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite
	{
		[Embed(source="../media/player/player.png")]
		protected var playerSprite:Class;
		
		[Embed(source="../media/temp/audio/jump.mp3")] 
		protected var SndJump:Class;
		
		[Embed(source="../media/temp/audio/land.mp3")] 
		protected var SndLand:Class;
		
		
		[Embed(source="../media/temp/audio/pickup.mp3")] 
		protected var SndSkillUp:Class;
		
		
		
		/**
		 * Gibs emitted when player dies
		 */
  		protected var gibs:FlxEmitter;

		protected var GRAVITY_ACCELERATION:int;

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
		
		protected var _skills:Array;
		
		protected var _usageSkills:Array;
		
		// some temp skill counters
		public var skillJump:int = 0;
		public var skillShoot:int = 0;
		public var skillIdle:Number = 0;
		public var skillRun:Number = 0;

		public var skillJumpNext:int = 10;
		public var skillShootNext:int = 10;
		public var skillIdleNext:Number = 10;
		public var skillRunNext:Number = 10;
		
		
		
		
		// can be moved to a helper class, since these only hold initial values
		public var baseMaxHealth:int = 100;
		public var baseRunSpeed:int = 80;
		public var baseJumpAcceleration:int = 200;
		public var baseHealthRegenRate:int = 5;
		public var baseAmmoRegenRate:int = 5;


		public var currentMaxHealth:int;
		public var currentRunSpeed:int;
		public var currentJumpAcceleration:int;
		public var currentHealthRegenRate:int;
		public var currentAmmoRegenRate:int;
		
		
		private var _ammoRegenCounter:Number = 0;
		private var _healthRegenCounter:Number = 0;

		
		public function Player()
		{
			super(0,0);
		
			skills = PlayerHelper.buildSkills();
			_usageSkills = PlayerHelper.buildUsageSkills();
			currentJumpAcceleration = baseJumpAcceleration;
			currentMaxHealth = baseMaxHealth;
			currentHealthRegenRate = baseHealthRegenRate;
			currentAmmoRegenRate = baseAmmoRegenRate;
			currentRunSpeed = baseRunSpeed;
			
			
			loadGraphic(playerSprite,true,true);
			
			GRAVITY_ACCELERATION = 420;
			drag.x = currentRunSpeed * 8;
			
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = currentRunSpeed;
			maxVelocity.y = currentJumpAcceleration;
			
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
				
			var levels:Array = PlayerHelper.LEVELS;
			
			// start checking on current level, as we never go downwards
			for (var i:int = level; i < levels.length; i++)
			{
				// TODO: make sure we dont get above max levels
				if (score >= levels[i] && score < levels[i+1])
				{
					newLevel = i+1;
					xpToNextLevel = levels[i+1];
					FlxG.play(SndSkillUp);
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
			
			if (maxVelocity.y != currentJumpAcceleration)
				maxVelocity.y = currentJumpAcceleration;

			if (maxVelocity.x != currentRunSpeed)
				maxVelocity.x = currentRunSpeed;


						
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
					velocity.y = -currentJumpAcceleration;
					FlxG.play(SndJump);
				}
				else if (FlxG.keys.justPressed("X") && velocity.y)
				{
					if (!is_double_jump)
					{
						velocity.y = -currentJumpAcceleration;
						is_double_jump = true;	
						FlxG.play(SndJump);
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
					skillRun += FlxG.elapsed;
				}
			}
			
			onLadder = false;

		// TODO: implement dying if the player is below the level itself.
		
		//	if (y >= 640)
		//		kill();
				
				
			
			if (_healthRegenCounter >= currentHealthRegenRate)
			{
				health++;
				// this logic should be handled by get/set pair
				if (health > currentMaxHealth)
					health = currentMaxHealth;
				_healthRegenCounter = 0;
			}
			else
			{
				_healthRegenCounter += FlxG.elapsed;
			}
			
			if (_ammoRegenCounter >= currentAmmoRegenRate)
			{
				currentWeapon.ammo++;
				// this logic should be handled by get/set pair
				if (currentWeapon.ammo > currentWeapon.currentMaxAmmo)
					currentWeapon.ammo = currentWeapon.currentMaxAmmo;
				_ammoRegenCounter = 0;
			}
			else
			{
				_ammoRegenCounter += FlxG.elapsed;
			}
			
			super.update();
		}
		
		override public function hitFloor(Contact:FlxCore=null):Boolean
		{
			if(velocity.y > 50)
				FlxG.play(SndLand);
			return super.hitFloor();
		}
		
		private function checkSkillLevelUp():void
		{
			// TODO: separate into some sort of usabe addons / decorators that can upgrade the needed parts
			// look at normal levelups. this will always reset ammo for the selected weapon.
			
			var state:GameState = FlxG.state as GameState;
			
			for (var i:int = 0; i < _usageSkills.length; i++)
			{
				// check for max level
				var skill:Skill = _usageSkills[i] as Skill;
				
				var deco:SkillDecorator = skill.levels[skill.currentLevel];
				
				// if there is no deco, we probably have max level. just skip 
				if (!deco)
					continue;
					
				switch (skill.id)
				{
					case PlayerHelper.USAGE_SKILL_JUMP:
					{
						if (skillJump >= deco.requirementCounter)
						{
							FlxG.play(SndSkillUp);
							skill.currentLevel++;
							state.showFloatMessage("Jump is now level " + (skill.currentLevel+1), 0xFFFFFF);
							calculateUsageSkills(); 
							skillJump = 0;
							
							// find next level requirement
							if (skill.levels[skill.currentLevel])
							{
								var nextDecoJump:SkillDecorator = skill.levels[skill.currentLevel];
								skillJumpNext = nextDecoJump.requirementCounter;
							}
						}
						
						break;	
					}
					case PlayerHelper.USAGE_SKILL_RUN:
					{
						if (skillRun >= deco.requirementCounter)
						{
							FlxG.play(SndSkillUp);
							skill.currentLevel++;
							state.showFloatMessage("Run is now level " + (skill.currentLevel+1), 0xFFFFFF);
							calculateUsageSkills(); 
							skillRun = 0;
							
							if (skill.levels[skill.currentLevel])
							{
								var nextDecoRun:SkillDecorator = skill.levels[skill.currentLevel];
								skillRunNext = nextDecoRun.requirementCounter;
							}
						}
						break;
					}
					case PlayerHelper.USAGE_SKILL_IDLE:
					{
						if (skillIdle >= deco.requirementCounter)
						{
							FlxG.play(SndSkillUp);
							skill.currentLevel++;
							state.showFloatMessage("Regen is now level " + (skill.currentLevel+1), 0xFFFFFF);
							calculateUsageSkills(); 
							skillIdle = 0;
							
							if (skill.levels[skill.currentLevel])
							{
								var nextDecoReg:SkillDecorator = skill.levels[skill.currentLevel];
								skillIdleNext = nextDecoReg.requirementCounter;
							}
						}
					}
				}
			}
		}
		
		public function calculateUsageSkills():void
		{
			// could possibly be merged with calculateSkills
			for (var i:int = 0; i < _usageSkills.length; i++)
			{
				var skill:Skill = _usageSkills[i] as Skill;
				
				if (skill.currentLevel != 0)
				{
					var deco:SkillDecorator = skill.levels[skill.currentLevel-1];
					switch (skill.id)
					{
						case PlayerHelper.USAGE_SKILL_JUMP:
						{
							currentJumpAcceleration = baseJumpAcceleration * deco.playerJumpVelocity;
							break;	
						}
						case PlayerHelper.USAGE_SKILL_RUN:
						{
							currentRunSpeed = baseRunSpeed * deco.playerRunSpeed;
							break;	
						}
						case PlayerHelper.USAGE_SKILL_IDLE:
						{
							currentHealthRegenRate = baseHealthRegenRate * deco.playerRegenRate;
							break;	
						}
					}
				}
			}
		}
		
		public function calculateSkills():void
		{
			for (var i:int = 0; i < skills.length; i++)
			{
				var skill:Skill = skills[i] as Skill;
				
				if (skill.currentLevel != 0)
				{
					// do -1 as we have level zero based in the skills array
					var deco:SkillDecorator = skill.levels[skill.currentLevel-1];
					
					switch (skill.id)
					{
						case PlayerHelper.SKILL_AMMO:
						{
							// take this into consideration later on
							//if (deco.weponClass)
							for each(var weaponA:BaseWeapon in weapons)
							{
								weaponA.currentMaxAmmo = weaponA.baseMaxAmmo + deco.weaponMaxAmmo;
								// TODO: check if deco is set for a given weapon. this assumes its global
								currentAmmoRegenRate = baseAmmoRegenRate + deco.weaponAmmoRegen;
								// add regen as well 
							}
							break;
						}
						case PlayerHelper.SKILL_GUNS:
						{
							// take this into consideration later on
							//if (deco.weponClass)
							for each(var weaponG:BaseWeapon in weapons)
							{
								weaponG.currentDamage = weaponG.baseDamage * deco.weaponDamage;
								// add projectile as well
							}
							break;
						}
						case PlayerHelper.SKILL_HEALTH:
						{
							currentMaxHealth = baseMaxHealth * deco.playerHealth;
							currentHealthRegenRate = deco.playerRegenRate;
							break;
						}
					}
				}
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
		
		// TODO: remove me?
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
		
		public function get skills():Array
		{
			return _skills;
		}
		
		public function set skills(value:Array):void
		{
			_skills = value;
		}
		
		public function getSkillById(skillId:String):Skill
		{
			for each(var skill:Skill in skills)
			{
				if (skill.id == skillId)
				{
					return skill;
				}
			}
			return null;
		}
	}
}