package  
{
	import org.flixel.*;
	public class Player extends FlxSprite
	{
		
		public function Player() 
		{
			makeGraphic(4, 4);
		}
		override public function update():void
		{
			super.update();
			if (FlxG.keys.UP || FlxG.keys.W) {
				y -= 1;
			}
			if (FlxG.keys.DOWN || FlxG.keys.S) {
				y += 1;
			}
			if (FlxG.keys.LEFT || FlxG.keys.A) {
				x -= 1;
			}
			if (FlxG.keys.RIGHT || FlxG.keys.D) {
				x += 1;
			}
		}
	}

}