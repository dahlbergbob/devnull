package
{
	import devnull.APIEvent;
	import devnull.APIHelper;
	import devnull.SolarSystem;
	import devnull.SpaceShip;
	import devnull.ViewPort;
	import devnull.events.StarEvent;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Main extends Sprite
	{
		private var _api:APIHelper;
		
		private var _ship:SpaceShip;
		private var _vp:ViewPort;
		private var _solarSystem:SolarSystem;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align		= StageAlign.TOP_LEFT;
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			
			_vp = new ViewPort();
			
			_solarSystem = new SolarSystem(_vp);
			_solarSystem.addEventListener(StarEvent.STAR_CLICKED, onStarClicked);
			_ship = new SpaceShip(_vp);
			addChild(_solarSystem);
			addChild( _ship );

			_api = new APIHelper( _solarSystem );
			_api.addEventListener( APIEvent.SHIP_MOVE, onShipMove );
			_api.getLongRange();
		}

		private function onKeyUp(event:KeyboardEvent):void {
			if (event.keyCode == Keyboard.A) {
				_vp.zoom -= 0.1;
			}
			if (event.keyCode == Keyboard.S) {
				_vp.zoom += 0.1;
			}
			if (event.keyCode == Keyboard.SPACE) {
				_vp.restore();
			}
		}

		private function onShipMove( event:APIEvent ):void
		{
			_ship.setPosition( event.data["unix"], event.data["uniy"] );
		}
		
		private function onStarClicked( event:StarEvent ):void
		{
			_api.gotoStarsystem( event.star.name );
		}
	}
}
