package  
{
	import org.flixel.*;
	public class DungeonMap extends FlxTilemap
	{
		private static const DUNGEON_WIDTH:uint = 200;
		private static const DUNGEON_HEIGHT:uint = 200;
		
		private var map:Array;
		
		public static var FEATURE_TRIES:uint = 20;
		public static var CORRIDORS_PER_ROOM:uint = 6;
		
		public function DungeonMap() 
		{
			initMap();	
			loadMap(FlxTilemap.arrayToCSV(map,DUNGEON_WIDTH), FlxTilemap.ImgAuto, 0, 0, FlxTilemap.AUTO);
		}
		
		private function initMap():void
		{
			map = new Array();
			for (var x:int = 0; x < DUNGEON_WIDTH; x++) {
				for (var y:int = 0; y < DUNGEON_HEIGHT; y++) {
					map.push(1);
				}
			}
			digRect(new FlxRect(DUNGEON_WIDTH/2 - 2, DUNGEON_HEIGHT/2-2, 4, 4));
			for (var a:int = 0; a < FEATURE_TRIES; a++) {
				for (var b:int = 0; b < CORRIDORS_PER_ROOM; b++) {
					addCorridor();
				}
				addRoom();
			}
		}
		
		private function digRect(rect:FlxRect):void
		{
			for (var x:int = rect.x; x < rect.x + rect.width; x++) {
				for (var y:int = rect.y; y < rect.y + rect.height; y++) {
					map[y*DUNGEON_WIDTH + x] = 0;
				}
			}
		}
		
		private function getSquare(x:int, y:int):uint
		{
			return map[y * DUNGEON_WIDTH + x];
		}
		
		public function findRoomWall():FlxPoint
		{
			var wall:FlxPoint = new FlxPoint( -1, -1);
			
			while(wall.x == -1){
				//pick a point.
				var x:int = randomIntBetween(1, DUNGEON_WIDTH - 2);
				var y:int = randomIntBetween(1, DUNGEON_HEIGHT - 2);
				if(getSquare(x,y) == 1){
					//is there a clear spot around it?
					if(getSquare(x+1,y) == 0 ||
					   getSquare(x-1,y) == 0 ||
					   getSquare(x,y+1) == 0 ||
					   getSquare(x,y-1)== 0)
					{
						wall.x = x;
						wall.y = y;
						return wall;
					}
				}
			}
			return wall;
		}
		
		public function findEmptySpot():FlxPoint
		{
			var wall:FlxPoint = new FlxPoint( -1, -1);
			
			while(wall.x == -1){
				//pick a point.
				var x:int = randomIntBetween(1, DUNGEON_WIDTH - 2);
				var y:int = randomIntBetween(1, DUNGEON_HEIGHT - 2);
				if(getSquare(x,y) == 0){
					wall.x = x;
					wall.y = y;
					return wall;
				}
			}
			return wall;
		}
		
		private function rectInBounds(rect:FlxRect):Boolean
		{
			//verify x
			if (rect.x < 1 || rect.x >= DUNGEON_WIDTH-1) {
				return false;
			}
			//verify y
			if (rect.y < 1 || rect.y >= DUNGEON_HEIGHT-1) {
				return false;
			}
			//verify w
			if (rect.right >= DUNGEON_WIDTH-1) {
				return false;
			}
			//verify h
			if (rect.bottom >= DUNGEON_HEIGHT-1) {
				return false;
			}
			
			//if it's passed so far, we're good to go.
			return true;
		}
		
		private function hasOpenSpace(check:FlxRect):Boolean
		{
			for (var x:int = check.x; x < check.right; x++)
			{
				for (var y:int = check.y; y < check.bottom; y++) {
					if (getSquare(x, y) == 0) {
						return true;
					}
				}
			}
			return false;
		}
		
		private function addCorridor():void
		{
			//Alright, time to start digging.
			//First, where are we starting?
			var corStart:FlxPoint = findRoomWall();
			//Alright, how big is the corridor?
			var corridor:FlxRect = new FlxRect(corStart.x, corStart.y, 1, 1);
			var corridorBounds:FlxRect = new FlxRect(corStart.x, corStart.y, 1, 1);
			if (randomIntBetween(1, 2) == 1) {
				//horizontal corridor
				corridor.width = randomIntBetween(2, 6);
				//shift?
				if (randomIntBetween(1, 2) == 1) {
					corridor.x -= corridor.width-1;
				}
				
				corridorBounds.x = corridor.x;
				corridorBounds.y = corridor.y - 1;
				corridorBounds.width = corridor.width;
				corridorBounds.height = 3;
				
				//is it legal?
				if (!rectInBounds(corridorBounds)){
					return;
				}
				//It's legal. 
				//Is there any open spots?
				if (hasOpenSpace(corridorBounds)) {
					return;
				}
				
				//Good to go, dig.
				digRect(corridor);
			}
			else {
				//vertical corridor
				corridor.height = randomIntBetween(2, 6);
				corridorBounds.x -= 1;
				corridorBounds.width = 3;
				corridorBounds.height = corridor.height;
				//shift?
				if (randomIntBetween(1, 2) == 1) {
					corridor.y -= corridor.height-1;
					corridorBounds.y -= corridorBounds.height-1;
				}
				//is it legal?
				if (!rectInBounds(corridorBounds)) {
					return;
				}
				//Is there any open spots?
				if (hasOpenSpace(corridorBounds)) {
					return;
				}
				//Dig.
				digRect(corridor);
			}
		}
		
		private function addRoom():void
		{
			//find a wall.
			var roomStart:FlxPoint;
			roomStart = findRoomWall();
			//make the room rectangle
			var roomRect:FlxRect = new FlxRect();
			roomRect.x = roomStart.x;
			roomRect.y = roomStart.y;
			roomRect.width = randomIntBetween(2, 8);
			roomRect.height = randomIntBetween(2, 8);
			
			//shift x?
			if (randomIntBetween(1, 2) == 1) {
				roomRect.x -= roomRect.width - 1;
			}
			//shift y?
			if (randomIntBetween(1, 2) == 1) {
				roomRect.y -= roomRect.height - 1;
			}
			
			//Are we legal?
			if (!rectInBounds(roomRect)) {
				return;
			}
			//are there any open spots?
			if (hasOpenSpace(roomRect)) {
				return;
			}
			//good to go
			digRect(roomRect);
		}
		
		
		//http://stackoverflow.com/questions/5450897/as3-how-can-i-generate-a-random-number
		private function randomIntBetween(min:int, max:int):int {
			return Math.round(Math.random() * (max - min) + min);
		}
		
	}

}