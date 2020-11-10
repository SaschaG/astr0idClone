package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;
import js.lib.Math;

class PlayState extends FlxState
{
	var bg:FlxSprite;
	var ship:FlxSprite;
	override public function create()
	{
		super.create();

		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.BG__png);
		bg.x = 0;
		bg.y =  0;
		add(bg);    

		ship = new FlxSprite();
		ship.loadGraphic(AssetPaths.Ship__png);
		ship.x = FlxG.width/2 -ship.width/2;
		ship.y = FlxG.height/2 -ship.height/2;
		add(ship);    
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if(FlxG.keys.pressed.LEFT){
			ship.angle -=1.5;
		}
		if(FlxG.keys.pressed.RIGHT){
			ship.angle +=1.5;
		}
		if(FlxG.keys.pressed.UP){

			FlxVelocity.accelerateFromAngle(ship,ship.angle * FlxAngle.TO_RAD,900,50,false);
		}
		if(FlxG.keys.pressed.DOWN){
			FlxVelocity.accelerateFromAngle(ship,ship.angle * FlxAngle.TO_RAD,900,50,false);
		}
	}
}
