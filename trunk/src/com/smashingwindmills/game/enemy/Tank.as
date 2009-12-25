package com.smashingwindmills.game.enemy
{
	import com.smashingwindmills.game.effects.BaseBloodGibs;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	
	public class Tank extends BaseEnemy
	{
		[Embed(source="../media/temp/enemy_preview.png")]
		protected var enemyImage:Class;
		
  		protected var gibs:FlxEmitter;


		// restrict movement area  		
		protected var maxHorizontalMovement:int;
		private var speedX:int = 50;

		protected var count:int =0;
		public function Tank(X:int, Y:int,maxMove:int = 80)
		{			
			// always call super ctor before setting xp value etc						
			super(X,Y);
			xpValue = 200;
			health = 20;
			
			this.velocity.x = 200;
			loadGraphic(enemyImage,true,true);
			startingX = X;
			maxHorizontalMovement = maxMove;
			
			addAnimation("move",[0]);
 			this.gibs = FlxG.state.add(new BaseBloodGibs) as FlxEmitter; 
			play("move");
		}
		
		override public function update():void
		{
			if (this.x - this.startingX >= maxHorizontalMovement)
			{
				this.velocity.x = -speedX;
			}
			else if (this.x - this.startingX <= 0)
			{
				this.x  = this.startingX;
				this.velocity.x = speedX;
			}	
			
			if (count > 0)
				count -= FlxG.elapsed;
				
			if (count <= 0 && velocity.y == 0)
			{
				this.velocity.y = -100;
				count = 30;
			}
			
			
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