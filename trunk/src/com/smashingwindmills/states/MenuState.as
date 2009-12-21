package com.smashingwindmills.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class MenuState extends FlxState
	{
		[Embed(source="../media/states/title.png")]
		protected var titleImage:Class;
		
		public function MenuState()
		{
			this.add(new FlxSprite(0,0,titleImage));
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("X"))
			{
				FlxG.switchState(GameState);
			}
		}
	}
}