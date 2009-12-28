package com.smashingwindmills.game.items
{
	import com.smashingwindmills.game.items.BaseItem;
	import com.smashingwindmills.game.Player;
	
	public class HealthKit extends BaseItem
	{
		[Embed(source="../media/temp/health.png")]
		protected var sprite:Class;
		
		public function HealthKit()
		{
			super(0,0);
			loadGraphic(sprite);
			this.velocity.y = -200;
		}

		override public function aquireLoot(p:Player):void
		{
			p.health += 5;
		}
	}
}