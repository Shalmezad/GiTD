package  
{
	import org.flixel.*;
	public class TitleState extends FlxState
	{
		
		public function TitleState() 
		{
			add(new FlxText(20, 20, 100, ".explore"));
			add(new FlxText(20, 30, 100, "Click to start"));
		}
		override public function update():void
		{
			if (FlxG.mouse.justPressed()) {
				FlxG.switchState(new PlayState());
			}
		}
	}

}