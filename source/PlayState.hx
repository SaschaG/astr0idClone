package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxAngle;
import flixel.math.FlxRandom;
import flixel.math.FlxVelocity;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Timer;
import js.lib.Math;
class PlayState extends FlxState
{
	var bg:FlxSprite;
	var ship:FlxSprite;
	var shot:FlxSprite;
	var activeShot = false;
	var shotTimer: FlxTimer;
	var astroids:Array<FlxSprite> = new Array();
	var highscore = 0;
	var hsText: FlxText;
	override public function create()
	{
		super.create();


		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.BG__png);
		bg.x = 0;
		bg.y =  0;
		add(bg);

		hsText = new FlxText(10,10, -1, 'Highscore ' + highscore, 12);
		hsText.draw();
		add(hsText);

		ship = new FlxSprite();
		ship.loadGraphic(AssetPaths.Ship__png);
		ship.x = FlxG.width/2 -ship.width/2;
		ship.y = FlxG.height/2 -ship.height/2;
		add(ship);
		
		shot = new FlxSprite();
		shot.loadGraphic(AssetPaths.Shot__png);

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
		
		var timer = new haxe.Timer(5000); 
		timer.run = function() { 
			var astroid:FlxSprite;
			var ran = new FlxRandom();
			astroid = new FlxSprite();
			var size = Math.floor(ran.float(0, 3));
			if(size == 0){
				astroid.loadGraphic(AssetPaths.Astroid_sm__png);
				astroid.health = 1;
			} else if(size == 1){
				astroid.loadGraphic(AssetPaths.Astroid_md__png);
				astroid.health = 2;
			} else if(size == 2){
				astroid.loadGraphic(AssetPaths.Astroid_LG__png);
				astroid.health = 3;
			}
			astroid.x = ran.float(0,FlxG.width);
			astroid.y = ran.float(0,FlxG.height);
			FlxVelocity.accelerateFromAngle(astroid, ran.float(0,360) * FlxAngle.TO_RAD,150,50,false);
			astroid.angularVelocity = ran.float(-100, 100);
			add(astroid);
			astroids.push(astroid);
			if(astroid.x < ship.x + 30 && astroid.x > ship.x - 30 &&
				astroid.y < ship.y + 30 && astroid.y > ship.y -30){
				astroid.x += 35;
				astroid.y += 35;
			}
		 }
		 shotTimer = new FlxTimer();
			shotTimer.start(-1, onTimer -> { 
				remove(shot);
				shot.kill();
				activeShot = false;
		 	},0);
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
		if(FlxG.keys.justPressed.SPACE && !activeShot){
			shot.revive();
			activeShot = true;
			shot.x = ship.x + ship.width / 2;
			shot.y = ship.y + ship.height / 2 - shot.height / 2;
			shot.angle = ship.angle;
			var vel = FlxVelocity.velocityFromAngle(ship.angle, 300);
			shot.velocity.x = vel.x;
			shot.velocity.y = vel.y;
			add(shot);
			shotTimer.reset(1.5);
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
		// shot screen borders
		if(shot.x > FlxG.width){
			shot.x = 0 - shot.width +1;
		}
		if(shot.y > FlxG.height){
			shot.y = 0 - shot.height +1;
		}
		if(shot.x <  0 - shot.width){
			shot.x = FlxG.width -1 ;
		}
		if(shot.y < 0 - shot.height ){
			shot.y = FlxG.height -1 ;
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
			if(FlxCollision.pixelPerfectCheck(astroid, ship)){
				// Game Over Screen here
				FlxG.switchState(new GameOver(highscore));
			}
			if(FlxCollision.pixelPerfectCheck(astroid, shot) && activeShot){
				highscore++;
				remove(hsText);
				hsText = new FlxText(10,10, -1, 'Highscore ' + highscore, 12);
				add(hsText);
				astroid.health--;
				
				if( astroid.health > 0 ){
					for(i in 0...2){
						var newAstroid:FlxSprite;
						var ran = new FlxRandom();
						newAstroid = new FlxSprite();
						if(astroid.health == 2){
							newAstroid.loadGraphic(AssetPaths.Astroid_md__png);
							newAstroid.health = 2;
						} else if(astroid.health == 1){
							newAstroid.loadGraphic(AssetPaths.Astroid_sm__png);
							newAstroid.health = 1;
						}
						newAstroid.x = astroid.x;
						newAstroid.y = astroid.y;
						FlxVelocity.accelerateFromAngle(newAstroid, ran.float(0,360) * FlxAngle.TO_RAD,150,50,false);
						newAstroid.angularVelocity = ran.float(-100, 100);
						add(newAstroid);
						astroids.push(newAstroid);
					}
				}
				
				remove(astroid);
				remove(shot);
				shotTimer.active = false;
				activeShot = false;
				astroids.remove(astroid);
				astroid.destroy();	
			}
		};

		
		
	}
}

class GameOver extends FlxState
{
	var highscore = 0;
	public function new(highscore: Int) 
	{
    	super();
    	this.highscore = highscore;
	}
	override public function create()
	{
		super.create();

		var hsText = new FlxText(190,200, -1, 'Highscore ' + highscore, 36);
		hsText.draw();
		add(hsText);

		var restartText = new FlxText(190,260, -1, 'Press R to restart', 24);
		restartText.draw();
		add(restartText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if(FlxG.keys.pressed.R){
			FlxG.switchState(new PlayState());
		}
	}
}
