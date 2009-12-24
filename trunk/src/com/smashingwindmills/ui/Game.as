package com.smashingwindmills.ui
{
	import com.smashingwindmills.states.MenuState;
	
	import org.flixel.FlxGame;
	
	public class Game extends FlxGame
	{
		protected const RES_HORIZONTAL:int = 640;
		protected const RES_VERTICAL:int = 480;
		protected const ZOOM:int = 2;
		public function Game()
		{
			super(RES_HORIZONTAL,RES_VERTICAL,MenuState,ZOOM);
			
		}
	}
}