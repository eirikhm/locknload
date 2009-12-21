package com.smashingwindmills.states
{
	import com.smashingwindmills.game.Bullet;
	import com.smashingwindmills.game.Enemy;
	import com.smashingwindmills.game.Player;
	import com.smashingwindmills.maps.MapBase;
	import com.smashingwindmills.maps.MapLevel01;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class GameState extends FlxState
	{
		[Embed (source = "../media/tiles/default.png")]
		protected var defaultTile:Class;
		
		protected var levelBlocks:Array = new Array();
		protected var player:Player = null;
		
		protected var playerBullets:Array = new Array();
		protected var enemies:Array = new Array();
		private var _map:MapBase;

		[Embed(source="../media/music/ugress.mp3")] 
		protected var MusicMode:Class;


		public function GameState()
		{
			
			
			for (var i:uint = 0; i < 8; i++)
			{
				playerBullets.push(add(new Bullet()));
			}
			player = new Player(playerBullets);
		

			add(new Enemy(player.x + 10, player.y + 10));
			//IF IN DOUBT PUT THE FOLLOWING INSIDE YOUR DERIVED FlxState CLASS' CONSTRUCTOR (i.e. inside function MyState()...)
			//Create the map
			_map = new MapLevel01();

			//Add the layers to current the FlxState

			FlxG.state.add(_map.layerBg);
			FlxG.state.add(_map.layerFg);
			FlxG.state.add(_map.layerNewLayer);
			
			_map.addSpritesToLayerBg(onAddSpriteCallback);
			_map.addSpritesToLayerFg(onAddSpriteCallback);
			_map.addSpritesToLayerNewLayer(onAddSpriteCallback);
			
			FlxG.followBounds(_map.boundsMinX, _map.boundsMinY, _map.boundsMaxX, _map.boundsMaxY);
			
			
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5,0.0);
		//	FlxG.followBounds(0,0,640,640);
			add(player);
			
			FlxG.play(MusicMode);
		}

		//PUT THE FOLLOWING INSIDE YOUR DERIVED FlxState CLASS (i.e. under 'class MyState { ...')

		protected function onAddSpriteCallback(obj:FlxSprite):void
		{
			if(obj is Enemy)
				enemies.push(obj);
		}
		protected function onMapAddCallback(spr:FlxSprite):void
		{
			if(spr is Enemy)
				enemies.push(spr);
		}
		
		override public function update():void
		{
			_map.layerFg.collide(player);
			_map.layerFg.collideArray(enemies);
			_map.layerFg.collideArray(enemies);			
			_map.layerFg.collideArray(playerBullets);
			FlxG.overlapArray(enemies, player, overlapPlayerEnemy);
			FlxG.overlapArrays(playerBullets,enemies,bulletHitEnemy);

			super.update();
		}
		private function overlapPlayerEnemy(enemy:FlxSprite,p:FlxSprite):void
		{
	//		p.hurt(1);
		}
		
		private function bulletHitEnemy(bullet:FlxSprite,enemy:FlxSprite):void
		{
			bullet.hurt(0);
			enemy.hurt(1);
		}		
	}
	
}