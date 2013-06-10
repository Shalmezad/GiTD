package  
{
	import org.flixel.*;
	public class GameOver extends FlxState
	{
		public static var finalLevel:int = 0;
		private var tick:int = 0;
		public function GameOver() 
		{
			FlxG.bgColor = 0xff000000;
			add(new FlxText(10, 10, 100, "GAME OVER"));
			add(new FlxText(10, 20, 100, "Level: " + finalLevel.toString()));
			Main.kongregate.stats.submit("highLevel",finalLevel);
		}
		
		override public function update():void
		{
			if (FlxG.mouse.justPressed()) {
				FlxG.switchState(new TitleState());
			}
			else {
				tick++;
				if (tick > 150) {
					FlxG.switchState(new TitleState());
				}
			}
		}
		
	}

}