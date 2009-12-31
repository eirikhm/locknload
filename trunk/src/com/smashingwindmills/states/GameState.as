package com.smashingwindmills.states
{
	import com.smashingwindmills.game.Ladder;
	import com.smashingwindmills.game.Player;
	import com.smashingwindmills.game.enemy.BaseEnemy;
	import com.smashingwindmills.game.enemy.Tank;
	import com.smashingwindmills.game.enemy.Turret;
	import com.smashingwindmills.game.items.BaseItem;
	import com.smashingwindmills.game.weapon.BaseBullet;
	import com.smashingwindmills.game.weapon.BaseWeapon;
	import com.smashingwindmills.game.weapon.CorrodeSquirt;
	import com.smashingwindmills.game.weapon.FireGattler;
	import com.smashingwindmills.maps.BaseMap;
	import com.smashingwindmills.maps.MapBase;
	import com.smashingwindmills.maps.Prototype;
	import com.smashingwindmills.states.layers.HUDLayer;
	import com.smashingwindmills.states.layers.LevelUpLayer;
	
	import org.flixel.FlxG;
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class GameState extends FlxState
	{
		protected var levelBlocks:Array = new Array();
		protected var _player:Player = null;
		
		protected var enemies:Array = new Array();
		protected var enemyBullets:Array = new Array();
		protected var ladders:Array = new Array();
		private var _map:MapBase;
		protected var _lootItems:Array = new Array();
		
        public static var lyrHUD:HUDLayer;
        public static var lyrLevelUp:FlxLayer;
        
		[Embed(source="../media/maps2/mytest.CSV", mimeType="application/octet-stream")]
		private var mapData:Class;
		[Embed(source="../media/maps2/Woodland_Tileset.png")]
		private var tiles:Class;

	// uncomment to embed music.
	//	[Embed(source="../media/temp/music.mp3")]
	//	private var bgMusic:Class;
	
	
		private var _level:BaseMap;
		
		public function get level():BaseMap
		{
			return _level;
		}
		
		public function set level(value:BaseMap):void
		{
			_level = value;
		}
		
        private function initializeLevelUpLayer():void
        {
        	lyrLevelUp = new LevelUpLayer();
        	lyrLevelUp.visible = false;
        }
        
        private function initializeHud():void
        {
        	lyrHUD = new HUDLayer();
        }
        
		public function GameState()
		{
			player = new Player();
			var weapon:BaseWeapon = buildWeapon(CorrodeSquirt,7,-1);
			
			player.weapons.push(weapon);
			player.weapons.push(buildWeapon(FireGattler,4,10));
			player.currentWeaponIndex = 0;
			player.health = 100;
			player.x = 100;
			player.y = 1044;
			
			// hud expects player to exist in state.
			initializeHud();
			initializeLevelUpLayer();			
			
			
			level = new Prototype();
			level.initialize();
			
			tempAddEnemies();
			
			//Create the map
		//	_map = new MapSandbox();

			//Add the layers to current the FlxState

			//FlxG.state.add(_map.layerMain);
		//	_map.addSpritesToLayerMain(onAddSpriteCallback);
			
			FlxG.followBounds(level.boundsMinX, level.boundsMinY, level.boundsMaxX, level.boundsMaxY);
			
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5,0.0);
			add(player);
			
			// uncomment to play music
		//	FlxG.playMusic(bgMusic,1);
			
			this.add(lyrHUD);
			this.add(lyrLevelUp);
		}
		
		private function tempAddEnemies():void
		{
			var turret:Turret = new Turret(200,1044);
			turret.player = player;
			turret.initialize();
			if (turret.weapon)
			{
				enemyBullets = enemyBullets.concat(turret.weapon.bullets);
			}
			enemies.push(turret);
			FlxG.state.add(turret);
			
		}
		
		private function buildWeapon(weaponClass:Class,bulletCount:int = 5, ammo:int = -1):BaseWeapon
		{
			var weapon:BaseWeapon = new weaponClass(6);
			weapon.buildBullets();
			weapon.ammo = ammo;
			weapon.bulletCount = bulletCount;
			return weapon;
		}

		protected function onAddSpriteCallback(obj:FlxSprite):void
		{
			// pass in a reference to the player
			if (obj is Turret || obj is Tank)
			{
				var temp:BaseEnemy = obj as BaseEnemy;
				temp.player = player;
				temp.initialize();
				if (temp.weapon)
				{
					enemyBullets = enemyBullets.concat(temp.weapon.bullets);
				}
				enemies.push(temp);
			}

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
			if (FlxG.keys.justPressed("L"))
			{
				lyrLevelUp.visible = !lyrLevelUp.visible;
				if (lyrLevelUp.visible)
				{
					FlxG.showCursor();
				}
				else
				{
					FlxG.hideCursor();
				}
			}
			
			if (FlxG.keys.ONE)
			{
				player.currentWeaponIndex = 0;	
			}
			
			if (FlxG.keys.TWO)
			{
				player.currentWeaponIndex = 1;	
			}
     
			level.mainLayer.collide(player);
			level.mainLayer.collideArray(enemies);
			level.mainLayer.collideArray(lootItems);
			level.mainLayer.collideArray(enemyBullets);
			level.mainLayer.collideArray(player.currentWeapon.bullets);
			
			
			FlxG.overlapArray(enemies, player, overlapPlayerEnemy);
			FlxG.overlapArray(enemyBullets, player, bulletHitPlayer);
			FlxG.overlapArray(lootItems, player, playerPickupLoot);
			FlxG.overlapArray(ladders, player, overlapPlayerLadder);
						
			FlxG.overlapArrays(player.currentWeapon.bullets,enemies,bulletHitEnemy);
			super.update();
		}
		
		private function playerPickupLoot(loot:FlxSprite,p:FlxSprite):void
		{
			var item:BaseItem = loot as BaseItem;
			item.aquireLoot(player);
			loot.kill();
		}
		
		private function bulletHitPlayer(bullet:FlxSprite,p:FlxSprite):void
		{
			var temp:BaseBullet = bullet as BaseBullet;
			p.hurt(temp.damage);
			bullet.hurt(0);
			
		}
		
		private function overlapPlayerEnemy(enemy:FlxSprite,p:FlxSprite):void
		{
			p.hurt(1);
		}
		
		private function overlapPlayerLadder(ladder:FlxSprite,p:FlxSprite):void
		{
			player.onLadder = true;
		}
		
		private function bulletHitEnemy(bullet:FlxSprite,enemy:FlxSprite):void
		{
			bullet.hurt(0);
			var temp:BaseBullet= bullet as BaseBullet;
			enemy.hurt(temp.damage);
		}		
		
		public function get lootItems():Array
		{
			return _lootItems;	
		}
	    
		public function set lootItems(value:Array):void
		{
			_lootItems = value;
		}
		
		public function get player():Player
		{
			return _player;
		}
		
		public function set player(value:Player):void
		{
			_player = value;
		}
	}
}