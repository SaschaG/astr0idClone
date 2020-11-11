package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.math.FlxVelocity;
import js.lib.Math;

class PlayState extends FlxState
{
	var bg:FlxSprite;
	var ship:FlxSprite;
	var astroids:Array<FlxSprite> = new Array();
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

		for (i in 0...5){
			var astroid_sm:FlxSprite;
			var ran = new FlxRandom();
			astroid_sm = new FlxSprite();
			astroid_sm.loadGraphic(AssetPaths.Astroid_sm__png);
			astroid_sm.x = ran.float(0,FlxG.width);
			astroid_sm.y = ran.float(0,FlxG.height);
			FlxVelocity.accelerateFromAngle(astroid_sm, ran.float(0,360) * FlxAngle.TO_RAD,150,50,false);
			astroid_sm.angularVelocity = ran.float(-100, 100);
			astroids.push(astroid_sm);
			add(astroid_sm);
			
		}
		
		
		
		
		var timer = new haxe.Timer(5000); // 1000ms delay
		timer.run = function() { 
			var astroid_sm:FlxSprite;
			var ran = new FlxRandom();
			astroid_sm = new FlxSprite();
			astroid_sm.loadGraphic(AssetPaths.Astroid_sm__png);
			astroid_sm.x = ran.float(0,FlxG.width);
			astroid_sm.y = ran.float(0,FlxG.height);
			FlxVelocity.accelerateFromAngle(astroid_sm, ran.float(0,360) * FlxAngle.TO_RAD,150,50,false);
			astroid_sm.angularVelocity = ran.float(-100, 100);
			add(astroid_sm);
			astroids.push(astroid_sm);
		 }
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if(!FlxG.keys.pressed.UP && !FlxG.keys.pressed.DOWN){
			if(ship.velocity.x < 10 && ship.velocity.x > -10 && ship.velocity.y > -10 && ship.velocity.y < 10){
				FlxVelocity.accelerateFromAngle(ship,(ship.angle -180) * FlxAngle.TO_RAD,0,150,true);
			} else {
				FlxVelocity.accelerateFromAngle(ship,(ship.angle -180) * FlxAngle.TO_RAD,20,150,false);
			}
			
		}
		if(FlxG.keys.pressed.LEFT){
			ship.angle -=2;
			FlxVelocity.velocityFromAngle(ship.angle, ship.velocity.x + ship.velocity.y);
		}
		 if(FlxG.keys.pressed.RIGHT){
			ship.angle +=2;
			FlxVelocity.velocityFromAngle(ship.angle, ship.velocity.x + ship.velocity.y);
		}
		 if(FlxG.keys.pressed.UP){
			
			FlxVelocity.accelerateFromAngle(ship,ship.angle * FlxAngle.TO_RAD,150,150,false);
		}
		 if(FlxG.keys.pressed.DOWN){
			FlxVelocity.accelerateFromAngle(ship,(ship.angle -180) * FlxAngle.TO_RAD,150,150,false);
		}


		// ship screen borders
		if(ship.x > FlxG.width){
			ship.x = 0 - ship.width +1;
		}
		if(ship.y > FlxG.height){
			ship.y = 0 - ship.height +1;
		}
		if(ship.x <  0 - ship.width){
			ship.x = FlxG.width -1 ;
		}
		if(ship.y < 0 - ship.height ){
			ship.y = FlxG.height -1 ;
		}

		//astroid
		for(astroid in astroids){
			if(astroid.x > FlxG.width){
				astroid.x = 0 - astroid.width +1;
			}
			if(astroid.y > FlxG.height){
				astroid.y = 0 - astroid.height +1;
			}
			if(astroid.x <  0 - astroid.width){
				astroid.x = FlxG.width -1 ;
			}
			if(astroid.y < 0 - astroid.height ){
				astroid.y = FlxG.height -1 ;
			}
		};
		
	}
}
