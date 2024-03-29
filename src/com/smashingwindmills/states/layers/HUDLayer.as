package com.smashingwindmills.states.layers
{
	import com.smashingwindmills.game.Player;
	import com.smashingwindmills.states.GameState;
	import com.smashingwindmills.ui.ProgressMeter;
	
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class HUDLayer extends FlxLayer
	{
		protected var _textExperience:FlxText;
		protected var _textLevel:FlxText;
		protected var _textHealth:FlxText;
		protected var _textWeapon:FlxText;
		protected var _textAmmo:FlxText;
		
		private var _lastHealth:int = 0;
		private var _lastXp:int = 0;
		private var _lastLevel:int = 0;
		
		
		private var _jumpMeter:FlxSprite;
		
		private var pmJump:ProgressMeter;
		private var pmRun:ProgressMeter;
		private var pmIdle:ProgressMeter;
		
		public function HUDLayer()
		{
	       	_textHealth = new FlxText(0, 2, 200, "HP: ");
	    	_textHealth.setFormat(null, 16, 0x0FFF15, "left");
            _textHealth.scrollFactor = new Point(0, 0);
            add(_textHealth);

	       	_textWeapon = new FlxText(0, 20, 200, "HP: ");
	    	_textWeapon.setFormat(null, 12, 0x0FFF15, "left");
            _textWeapon.scrollFactor = new Point(0, 0);
            _textWeapon.text = "Corrode Gun";
            add(_textWeapon);
			
            _textExperience = new FlxText(FlxG.width - 250, 2, 200, "XP: " + FlxG.score.toString());
	    	_textExperience.setFormat(null, 16, 0xFFFF00, "right");
            _textExperience.scrollFactor = new Point(0, 0);
            add(_textExperience);
                                	
            _textLevel = new FlxText(250, 2, 100, "Level: ");
	    	_textLevel.setFormat(null, 16, 0xffffffff, "right");
            _textLevel.scrollFactor = new Point(0, 0);
            add(_textLevel);	
            
            
			var state:GameState = FlxG.state as GameState;
			var player:Player = state.player;
			
			_lastHealth = player.health;
			_lastLevel = player.level;
			_lastXp = FlxG.score;
			
			
			pmJump = new ProgressMeter(400,20,25,25);
			pmJump.currentValue = 0;
			pmJump.borderColor = 0x00FF00;
			pmJump.draw(this);

			
			pmRun = new ProgressMeter(370,20,25,25);
			pmRun.draw(this);
			pmRun.currentValue = 0;
			
			pmIdle = new ProgressMeter(330,20,25,25);
			pmIdle.currentValue = 0;
			pmIdle.borderColor = 0x0000FF;
			pmIdle.draw(this);

			
		}
		
		override public function update():void
		{
			super.update();
			
			var state:GameState = FlxG.state as GameState;
			var player:Player = state.player;
			
			
			
			pmJump.currentValue = (player.skillJump / player.skillJumpNext)*100;
			pmRun.currentValue = (player.skillRun / player.skillRunNext)*100;
			pmIdle.currentValue = (player.skillIdle / player.skillIdleNext)*100;
			
			var ammoStr:String = "";
			if (player.currentWeapon.ammo == -1)
			{
				ammoStr = "~";
			}	
			else
			{
				ammoStr = player.currentWeapon.ammo.toString();
			}
			
			_textWeapon.text = player.currentWeapon.name + "(" + ammoStr + "/" + player.currentWeapon.currentMaxAmmo + ")";
			
			// TODO: this needs to be updated when a skill is updated for max health
			if (player.health != _lastHealth)
			{
				health = player.health.toString() + "/" + player.currentMaxHealth;
				_lastHealth = player.health;
			}	
				
			if (player.level != _lastLevel)
			{
				level = player.level.toString();
				_lastLevel = player.level;
			}
			
			if (FlxG.score != _lastXp)
			{
				_lastXp = FlxG.score;
				experience = "XP: " + FlxG.score.toString() + "/" + player.xpToNextLevel.toString();
			}
		}
		
		protected function set experience(value:String):void
		{
			_textExperience.text = "XP: " + value;
		}
		
		protected function set health(value:String):void
		{
			// do some adjustments here.
			var intVal:int = value as int;
		
			if (intVal > 75)
			{
				_textHealth.color = 0x0FFF15;
			}
			else if (intVal > 40)
			{
				_textHealth.color = 0xFFC90E;
			}
			else
			{
				_textHealth.color = 0xFF0000;
			}
			_textHealth.text = "HP: " + value;
		}
	
		protected function set level(value:String):void
		{
			_textLevel.text = "Level: " + value;
		}
	}
}