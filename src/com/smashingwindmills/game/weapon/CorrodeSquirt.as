package com.smashingwindmills.game.weapon
{
	public class CorrodeSquirt extends BaseWeapon
	{
		public function CorrodeSquirt(numOfBullets:int = 8)
		{
			bulletType = CorrodeSquirtBullet;
			super(numOfBullets);
			
	
			baseDamage = 2;
			baseVelocity.x = 1000;
			baseVelocity.y = 0;
			maxChargeTime = 6; 
			minChargeTime = 1;
		}
		
		public override function calculateDamange():Number
		{
			trace("damange for " + baseDamage);
			trace("Charged for " + chargeTime);
			return baseDamage * chargeTime;
		}

	}
}