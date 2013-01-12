<div align="center"> <h1>WELCOME TO ADVANCED_JOYSTICK<h1> </div>
<br/><br/>

**Getting Started**
-------------------
Hey there. If you're reading this, it is likely you are looking for a Joystick solution for Starling. **Well you've 
found it!*. This Joystick offers features you'd expect from one, and it runs smoothly with the GPU Acceleration that 
Starling provides. To get started, you should:

----

- Download the files from the Repository.
- Extract the source files to 'starling/extensions/'
- Check the example project to see how to implement this Joystick.

<br/><br/>

**Please Note**
----------------
If you are not planning on using the default skin of the Joystick, the please open the file 'JoyStick.as' and then
COMMENT OUT these lines of code:

----

`[Embed( source="skins/default_stick.png" )] private static const dsClassEmbed:Class;\n
public static const DEFAULT_STICK:Texture = Texture.fromBitmap( new dsClassEmbed() );\n
[Embed( source="skins/default_holder.png" )] private static const dhClassEmbed:Class;\n
public static const DEFAULT_HOLDER:Texture = Texture.fromBitmap( new dhClassEmbed() );`
