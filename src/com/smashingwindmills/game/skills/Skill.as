package com.smashingwindmills.game.skills
{
	public class Skill
	{
		protected var _id:String;
		protected var _name:String;
		protected var _levels:Array;
		protected var _currentLevel:int = 0;
		
		public function Skill(i:String, n:String, l:Array = null)
		{
			id = i;
			name = n;
			levels = l;
			
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get levels():Array
		{
			if (!_levels)
				_levels = new Array();
			return _levels;
		}
		
		public function set levels(value:Array):void
		{
			_levels = value;
		}
		
		public function get currentLevel():int
		{
			return _currentLevel;
		}
		
		public function set currentLevel(value:int):void
		{
			_currentLevel = value;
		}

	}
}