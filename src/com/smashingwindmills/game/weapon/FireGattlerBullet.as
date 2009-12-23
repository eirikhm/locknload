package com.smashingwindmills.game.weapon
{
	public class FireGattlerBullet extends BaseBullet
	{
		[Embed(source="../media/temp/enemy_bullet.png")]
		protected var imgBullet:Class;
		// Y offset indicator
		private var isUp:Boolean = false;
		
		public function FireGattlerBullet()
		{
			super();
			loadGraphic(imgBullet,true);
			addAnimation("up",[0]);
			addAnimation("down",[1]);
			addAnimation("left",[2]);
			addAnimation("right",[3]);
			addAnimation("poof",[4,5,6,7], 50, false);
			
		}
		override public function update():void
		{
			// example on how to create somewhat unstable bullets
			if (velocity.y >= 10)
			{
				isUp = false;		
			}
			else if (velocity.y <= -10)
			{
				isUp = true;	
			}
			if (isUp)
			{
				velocity.y +=3;
			}
			else
			{
				velocity.y -=3;
			}
			super.update();
		}
	}
}