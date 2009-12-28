package com.smashingwindmills.game.items
{
	import com.smashingwindmills.game.Player;
	
	import org.flixel.FlxSprite;
	
	public class BaseItem extends FlxSprite
	{
		protected var _name:String;
		
  		protected var GRAVITY_ACCELERATION:int = 420;

		public function BaseItem(X:int,Y:int)
		{
			super(X,Y);
			acceleration.y = GRAVITY_ACCELERATION;
		}
		
		public function aquireLoot(p:Player):void
		{
			
		}
	}
}