package  
{
	import org.flixel.*;
	public class GITDIntroState extends FlxState
	{
		
		[Embed(source = "../assets/gitdScaled.png")]
		private	var GITD:Class;
		
		private var tick:int = 0;
		private var gitd:FlxSprite;
 
		public function GITDIntroState() 
		{
			gitd = new FlxSprite(0, 10);
			gitd.loadGraphic(GITD);
			gitd.alpha = 0;
			add(gitd);
		}
		override public function update():void
		{
			tick++;
			if (tick < 100) {
				gitd.alpha = tick/100;
			}
			else if (tick < 200) {
				gitd.alpha = (200 - tick)/100;
			}
			else {
				FlxG.switchState(new LogoIntroState());
			}
		}
	}

}