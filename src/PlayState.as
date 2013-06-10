package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{	
		private var dm:DungeonMap;
		private var player:Player;
		private var exit:FlxSprite;
		private var gui:GUI;
		public var level:int;
		public var timeLeft:uint;
		
		override public function create():void
		{
			level = 1;
			timeLeft = 3000;
			
			FlxG.bgColor = 0xffaaaaaa;
			dm = new DungeonMap();
			add(dm);
			
			exit = new FlxSprite();
			exit.makeGraphic(dm.width / dm.widthInTiles-2, dm.height / dm.heightInTiles-2, 0xff999999);
			var exitPos:FlxPoint = dm.findEmptySpot();
			exit.x = exitPos.x * dm.width / dm.widthInTiles+1;
			exit.y = exitPos.y * dm.height / dm.heightInTiles+1;
			add(exit);
			
			player = new Player();
			var playerPos:FlxPoint = dm.findEmptySpot();
			player.x = playerPos.x * dm.width / dm.widthInTiles+1;
			player.y = playerPos.y * dm.height / dm.heightInTiles+1;
			add(player);
			
			gui = new GUI();
			add(gui);
			
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = dm.width;
			FlxG.worldBounds.height = dm.height;
			FlxG.camera.setBounds(0, 0, dm.width, dm.height);
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			FlxG.watch(this, "level");
		}
		
		private function resetDungeon():void
		{
			remove(dm);
			dm = new DungeonMap();
			add(dm);
			var playerPos:FlxPoint = dm.findEmptySpot();
			player.x = playerPos.x * dm.width / dm.widthInTiles+1;
			player.y = playerPos.y * dm.height / dm.heightInTiles + 1;			
			var exitPos:FlxPoint = dm.findEmptySpot();
			exit.x = exitPos.x * dm.width / dm.widthInTiles+1;
			exit.y = exitPos.y * dm.height / dm.heightInTiles + 1;
			remove(gui);
			add(gui);
		}
		
		override public function update():void
		{
			super.update();
			gui.level = level;
			gui.time = timeLeft;
			FlxG.collide(dm, player);		
			checkComplete();
			if (timeLeft <= 1) {
				//game over
				GameOver.finalLevel = level;
				FlxG.switchState(new GameOver());
			}
			else {
				timeLeft -= 1;
			}
		}
		
		
		private function checkComplete():void
		{
			if (FlxG.overlap(exit, player)) {
				//level complete
				level++;
				timeLeft += 100;
				if (level % 3 == 0) {
					DungeonMap.FEATURE_TRIES += 5;
				}
				resetDungeon();
			}
		}
	}
}