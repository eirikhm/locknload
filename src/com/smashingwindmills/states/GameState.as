package com.smashingwindmills.states
{
	import com.smashingwindmills.game.Ladder;
	import com.smashingwindmills.game.Player;
	import com.smashingwindmills.game.enemy.Tank;
	import com.smashingwindmills.game.enemy.Turret;
	import com.smashingwindmills.game.weapon.BaseWeapon;
	import com.smashingwindmills.game.weapon.CorrodeSquirt;
	import com.smashingwindmills.game.weapon.CorrodeSquirtBullet;
	import com.smashingwindmills.game.weapon.FireGattler;
	import com.smashingwindmills.game.weapon.FireGattlerBullet;
	import com.smashingwindmills.maps.MapBase;
	import com.smashingwindmills.maps.MapSandbox;
	
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	
	public class GameState extends FlxState
	{
		[Embed (source = "../media/tiles/default.png")]
		protected var defaultTile:Class;
		
		protected var levelBlocks:Array = new Array();
		protected var player:Player = null;
		
		protected var enemies:Array = new Array();
		protected var ladders:Array = new Array();
		private var _map:MapBase;

		[Embed(source="../media/music/ugress.mp3")] 
		protected var MusicMode:Class;

		private var textExperience:FlxText;
		private var textLevel:FlxText;
		private var textHealth:FlxText;
		
		private var lastHealth:int = 0;
		private var lastXp:int = 0;
		private var lastLevel:int = 0;
        public static var lyrHUD:FlxLayer;
        
        private function initializeHud():void
        {
        	lyrHUD = new FlxLayer;
        	
	       	textHealth = new FlxText(-100, 2, 200, "HP: ");
	    	textHealth.setFormat(null, 16, 0x0FFF15, "right");
            textHealth.scrollFactor = new Point(0, 0);
            lyrHUD.add(textHealth);
			
            textExperience = new FlxText(FlxG.width - 250, 2, 200, "XP: " + FlxG.score.toString());
	    	textExperience.setFormat(null, 16, 0xFFFF00, "right");
            textExperience.scrollFactor = new Point(0, 0);
            lyrHUD.add(textExperience);
                                	
            textLevel = new FlxText(250, 2, 100, "Level: ");
	    	textLevel.setFormat(null, 16, 0xffffffff, "right");
            textLevel.scrollFactor = new Point(0, 0);
            lyrHUD.add(textLevel);		
        }
		public function GameState()
		{
			initializeHud();
			
			/*for (var i:uint = 0; i < 8; i++)
			{
				playerBullets.push(add(new Bullet()));
			}*/
			player = new Player();
			player.currentWeapon = buildCorrodeWeapon();
			player.health = 100;
			player.x = 300;
			textHealth.text = "HP: " + player.health;
			textLevel.text = "Level: " + player.level;
			textExperience.text = "XP: " + FlxG.score.toString() + "/" + player.xpToNextLevel;			

			lastHealth = player.health;
			lastLevel = player.level;
			lastXp = FlxG.score;

			//Create the map
			_map = new MapSandbox();

			//Add the layers to current the FlxState

			FlxG.state.add(_map.layerMain);
			_map.addSpritesToLayerMain(onAddSpriteCallback);
			
			FlxG.followBounds(_map.boundsMinX, _map.boundsMinY, _map.boundsMaxX, _map.boundsMaxY);
			
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5,0.0);
			add(player);
			
			FlxG.play(MusicMode,1.0,false);
			this.add(lyrHUD);
		}
		
		private function buildCorrodeWeapon():BaseWeapon
		{
			
			var weapon:BaseWeapon = new CorrodeSquirt();
			
			var bullets:Array = new Array();
			for (var i:uint = 0; i < 8; i++)
			{
				bullets.push(add(new CorrodeSquirtBullet()));
			}
			weapon.bullets = bullets;
			return weapon;
		}
		private function buildFireWeapon():BaseWeapon
		{
			var weapon:BaseWeapon = new FireGattler();
			
			var bullets:Array = new Array();
			for (var i:uint = 0; i < 8; i++)
			{
				bullets.push(add(new FireGattlerBullet()));
			}
			weapon.bullets = bullets;
			return weapon;
		}

		//PUT THE FOLLOWING INSIDE YOUR DERIVED FlxState CLASS (i.e. under 'class MyState { ...')

		protected function onAddSpriteCallback(obj:FlxSprite):void
		{
			if (obj is Turret)
				enemies.push(obj);
			
			if(obj is Tank)
				enemies.push(obj);
				
			if(obj is Tank)
				enemies.push(obj);
				
			if (obj is Ladder)
				ladders.push(obj);
		}
		protected function onMapAddCallback(spr:FlxSprite):void
		{
			if(spr is Tank)
				enemies.push(spr);
		}
		
		override public function update():void
		{
			
			if (FlxG.keys.Y)
			{
				player.currentWeapon = buildCorrodeWeapon();	
			}
			
			if (FlxG.keys.I)
			{
				player.currentWeapon = buildFireWeapon();	
			}
			if (player.health != lastHealth)
			{
				if (player.health > 75)
				{
					textHealth.color = 0x0FFF15;
				}
				else if (player.health > 40)
				{
					textHealth.color = 0xFFC90E;
				}
				else
				{
					textHealth.color = 0xFF0000;
				}
				textHealth.text = "HP:" + player.health.toString();
				lastHealth = player.health;
			}	
				
			if (player.level != lastLevel)
			{
				textLevel.text =  "Level: " + player.level.toString()	
				lastLevel = player.level;
			}
			if (FlxG.score != lastXp)
			{
				lastXp = FlxG.score;
				textExperience.text = "XP: " + FlxG.score.toString() + "/" + player.xpToNextLevel;
			}
			            
			_map.layerMain.collide(player);
			_map.layerMain.collideArray(enemies);
			_map.layerMain.collideArray(player.currentWeapon.bullets);
			var foo:FlxTilemap = new FlxTilemap();
			
			FlxG.overlapArray(enemies, player, overlapPlayerEnemy);
			FlxG.overlapArray(ladders, player, overlapPlayerLadder);
			FlxG.overlapArrays(player.currentWeapon.bullets,enemies,bulletHitEnemy);
			super.update();
		}
		
		private function overlapPlayerEnemy(enemy:FlxSprite,p:FlxSprite):void
		{
			p.hurt(1);
		}
		
		private function overlapPlayerLadder(ladder:FlxSprite,p:FlxSprite):void
		{
			
		}
		
		private function bulletHitEnemy(bullet:FlxSprite,enemy:FlxSprite):void
		{
			bullet.hurt(0);
			enemy.hurt(player.calculateWeaponDamage());
		}		
	}
	
}