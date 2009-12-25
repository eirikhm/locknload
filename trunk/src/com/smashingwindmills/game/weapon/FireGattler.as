package com.smashingwindmills.game.weapon
{
	public class FireGattler extends BaseWeapon
	{
		public function FireGattler(numBullets:int = 8)
		{
			bulletType = FireGattlerBullet;
			super(numBullets);
			baseDamage = 20;
			baseVelocity.x = 200;
			baseVelocity.y = 0; 
		}

	}
}