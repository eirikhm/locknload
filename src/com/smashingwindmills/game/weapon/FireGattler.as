package com.smashingwindmills.game.weapon
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class FireGattler extends BaseWeapon
	{
		[Embed(source="../media/temp/audio/shoot.mp3")] 
		protected var SndShoot:Class;
		public function FireGattler(numBullets:int = 8)
		{
			bulletType = FireGattlerBullet;			
			super(numBullets);
			name = "Fire Gattler Gun";
			baseDamage = 20;

			baseVelocity.x = 200;
			baseVelocity.y = 0; 
		}
		override public function shoot(equipper:FlxSprite):void
		{
			super.shoot(equipper);
			FlxG.play(SndShoot);
		}
	}
}