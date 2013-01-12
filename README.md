<div align="center"> <h1>WELCOME TO ADVANCED_JOYSTICK<h1> </div>
<br/><br/>

<div align="center"><h2>Getting Started</h2></div>
Hey there. If you're reading this, it is likely you are looking for a Joystick solution for Starling. **Well you've 
found it!*. This Joystick offers features you'd expect from one, and it runs smoothly with the GPU Acceleration that 
Starling provides. To get started, you should:

----

- Download the files from the Repository.
- Extract the source files to 'starling/extensions/'
- Check the example project to see how to implement this Joystick.

<br/><br/>

**Usage**
----------
The code in Advanced Joystick is **very** simple. Now, lets start with adding a simple JoyStick:

<pre><code>import starling.extensions.advancedjoystick.JoyStick;

var myJoystick:Joystick = new Joystick();
myJoystick.setPosition(myJoystick.minOffsetX, clientHeight - myJoystick.minOffsetY);
addChild(myJoystick);
</code></pre>

The above code would initialize the Joystick with the Default Skin. The Joystick will then be positioned at the 
bottom left of the screen since `minOffset` is the total size of the joystick, meaning that it will all be in the 
screen. The Joystick is then added to the Starling Display List.

----

Now, for getting the movement from the Joystick, this is also **very** simple. Let's use some simple code to move 
a simple object. Let's assume `player` is a Starling Sprite:

<pre><code>player.x += myJoystick.velocityX * maxSpeed;
player.y += myJoystick.velocityY * maxSpeed;
</code></pre>

That's it. Run that code every frame and your object will move according to the Joystick. The values of `velocityX` and 
`velocityY` are returned as normalized values, meaning that the value is between 0 and 1. This is for your benefit as 
you can multiply this by a maximum value to move and object depending on the distance of the stick from the center of 
the holder.

<br/><br/>

**Please Note**
----------------
If you are not planning on using the default skin of the Joystick, the please open the file 'JoyStick.as' and then
COMMENT OUT these lines of code:

----

<pre><code>[Embed( source="skins/default_stick.png" )] private static const dsClassEmbed:Class;
public static const DEFAULT_STICK:Texture = Texture.fromBitmap( new dsClassEmbed() );
[Embed( source="skins/default_holder.png" )] private static const dhClassEmbed:Class;
public static const DEFAULT_HOLDER:Texture = Texture.fromBitmap( new dhClassEmbed() );>/code></pre>
