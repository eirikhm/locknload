package com.smashingwindmills.game.weapon
{
	public class CorrodeSquirtBullet extends BaseBullet
	{
		[Embed(source="../media/temp/corrode.png")]
		protected var imgBullet:Class;
		
		public function CorrodeSquirtBullet()
		{
			super();
			loadGraphic(imgBullet,true);
			addAnimation("up",[0]);
			addAnimation("down",[1]);
			addAnimation("left",[0]);
			addAnimation("right",[0]);
			addAnimation("poof",[4,5,6,7], 50, false);
		}
	}
}