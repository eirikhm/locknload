package com.smashingwindmills.game
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite
	{
		[Embed(source="../media/player/player.png")]
		protected var playerSprite:Class;
		protected static const PLAYER_START_X:int = 300;
		protected static const PLAYER_START_Y:int = 300;
		protected static const PLAYER_RUN_SPEED:int = 80;
		protected static const GRAVITY_ACCELERATION:int = 420;
		protected static const JUMP_ACCELERATION:int = 200;

		protected static const BULLET_VELOCITY:Number = 360;
		protected static const BULLET_BOOST:Number = 36;
		public var BULLET_DAMAGE:Number = 0.5;
		  
		protected var bullets:Array;
		protected var currentBullet:uint = 0;
		protected var aimingUp:Boolean = false;
		protected var aimingDown:Boolean = false;

		public var level:int = 1;
		protected var experience:int = 0;
		
		protected var is_double:Boolean = false;
		public function Player(playerBullets:Array)
		{
			super(0,0);
			this.bullets = playerBullets;
			loadGraphic(playerSprite,true,true);
			
			drag.x = PLAYER_RUN_SPEED * 8;
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 0], 12);
			addAnimation("jump", [4]);
			addAnimation("idle_up", [5]);
			addAnimation("run_up", [6, 7, 8, 5], 12);
			addAnimation("jump_up", [9]);
			addAnimation("jump_down", [10]);
		}
		
		
		override public function update():void
		{
			
			if (FlxG.score > 100)
			{
				level = 2;
				BULLET_DAMAGE = 2;
			}
						
			
			aimingDown = false;
			aimingUp = false;
			
			if (FlxG.keys.UP)
				aimingUp = true;
			else if (FlxG.keys.DOWN)
				aimingDown = true;
				
			if (FlxG.keys.justPressed("C"))
			{
				var bXVel:int = 0;
				var bYVel:int = 0;
				var bX:int = x;
				var bY:int = y;
				if (aimingUp)
				{
					bY -= bullets[currentBullet].height -4;
					bYVel = -BULLET_VELOCITY;
				}
				else if (aimingDown)
				{
					bY += height -4;
					bYVel = BULLET_VELOCITY;
					velocity.y -= BULLET_BOOST;
				}
				else if (facing == RIGHT)
				{
					bX += width -4;
					bXVel = BULLET_VELOCITY;
				}
				else
				{
					bX -= bullets[currentBullet].width -4;
					bXVel = -BULLET_VELOCITY;
				}
				bullets[currentBullet].shoot(bX,bY,bXVel,bYVel);
				++currentBullet;
				currentBullet %= bullets.length;
				
			}				
				
			acceleration.x = 0;
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x = -drag.x;
			}
			else if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				acceleration.x = drag.x;				
			}
			
			if (FlxG.keys.justPressed("X") && !velocity.y)
			{
				velocity.y = -JUMP_ACCELERATION;
			}
			else if (FlxG.keys.justPressed("X") && velocity.y)
			{
				if (!is_double)
				{
					velocity.y = -JUMP_ACCELERATION;
					is_double = true;	
				}
			}
			
			if (velocity.y != 0)
			{
				play("jump");
			}
			else if (velocity.x == 0)
			{
				is_double = false;
				play("idle");
			}
			else
			{
				is_double = false;
				play("run");
			}
			
			super.update();
		}
	}
}