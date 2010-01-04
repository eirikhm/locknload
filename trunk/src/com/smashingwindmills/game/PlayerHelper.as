package com.smashingwindmills.game
{
	import com.smashingwindmills.game.skills.Skill;
	import com.smashingwindmills.game.skills.SkillDecorator;
	
	import flash.geom.Point;
	
	public class PlayerHelper
	{
		public static var SKILL_AMMO:String 	= "SKILL_AMMO";
		public static var SKILL_GUNS:String 	= "SKILL_GUNS";
		public static var SKILL_HEALTH:String 	= "SKILL_HEALTH";
		
		
		public static var USAGE_SKILL_JUMP:String 	= "USAGE_SKILL_JUMP";
		public static var USAGE_SKILL_RUN:String 	= "USAGE_SKILL_RUN";
		public static var USAGE_SKILL_IDLE:String 	= "USAGE_SKILL_IDLE";
		
		
		
		public static var LEVELS:Array = new Array(
					0,
					300,
					750,
					1200,
					1900,
					4000,
					5200,
					7000,
					12000,
					16000);

		public static function buildUsageSkills():Array
		{
		
			var skills:Array = new Array();
			
			var jumpLevel1:SkillDecorator = new SkillDecorator();
			jumpLevel1.playerJumpVelocity = 1.10;
			jumpLevel1.requirementCounter = 10;

			var jumpLevel2:SkillDecorator = new SkillDecorator();
			jumpLevel2.playerJumpVelocity = 1.20;
			jumpLevel2.requirementCounter = 20;
			
			var jumpLevel3:SkillDecorator = new SkillDecorator();
			jumpLevel3.playerJumpVelocity = 1.30;
			jumpLevel3.requirementCounter = 30;
			
			var jumpLevel4:SkillDecorator = new SkillDecorator();
			jumpLevel4.playerJumpVelocity = 1.40;
			jumpLevel4.requirementCounter = 40;
			
			var jumpLevel5:SkillDecorator = new SkillDecorator();
			jumpLevel5.playerJumpVelocity = 1.50;	
			jumpLevel5.requirementCounter = 50;		
			
			
			
			
			var jumpSkill:Skill = new Skill(PlayerHelper.USAGE_SKILL_JUMP,"Jump!");
			jumpSkill.levels.push(jumpLevel1,jumpLevel2,jumpLevel3,jumpLevel4,jumpLevel5);
			
			
			var runLevel1:SkillDecorator = new SkillDecorator();
			runLevel1.playerRunSpeed = 1.10;
			runLevel1.requirementCounter = 10;

			var runLevel2:SkillDecorator = new SkillDecorator();
			runLevel2.playerRunSpeed = 1.20;
			runLevel2.requirementCounter = 20;
			
			var runLevel3:SkillDecorator = new SkillDecorator();
			runLevel3.playerRunSpeed = 1.30;
			runLevel3.requirementCounter = 30;
			
			var runLevel4:SkillDecorator = new SkillDecorator();
			runLevel4.playerRunSpeed = 1.40;
			runLevel4.requirementCounter = 40;
			
			var runLevel5:SkillDecorator = new SkillDecorator();
			runLevel5.playerRunSpeed = 1.50;	
			runLevel5.requirementCounter = 50;		
			
			var runSkill:Skill = new Skill(PlayerHelper.USAGE_SKILL_RUN,"Run!");
			runSkill.levels.push(runLevel1,runLevel2,runLevel3,runLevel4,runLevel5);
			
			
			
			var idleLevel1:SkillDecorator = new SkillDecorator();
			idleLevel1.playerRegenRate = 0.9;
			idleLevel1.requirementCounter = 10;

			var idleLevel2:SkillDecorator = new SkillDecorator();
			idleLevel2.playerRegenRate = 0.8;
			idleLevel2.requirementCounter = 20;
			
			var idleLevel3:SkillDecorator = new SkillDecorator();
			idleLevel3.playerRegenRate = 0.7;
			idleLevel3.requirementCounter = 30;
			
			var idleLevel4:SkillDecorator = new SkillDecorator();
			idleLevel4.playerRegenRate = 0.6;
			idleLevel4.requirementCounter = 40;
			
			var idleLevel5:SkillDecorator = new SkillDecorator();
			idleLevel5.playerRegenRate = 0.5;	
			idleLevel5.requirementCounter = 50;		
			
			var regenSkill:Skill = new Skill(PlayerHelper.USAGE_SKILL_IDLE,"Regen!");
			regenSkill.levels.push(idleLevel1,idleLevel2,idleLevel3,idleLevel4,idleLevel5);
			
			skills.push(jumpSkill,runSkill,regenSkill);
			return skills;
		}
		
		
		public static function buildSkills():Array
		{
			var skills:Array = new Array();
			
			var ammoLevel1:SkillDecorator = new SkillDecorator();
			ammoLevel1.weaponMaxAmmo = 2;
			ammoLevel1.weaponAmmoRegen = 0.9;
			
			var ammoLevel2:SkillDecorator = new SkillDecorator();
			ammoLevel2.weaponMaxAmmo = 4;
			ammoLevel2.weaponAmmoRegen = 0.8;
			
			var ammoLevel3:SkillDecorator = new SkillDecorator();
			ammoLevel3.weaponMaxAmmo = 6;
			ammoLevel3.weaponAmmoRegen = 0.7;

			var ammo:Skill = new Skill(PlayerHelper.SKILL_AMMO,"Ammo!");
			ammo.levels.push(ammoLevel1,ammoLevel2,ammoLevel3);
			

			var gunsLevel1:SkillDecorator = new SkillDecorator();
			gunsLevel1.weaponVelocity = new Point(1.05,0);
			gunsLevel1.weaponDamage = 1.10;
			
			var gunsLevel2:SkillDecorator = new SkillDecorator();
			gunsLevel2.weaponVelocity = new Point(1.10,0);
			gunsLevel2.weaponDamage = 1.20;
			
			var gunsLevel3:SkillDecorator = new SkillDecorator();
			gunsLevel3.weaponVelocity = new Point(1.15,0);
			gunsLevel3.weaponDamage = 1.30;

			var guns:Skill = new Skill(PlayerHelper.SKILL_GUNS,"Guns!");
			guns.levels.push(gunsLevel1,gunsLevel2,gunsLevel3);
			
			
			var healthLevel1:SkillDecorator = new SkillDecorator();
			healthLevel1.playerHealth = 1.05;
			healthLevel1.playerRegenRate = 10;

			var healthLevel2:SkillDecorator = new SkillDecorator();
			healthLevel2.playerHealth = 1.10;
			healthLevel2.playerRegenRate = 5;
			
			var healthLevel3:SkillDecorator = new SkillDecorator();
			healthLevel3.playerHealth = 1.15;
			healthLevel3.playerRegenRate = 3.3;
			
			var health:Skill = new Skill(PlayerHelper.SKILL_HEALTH,"Health!");
			health.levels.push(healthLevel1,healthLevel2,healthLevel3);
			
			skills.push(ammo,guns,health);
			return skills;			
		}
		public function PlayerHelper()
		{
			
		}
	}
}