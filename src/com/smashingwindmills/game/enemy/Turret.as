package com.smashingwindmills.game.enemy
{
	import com.smashingwindmills.game.Player;
	import com.smashingwindmills.game.effects.SmokeGibs;
	import com.smashingwindmills.game.items.AmmoItem;
	import com.smashingwindmills.game.weapon.FireGattler;
	import com.smashingwindmills.states.GameState;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	public class Turret extends BaseEnemy
	{
		[Embed(source="../media/temp/turret.png")]
		protected var _enemyImage:Class;
		
  		protected var _gibs:FlxEmitter;
		
		protected var _attackCounter:int = 0;

		public function Turret(X:int,Y:int,p:Player = null,s:FlxState=null)
		{
			// always call super ctor before setting xp value etc						
			super(X,Y,p);
			xpValue = 300;
			health = 50;
			
			this.velocity.x = 0;
			this.velocity.y = 0;
			loadGraphic(_enemyImage,true,true);
			startingX = X;
			
			addAnimation("turn",[0,1,2],10);

 			this._gibs = FlxG.state.add(new SmokeGibs) as FlxEmitter; 
		
			play("turn");
			weapon = new FireGattler(20);
			weapon.baseDamage = 1;
			weapon.baseVelocity.y = 20;

		}
		
		override public function initialize():void
		{
			_weapon.buildBullets();			
		}
		
		override public function update():void
		{
			if (!dead)
			{
				if (player.x > x)
				{
					facing = RIGHT;
				}
				else
				{
					facing = LEFT;
				}
			
				if (_attackCounter > 0)
				{
					_attackCounter -= FlxG.elapsed;
				}
				if (_attackCounter <= 0)
				{
					var rangeX:int = player.x - x;
					var rangeY:int = player.y - y;
			
					if (rangeX <= detectRange.x && rangeX >= -detectRange.x && rangeY <= detectRange.y && rangeY >= -detectRange.y)
					{
						_attackCounter = 20;
						_weapon.shoot(this);						
					}
				}
			}
			// fire off shots here.
			super.update();
		}
		
		override public function kill():void
		{
			this._gibs.x = this.x + (this.width>>1);
			this._gibs.y = this.y + (this.height>>1);
			this._gibs.restart();
			super.kill();
			
			var drop:AmmoItem = new AmmoItem();
			drop.weaponType = FireGattler;
			drop.ammoCount = 2;
			drop.x = x;
			drop.y = y;
			
			var gameState:GameState = FlxG.state as GameState;
			gameState.lootItems.push(drop);
			gameState.add(drop);
		}
		
	}
}