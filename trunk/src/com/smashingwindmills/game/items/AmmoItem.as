package com.smashingwindmills.game.items
{
	import com.smashingwindmills.game.Player;
	import com.smashingwindmills.game.weapon.FireGattler;
	
	public class AmmoItem extends BaseItem
	{
		[Embed(source="../media/temp/fire_bullet.png")]
		protected var sprite:Class;
		
		protected var _weaponType:Class;
		
		protected var _ammoCount:int = 10;
		
		public function AmmoItem()
		{
			super(0,0);
			loadGraphic(sprite);
			this.velocity.y = -200;
			weaponType = FireGattler;
		}
		
		override public function aquireLoot(p:Player):void
		{
			for (var i:int = 0; i < p.weapons.length; i++)
			{
				if (p.weapons[i] is weaponType)
				{
					p.weapons[i].ammo += ammoCount;
					if (p.weapons[i].ammo > p.weapons[i].currentMaxAmmo)
					{
						p.weapons[i].ammo = p.weapons[i].currentMaxAmmo;	
					}
					break;
				}
			}
		}
		
		public function get weaponType():Class
		{
			return _weaponType;
		}
		
		public function set weaponType(value:Class):void
		{
			_weaponType = value;
		}
		
		public function get ammoCount():int
		{
			return _ammoCount;	
		}
		
		public function set ammoCount(value:int):void
		{
			_ammoCount = value;
		}
	}
}