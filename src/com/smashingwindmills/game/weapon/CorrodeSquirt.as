package com.smashingwindmills.game.weapon
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class CorrodeSquirt extends BaseWeapon
	{
		[Embed(source="../media/temp/audio/shoot.mp3")] 
		protected var SndShoot:Class;
		
		public function CorrodeSquirt(numOfBullets:int = 8)
		{
			bulletType = CorrodeSquirtBullet;
			super(numOfBullets);
			
			name = "Corrode Squirt Gun";
			baseDamage = 10;
			baseVelocity.x = 1000;
			baseVelocity.y = 0;
			maxChargeTime = 6; 
			minChargeTime = 1;
		}
		
		public override function calculateDamange():Number
		{
			return baseDamage * chargeTime;
		}
		
		override public function shoot(equipper:FlxSprite):void
		{
			super.shoot(equipper);
			FlxG.play(SndShoot);
		}

	}
}