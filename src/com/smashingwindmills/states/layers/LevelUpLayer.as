package com.smashingwindmills.states.layers
{
	import com.smashingwindmills.game.weapon.BaseWeapon;
	import com.smashingwindmills.game.weapon.CorrodeSquirt;
	import com.smashingwindmills.states.GameState;
	
	import flash.geom.Point;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class LevelUpLayer extends FlxLayer
	{
		private var textMain:FlxText;
		private var textSkillPoints:FlxText;

		[Embed (source = "../media/temp/level_up.png")]
		protected var backgroundImage:Class;

		[Embed (source = "../media/temp/level_up_pane.png")]
		protected var paneImage:Class;
		
		
		protected var fire:FlxButton;
		
		private var _lastSkillPoints:int = 0;
		
		public function LevelUpLayer()
		{
			super();
			
			
			var state:GameState = FlxG.state as GameState;
			
			var bg:FlxSprite = new FlxSprite(0,0);
			bg.loadGraphic(backgroundImage);
			bg.y = 0;
			bg.scrollFactor = new Point(0,0);
			add(bg);

			textMain = new FlxText(100, 20, 300, "Choose skills to upgrade!");
	    	textMain.setFormat(null, 16, 0x0FFF15, "left");
            textMain.scrollFactor = new Point(0, 0);
            add(textMain);
			
			_lastSkillPoints = state.player.availableSkillPoints;
			
			textSkillPoints = new FlxText(0, 350, 200, "Skill points: " + state.player.availableSkillPoints);
	    	textSkillPoints.setFormat(null, 16, 0x0FFF15, "left");
            textSkillPoints.scrollFactor = new Point(0, 0);
            add(textSkillPoints);
            


			var fireText:FlxText = new FlxText(0,0,40,"Click");
			fireText.setFormat(null,12,0xFFAA66,"left");
			
			fire = new FlxButton(0,0,myButtonClick);
			fire.loadText(fireText);
			fire.y = 20;
			fire.x = 20;
			fire.width = 100;
			fire.height = 100;
			fire.scrollFactor = new Point(0,0);
			add(fire);
			
			

		}
		public function myButtonClick():void
		{
			var state:GameState = FlxG.state as GameState;

			// TODO: this is _very_ temporary. Modifier classes should be attached to an array in weapon called "upgrades", and
			// the same goes for player. some kind of trees of skills should then be created and map to the various modifiers
			// that we can add.
			for (var i:int = 0; i < state.player.weapons.length; i++)
			{
				if (state.player.weapons[i] is CorrodeSquirt)
				{
					var weapon:BaseWeapon = state.player.weapons[i] as BaseWeapon;
					weapon.baseDamage = 30;
					weapon.maxAmmo = 300;
					weapon.ammo = 300;
				}
			}
		}
		
		override public function update():void
		{
			super.update();

			var state:GameState = FlxG.state as GameState;


			if (_lastSkillPoints != state.player.availableSkillPoints)
			{
				_lastSkillPoints = state.player.availableSkillPoints;
				textSkillPoints.text = "Skill points: " + _lastSkillPoints.toString();
			}
			if (FlxG.mouse.justPressed())
			{
				trace("scroll " + FlxG.scroll.x + "/" + FlxG.scroll.y);
				trace("screen " + FlxG.state.x + "/" + FlxG.state.y);
				trace("layer  " + x + "/" + y);
				trace("button " + fire.x + "/" + fire.y);
				trace("mouse  " + FlxG.mouse.x + "/" +FlxG.mouse.y); 
			}
		}

	}
}