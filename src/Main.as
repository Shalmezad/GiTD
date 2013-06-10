package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
 
	
	//______KONG STUFF__________
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	 //______END KONG STUFF__________	
	
	public class Main extends FlxGame
	{
		
		// Pull the API path from the FlashVars
		var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;

		// The API path. The "shadow" API will load if testing locally. 
		var apiPath:String = paramObj.kongregate_api_path || 
		  "http://www.kongregate.com/flash/API_AS3_Local.swf";
		  
		// Kongregate API reference
		public static var kongregate:*;
		
		public function Main()
		{
			// Allow the API access to this SWF
			Security.allowDomain(apiPath);

			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);
			
			
			super(128,96,GITDIntroState,5);
		}
		// This function is called when loading is complete
		function loadComplete(event:Event):void
		{
			// Save Kongregate API reference
			kongregate = event.target.content;

			// Connect to the back-end
			kongregate.services.connect();
		}
	}
}