import sandy.core.Scene3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.Shape3D;
import sandy.core.scenegraph.TransformGroup;
import sandy.events.SandyEvent;
import sandy.events.QueueEvent;
import sandy.materials.Appearance;
import sandy.materials.BitmapMaterial;
import sandy.parser.IParser;
import sandy.parser.Parser;
import sandy.parser.ParserStack;
import sandy.util.LoaderQueue;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.net.URLRequest;
import flash.Lib;

class ColladaCar extends Sprite {
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var tg:TransformGroup;
		private var car:Shape3D;
		private var wheelLF:Shape3D;
		private var wheelRF:Shape3D;
		private var wheelLR:Shape3D;
		private var wheelRR:Shape3D;
		private var queue:LoaderQueue;
		private var parserStack:ParserStack;

		public function new () { 
				super(); 
		timer = flash.Lib.getTimer();

				var parser:IParser = Parser.create("../assets/models/COLLADA/car.DAE",Parser.COLLADA );
				var parserLF:IParser = Parser.create("../assets/models/COLLADA/wheel_Front_L.DAE",Parser.COLLADA );
				var parserRF:IParser = Parser.create("../assets/models/COLLADA/wheel_Front_R.DAE",Parser.COLLADA );
				var parserLR:IParser = Parser.create("../assets/models/COLLADA/wheel_Rear_L.DAE",Parser.COLLADA );
				var parserRR:IParser = Parser.create("../assets/models/COLLADA/wheel_Rear_R.DAE",Parser.COLLADA );

				parserStack = new ParserStack();
				parserStack.add("carParser",parser);
				parserStack.add("wheelLFParser",parserLF);
				parserStack.add("wheelRFParser",parserRF);
				parserStack.add("wheelLRParser",parserLR);
				parserStack.add("wheelRRParser",parserRR);
				parserStack.addEventListener(ParserStack.COMPLETE, parserComplete );
				parserStack.start();

		}

		private function parserComplete(pEvt:Event ):Void
		{
				car = untyped parserStack.getGroupByName("carParser").children[0];
				wheelLF = untyped parserStack.getGroupByName("wheelLFParser").children[0];
				wheelRF = untyped parserStack.getGroupByName("wheelRFParser").children[0];
				wheelLR = untyped parserStack.getGroupByName("wheelLRParser").children[0];
				wheelRR = untyped parserStack.getGroupByName("wheelRRParser").children[0];
				loadSkins();
				trace( flash.Lib.getTimer() - timer );
		}
var timer : Float;


		private function loadSkins(){
				queue = new LoaderQueue();
				queue.add( "carSkin", new URLRequest("../assets/textures/car.jpg") );
				queue.add( "wheels", new URLRequest("../assets/textures/wheel.jpg") ); 
				queue.addEventListener(SandyEvent.QUEUE_COMPLETE, loadComplete );
				queue.start();
		}

		// Create the scene graph based on the root Group of the scene
		private function loadComplete(event:QueueEvent)
		{
				camera = new Camera3D( 600, 300 );
				camera.y = 30;
				camera.z = -200;
				camera.near = 10;

				var root:Group = createScene();
				scene = new Scene3D( "scene", this, camera, root );

				addEventListener( Event.ENTER_FRAME, enterFrameHandler );
				Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedHandler);

				Lib.current.stage.addChild(this);
		}

		private function createScene():Group
		{
				var g:Group = new Group();

				tg = new TransformGroup('myGroup');

				var material:BitmapMaterial = new BitmapMaterial( Reflect.field( queue.data.get( "carSkin" ), "bitmapData" ) );
				var app:Appearance = new Appearance( material );
				car.appearance = app;

				var materialW:BitmapMaterial = new BitmapMaterial( Reflect.field( queue.data.get( "wheels" ), "bitmapData" ) );
				var appW:Appearance = new Appearance( materialW );
				wheelLF.appearance = appW;
				wheelRF.appearance = appW;
				wheelLR.appearance = appW;
				wheelRR.appearance = appW;

				car.useSingleContainer = false;
				wheelLF.useSingleContainer = false;
				wheelRF.useSingleContainer = false;
				wheelLR.useSingleContainer = false;
				wheelRR.useSingleContainer = false;

				tg.addChild( wheelLF );
				tg.addChild( wheelRF );
				tg.addChild( wheelLR );
				tg.addChild( wheelRR );
				tg.addChild( car );

				tg.rotateY = -130;

				g.addChild( tg );
				return g;
		}

		function keyPressedHandler( event:KeyboardEvent ):Void {
				switch( event.keyCode ) {
						case 38: // KEY_UP
								tg.roll += 2;
						case 40: // KEY_DOWN
								tg.roll -= 2;
						case 37: // KEY_LEFT
								tg.pan -= 2;
						case 39: // KEY_RIGHT
								tg.pan += 1;
						case 34: // PAGE_DOWN
								tg.z -= 5;
						case 33: // PAGE_UP
								tg.z += 5;
				}
		}

		function enterFrameHandler( event:Event ):Void {
				scene.render();
		}

		static function main() {
				new ColladaCar();
		}
}


