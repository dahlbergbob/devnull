/**
 *
 * @author Tommy Salomonsson
 */
package devnull {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class SpaceShip extends Sprite {

		[Embed(source='ship.png')]
		public var Ship:Class;
		
		private var _fire:Vector.<BitmapData>;
		
		private var _currentPos:Point = new Point();
		private var _lastPos:Point;
		private var _cnt:int = 0;
		private var _vp:ViewPort;
		
		public function SpaceShip(vp:ViewPort) {
			_vp = vp;


			_fire = new <BitmapData>[];
			var shipBmp:Bitmap = new Ship();
			shipBmp.x = shipBmp.y = -32;
			addChild(shipBmp);
			
			_currentPos.x = 0;
			_currentPos.y = 0;
			
			addEventListener(Event.ENTER_FRAME, onEF);
		}

		private function onEF(event:Event):void {
			if (++_cnt%4 == 0) {
				var rad:Number = (this.rotation+90) * Math.PI / 180;
				var cos:Number = Math.cos(rad);
				var sin:Number = Math.sin(rad);
				
				
				var fire:Fire = new Fire(this.x + (cos*30), this.y + (sin*30), cos*2, sin*2);
				parent.addChild(fire);
			}
		}


		public function setPosition(x:Number, y:Number):void {
			
			this.x = _currentPos.x = x;
			this.y = _currentPos.y = y;

			if (_lastPos == null) {
				_lastPos = new Point();
				return;
			}
			
			var rot:Number = Math.atan2(_lastPos.y - _currentPos.y, _lastPos.x - _currentPos.x);
			this.rotation = (rot/Math.PI * 180) - 90;
			_lastPos.x = x;
			_lastPos.y = y;
		}

		public function moveTo(x:Number, y:Number):void {
			
		}

		
		
	}
}
