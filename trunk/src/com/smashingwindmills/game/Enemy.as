package com.smashingwindmills.game
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Enemy extends FlxSprite
	{
		[Embed(source="../media/temp/enemy_preview.png")]
		protected var enemyImage:Class;
		
		[Embed(source="../media/temp/enemygibs.png")]
		protected var EnemyGibsImage:Class;
  			protected var gibs:FlxEmitter;
  
  		protected static const GRAVITY_ACCELERATION:int = 420;

		protected static const ENEMY_SPEED:Number = 20;
		protected static const ENEMY_HEALTH:int = 2;
		protected var startingX:int;
		protected var maxHorizontalMovement:int;


		public function Enemy(X:int, Y:int,maxMove:int = 80)
		{
				
			super(0,0);
			loadGraphic(enemyImage,true,true);
			y = Y;
			x = X;
			startingX = X;
			maxHorizontalMovement = maxMove;
			health = ENEMY_HEALTH;
			this.velocity.x = ENEMY_SPEED;
			addAnimation("move",[0]);
  		/*
  		
  		 this.gibs = FlxG.state.add(new FlxEmitter(0,0,0,0,null,-1.5,-150,150,-200,
      0,-720,720,400,0,EnemyGibsImage,20,true)) as FlxEmitter;


*/
  			var emitter:FlxEmitter = new FlxEmitter();
  			emitter.createSprites(EnemyGibsImage);
  			emitter.x = 0;
  			emitter.y = 0;
  			emitter.delay = -1.5;
  			emitter.width = 0;
  			emitter.minVelocity.y = -250;
  			emitter.maxVelocity.x = 250;
  			emitter.minRotation = -200;
  			emitter.maxRotation = 200;
  			emitter.gravity = 720;
  			emitter.drag = 200;
  		
  			
 			 this.gibs = FlxG.state.add(emitter) as FlxEmitter; 
			acceleration.y = GRAVITY_ACCELERATION;

			play("move");
		}

		override public function update():void
		{
			if (this.x - this.startingX >= maxHorizontalMovement)
			{
				this.velocity.x = -ENEMY_SPEED;
				facing = LEFT;
			}
			else if (this.x - this.startingX <= 0)
			{
				this.x  = this.startingX;
				this.velocity.x = ENEMY_SPEED;
				facing = RIGHT;
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