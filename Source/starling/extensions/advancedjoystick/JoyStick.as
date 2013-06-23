package starling.extensions.advancedjoystick
{
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	
	public class JoyStick extends Sprite
	{
		
		// PLEASE COMMENT OUT THESE VARIABLES AND EMBEDS IF YOU'RE NOT USING THE DEFAULT SKINS.
		[Embed( source="skins/default_stick.png" )] private static const dsClassEmbed:Class;
		public static const DEFAULT_STICK:Texture = Texture.fromBitmap( new dsClassEmbed() );
		[Embed( source="skins/default_holder.png" )] private static const dhClassEmbed:Class;
		public static const DEFAULT_HOLDER:Texture = Texture.fromBitmap( new dhClassEmbed() );
		
		// Velocities are given as normalized values (0-1).
		private var _velocityX:Number = 0;
		private var _velocityY:Number = 0;
		private var _minOffsetX:Number;
		private var _minOffsetY:Number;
		private var _touched:Boolean = false;
		
		private var stickRadius:Number;
		private var holderRadius:Number;
		private var maximumVelocityX:Number;
		private var maximumVelocityY:Number;
		private var pivotPoint:Point;
		private var holder:Image;
		private var stick:Image;
		private static const errorMessage:String = "You are trying to initialize a JoyPad with the "+
													"default skin, but you have removed the the lines of code "+
													"that Embed this skin. Please uncomment the Embed Code.";
		
                
		public function JoyStick(holderTexture:Texture = null,
								 stickTexture:Texture = null,
								 activateImmediately:Boolean = true)
		{
			super();
			if( holderTexture == null && JoyStick["DEFAULT_HOLDER"] ) holderTexture = JoyStick["DEFAULT_HOLDER"];
			if( stickTexture == null && JoyStick["DEFAULT_STICK"] ) stickTexture = JoyStick["DEFAULT_STICK"];
			if( stickTexture == null || holderTexture == null ) 
				throw new Error(errorMessage, 01);
			
			initialize( holderTexture, stickTexture, activateImmediately );
		}
		
		
		public function setPosition( _x:Number, _y:Number ):void
		{
			x = _x;
			y = _y;
		}
		
		
		public function get velocityY():Number
		{
			return _velocityY;
		}
		
		
		public function get minOffsetY():Number
		{
			return _minOffsetY;
		}
		
		
		public function get touched():Boolean
		{
			if( velocityX == 0 && velocityY == 0 ) _touched = false;
			return _touched;
		}
		
		
		public function get minOffsetX():Number
		{
			return _minOffsetX;
		}
		
		
		public function get velocityX():Number
		{
			return _velocityX;
		}


		public function activate():void
		{
			if( stick.hasEventListener(TouchEvent.TOUCH) ) return;
			
			stick.addEventListener( TouchEvent.TOUCH, onJoystickTouch );
		}
		
		
		public function deactivate():void
		{
			if( !stick.hasEventListener( TouchEvent.TOUCH ) ) return;
			
			stick.removeEventListener( TouchEvent.TOUCH, onJoystickTouch );
			resetStick();
		}
		
		
		private function initialize( holderTexture:Texture,
									 stickTexture:Texture,
									 activateImmediately:Boolean = true):void
		{
			if( holder ) { holder.dispose(); removeChild( holder ); }
			if( stick ) { stick.dispose(); stick.removeEventListener(TouchEvent.TOUCH, onJoystickTouch); removeChild( stick ); }
			
			holder = new Image( holderTexture );
			stick = new Image( stickTexture );
			stick.pivotX = stick.width/2; stick.pivotY = stick.height / 2;
			
			resetStick();
			stickRadius = stick.pivotX;
			holderRadius = holder.pivotX;
			
			addChild( holder );
			addChild( stick );
			holder.touchable = false;
			
			pivotX = holder.width / 2; pivotY = holder.height / 2;
			maximumVelocityX = holder.width / 2;
			maximumVelocityY = holder.height / 2;
			_minOffsetX = (holder.width / 2) + stick.width / 2; 
			_minOffsetY = (holder.height / 2) + stick.height / 2; 
			
			pivotPoint = new Point(pivotX, pivotY);
			if( activateImmediately ) activate();
		}		
		
		
		public function changeSkin( holderTexture:Texture, stickTexture:Texture ):void
		{
			initialize( holderTexture, stickTexture, true );
		}
		
		
		private function onJoystickTouch(evt:TouchEvent):void
		{
			var touches:Vector.<Touch> = evt.getTouches(this);
			if(!touches.length) {
				return;
			}
			var touch:Touch = touches[0];
			_touched = true;
			switch( touch.phase )
			{
				case TouchPhase.BEGAN:
					pivotPoint.x = touch.globalX - pivotX + stick.x;
					pivotPoint.y = touch.globalY - pivotY + stick.y;
				case TouchPhase.MOVED:
					moveJoystick(touch.globalX, touch.globalY);
					break;
				case TouchPhase.ENDED:
					resetStick();
					break;
			}
			
			_velocityX = (stick.x - pivotX) / maximumVelocityX;
			_velocityY = (stick.y - pivotY) / maximumVelocityY;
		}		
		
		
		private function resetStick():void
		{
			_touched = false;
			stick.x = holder.width / 2;
			stick.y = holder.height / 2;
		}		
		
		
		private function moveJoystick( touchX:Number, touchY:Number ):void
		{
			var distX:Number = (touchX - pivotPoint.x);
			var distY:Number = (touchY - pivotPoint.y);
			stick.x = distX + pivotX; stick.y = distY + pivotY;
			
			var dis:Number = Math.sqrt((distX * distX) + (distY * distY));
			
			if( Math.abs(dis) > pivotX )
			{
				var force:Number = dis-pivotX;
				stick.x -= distX/dis*force;
				stick.y -= distY/dis*force;
			}
		}

		
	}
	
}
