package com.smashingwindmills.states.layers
{
	import com.smashingwindmills.game.PlayerHelper;
	import com.smashingwindmills.states.GameState;
	
	import flash.geom.Point;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class LevelUpLayer extends FlxLayer
	{
		protected var textMain:FlxText;
		protected var textSkillPoints:FlxText;
		protected var fire:FlxButton;
		
		protected var gunsText:FlxText;
		protected var ammoText:FlxText;
		protected var healthText:FlxText;
		
		protected var gunsButton:FlxButton; 
		protected var ammoButton:FlxButton;
		protected var healthButton:FlxButton; 


		[Embed (source = "../media/temp/level_up.png")]
		protected var backgroundImage:Class;

		[Embed (source = "../media/temp/level_up_pane.png")]
		protected var paneImage:Class;
		
		protected var _lastSkillPoints:int = 0;
		
		protected var state:GameState;
		
		public function LevelUpLayer()
		{
			super();
			
			state = FlxG.state as GameState;
			
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
            
            
            gunsText = new FlxText(0,100,200,"Guns: " + state.player.getSkillById(PlayerHelper.SKILL_GUNS).currentLevel);
	    	gunsText.setFormat(null, 16, 0x0FFF15, "left");
            gunsText.scrollFactor = new Point(0, 0);
                        
            ammoText = new FlxText(0,140,200,"Ammo: " + state.player.getSkillById(PlayerHelper.SKILL_AMMO).currentLevel);
            ammoText.setFormat(null, 16, 0x0FFF15, "left");
            ammoText.scrollFactor = new Point(0, 0);
            
            healthText = new FlxText(0,180,200,"Health: "  + state.player.getSkillById(PlayerHelper.SKILL_HEALTH).currentLevel);
            healthText.setFormat(null, 16, 0x0FFF15, "left");
            healthText.scrollFactor = new Point(0, 0);
            
            add(gunsText);
            add(ammoText);
            add(healthText);
          
			gunsButton = new FlxButton(0,0,upgradeGuns);
			gunsButton.loadText(new FlxText(0,0,100,"Upgrade!"));
			gunsButton.y = 100;
			gunsButton.x = 100;
			gunsButton.width = 100;
			gunsButton.height = 100;
			gunsButton.scrollFactor = new Point(0,0);
			add(gunsButton);
			
			ammoButton = new FlxButton(0,0,upgradeAmmo);
			ammoButton.loadText(new FlxText(0,0,100,"Upgrade!"));
			ammoButton.y = 140;
			ammoButton.x = 100;
			ammoButton.width = 100;
			ammoButton.height = 100;
			ammoButton.scrollFactor = new Point(0,0);
			add(ammoButton);

			healthButton = new FlxButton(0,0,upgradeHealth);
			healthButton.loadText(new FlxText(0,0,100,"Upgrade!"));
			healthButton.y = 180;
			healthButton.x = 100;
			healthButton.width = 100;
			healthButton.height = 100;
			healthButton.scrollFactor = new Point(0,0);
			add(healthButton);
		}
		
		public function upgradeHealth():void
		{
			state.player.getSkillById(PlayerHelper.SKILL_HEALTH).currentLevel++;
			state.player.availableSkillPoints--;
			healthText.text = "Health: "  + state.player.getSkillById(PlayerHelper.SKILL_HEALTH).currentLevel;
			checkButtons();
			state.player.calculateSkills();
		}
		
		public function upgradeAmmo():void
		{
			state.player.availableSkillPoints--;	
			state.player.getSkillById(PlayerHelper.SKILL_AMMO).currentLevel++;	
			ammoText.text = "Ammo: " + state.player.getSkillById(PlayerHelper.SKILL_AMMO).currentLevel;
			checkButtons();		
			state.player.calculateSkills();
		}
		
		public function upgradeGuns():void
		{
			state.player.availableSkillPoints--;
			state.player.getSkillById(PlayerHelper.SKILL_GUNS).currentLevel++;	
			gunsText.text = "Guns: " + state.player.getSkillById(PlayerHelper.SKILL_GUNS).currentLevel;
			checkButtons();
			state.player.calculateSkills();
		}
		
		override public function update():void
		{
			super.update();
			if (_lastSkillPoints != state.player.availableSkillPoints)
			{
				_lastSkillPoints = state.player.availableSkillPoints;
				textSkillPoints.text = "Skill points: " + _lastSkillPoints.toString();
			}
			checkButtons();
		}
		
		private function checkButtons():void
		{
			var enableButtons:Boolean = false;
			if (state.player.availableSkillPoints > 0)
			{
				enableButtons = true;
			}
			healthButton.visible = ammoButton.visible = gunsButton.visible = enableButtons;
		}
	}
}