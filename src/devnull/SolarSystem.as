/**
 *
 * @author Tommy Salomonsson
 */
package devnull {
	import devnull.events.StarEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class SolarSystem extends Sprite {
		private var _vp:ViewPort;
		private var _map:BitmapData;
		private var _data:Object;

		
		
		
		public function SolarSystem(vp:ViewPort) {
			_vp = vp;
			_map = new BitmapData(vp.width, vp.height, false, 0x000000);
			var bmp:Bitmap = new Bitmap(_map);
			addChild(bmp);
			
		}

		public function draw(data:Object):void {
			_data = data;
			_map.fillRect( new Rectangle( 0, 0, _vp.width, _vp.height), 0x000000 );
			for each( var starObject:Object in _data.stars )
			{
				var star = new Star( _vp, starObject );
				renderStar( star );
			}
		}

		private function renderStar( star:Star ):void
		{
			star.addEventListener( MouseEvent.CLICK, onClick );
			addChild( star );
		}

		private function onClick(event:MouseEvent):void {
			
			if (!(event.target is Star))
				return;
			
			var star:Star = Star( event.target );

			var zoom:Number = Math.random() * 3 + 2;
			_vp.centerOnPoint(star.originalX, star.originalY, zoom);
			
			dispatchEvent(new StarEvent(StarEvent.STAR_CLICKED, star));
		}

		public function drawPlanets( _planetMap:Object ):void
		{
			if( _planetMap.system != null )
			{
				trace( "At star: "+ _planetMap.system.name );
				trace( "Pos: ", _planetMap.system.x, _planetMap.system.y );
			}
		}
	}
}