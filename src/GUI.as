package  
{
	import org.flixel.*;
	public class GUI extends FlxGroup
	{
		private var timeText:FlxText;
		private var levelText:FlxText;
		public var level:int = 1;
		public var time:int = 3000;
		
		public function GUI() 
		{
			levelText = new FlxText(0, 0, 100, "Level: 1");
			levelText.scrollFactor.x = 0;
			levelText.scrollFactor.y = 0;
			add(levelText);
			timeText = new FlxText(60, 0, 100, "Time: 3000");
			timeText.scrollFactor.x = 0;
			timeText.scrollFactor.y = 0;
			add(timeText);
		}
		
		override public function update():void
		{
			levelText.text = "Level: " + level.toString();
			timeText.text = "Time: " + time.toString();
		}
	}

}