package com.smashingwindmills.game.enemy
{
	import com.smashingwindmills.game.effects.SmokeGibs;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	
	public class Turret extends BaseEnemy
	{
		[Embed(source="../media/temp/turret.png")]
		protected var enemyImage:Class;
		
  		protected var gibs:FlxEmitter;


		public function Turret(X:int,Y:int)
		{
			// always call super ctor before setting xp value etc						
			super(X,Y);
			xpValue = 300;
			health = 50;
			
			this.velocity.x = 0;
			this.velocity.y = 0;
			loadGraphic(enemyImage,true,true);
			startingX = X;
			
			addAnimation("turn",[0,1,2],10);

 			this.gibs = FlxG.state.add(new SmokeGibs) as FlxEmitter; 

			play("turn");
		}
		override public function update():void
		{
			// fire off shots here.
			super.update();
		}
		
		override public function kill():void
		{
			this.gibs.x = this.x + (this.width>>1);
			this.gibs.y = this.y + (this.height>>1);
			this.gibs.restart();
			super.kill();
		}
	}
}