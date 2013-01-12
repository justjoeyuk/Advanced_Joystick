package  
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import flash.events.Event;
	
	
	public class Main extends Sprite
	{
		
		private var starlingInstance:Starling;
		
		public function Main() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		private function onAdded( evt:Event ):void
		{
			starlingInstance = new Starling( Game, stage );
			starlingInstance.start();
		}
		
		
	}
	
}