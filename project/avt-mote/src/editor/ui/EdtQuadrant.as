package editor.ui {


	
	import flash.display.Shape;	
	import flash.display.Sprite;	

	import flash.text.TextField;	
	import flash.geom.Point;

	import editor.config.*;

	import flash.geom.Rectangle;	
	import flash.geom.Point;	
	
	/**	
	 * BSS假3D类 之编辑器之 象限
	 * @author blueshell
	 * @version		0.2.1
	 * @date 		01.19.2008
  	 * @MSN blueshell＠live.com
	 * @QQ 87453144
	 */
	public class EdtQuadrant extends Sprite {
		
		private var _gird : Shape;
		private var _girdBG : Shape;
		public var _CoordinateAxisX : Shape;
		public var _CoordinateAxisY : Shape;
		private var _hotSpots : Shape = new Shape;
		
		private var _quadrant : int;
		private var _state : int;
		
		private var _posX : TextField = new TextField();	
		private var _posY : TextField = new TextField();
		private var _scaleQ : TextField = new TextField();
		
		private var _quadrantInfo : TextField = new TextField();
		
		public static const _quadrantInfoArray : Array = ["top","persp","front","side"];
		
		public var EdtDotArray : Array = new Array ();
		
		public var _lineShape : Shape = new Shape();
		public var _lineShapeDym : Shape = new Shape();
		public var _dotShape : Sprite = new Sprite();
		
		private var scaleQ : Number = 1;
		private var scaleQ10 : int = 10;
		
		private var xQ : int ;
		private var yQ : int ;
		
		public static const PERSP : int = 1;
		
		private var isThisFull : Boolean = false;

		public function dispose():void
		{
			_gird = null;
			_girdBG = null;
			_CoordinateAxisX = null;
			_CoordinateAxisY= null;
			_hotSpots= null;
			
			_posX= null;
			_posY = null;
			_scaleQ = null;
			_quadrantInfo = null;
			
			EdtDotArray = null;
			
			_lineShape = null;
			_lineShapeDym = null;
			_dotShape = null;
		
			import  UISuit.UIUtils.*;
			GraphicsUtil.removeAllChildren(this);
		
		}
		public function EdtQuadrant( position : int ) {
			
			//this.x = EdtDEF.QUADRANT_X  + (position % 2) * EdtDEF.QUADRANT_WIDTH ;
			//this.y = EdtDEF.QUADRANT_Y  + (int)(position / 2) * EdtDEF.QUADRANT_HEIGHT ;
			
			
			_quadrant = position;
			
			
		
			if ( null == _girdBG ) {
				_girdBG = new Shape();
				_girdBG.graphics.beginFill(0xFFFFFF);
				_girdBG.graphics.drawRect(0,0,EdtDEF.QUADRANT_WIDTH,EdtDEF.QUADRANT_HEIGHT);
				_girdBG.graphics.endFill();
				BGColor = EdtSET.bg_color;
				
				
				var _girdMask : Shape = new Shape();
				_girdMask.graphics.beginFill(0xFFFFFF);
				_girdMask.graphics.drawRect(0,0,EdtDEF.QUADRANT_WIDTH,EdtDEF.QUADRANT_HEIGHT);
				_girdMask.graphics.endFill();
				
				
				_gird = new Shape(); _gird.mask = _girdMask;
				var l : int;
			
				_gird.graphics.lineStyle (1, 0xAAAAAA);  
				
				
				
				const  EdtDEF_TILE_WIDTH_2 : int = EdtDEF.TILE_WIDTH >> 1;
				
				for (l = -EdtDEF_TILE_WIDTH_2;l <=  EdtDEF.QUADRANT_WIDTH ; l += EdtDEF.TILE_WIDTH ) {
					_gird.graphics.moveTo (l,0);
					_gird.graphics.lineTo (l,EdtDEF.QUADRANT_HEIGHT + EdtDEF.TILE_WIDTH);
				}
				
				for (l = -EdtDEF_TILE_WIDTH_2;l < EdtDEF.QUADRANT_HEIGHT  + EdtDEF.TILE_WIDTH ; l += EdtDEF.TILE_WIDTH ) {
					_gird.graphics.moveTo (0,l);
					_gird.graphics.lineTo (EdtDEF.QUADRANT_WIDTH + EdtDEF.TILE_WIDTH ,l);
				}
				_gird.cacheAsBitmap = true;
				///_gird.x = - EdtDEF.TILE_WIDTH /2;
				//_gird.y = - EdtDEF.TILE_WIDTH /2;
				
				_CoordinateAxisX = new Shape();
				_CoordinateAxisY = new Shape();
				
				_CoordinateAxisY.graphics.lineStyle (0,0xFFFFFF); 				
				l= EdtDEF.QUADRANT_WIDTH /2;
				_CoordinateAxisY.graphics.moveTo (0,0);
				_CoordinateAxisY.graphics.lineTo (0,EdtDEF.QUADRANT_HEIGHT );
				_CoordinateAxisY.x = l;
				
				
				l= EdtDEF.QUADRANT_HEIGHT /2;
				_CoordinateAxisX.graphics.lineStyle (0,0xFFFFFF); 
				_CoordinateAxisX.graphics.moveTo (0,0);
				_CoordinateAxisX.graphics.lineTo (EdtDEF.QUADRANT_WIDTH ,0);
				_CoordinateAxisX.y = l;
				
				_hotSpots.graphics.lineStyle (1.6,0x0); 
				_hotSpots.graphics.drawRect(0.5, 0.5, EdtDEF.QUADRANT_WIDTH  -1, EdtDEF.QUADRANT_HEIGHT  - 1);
				_hotSpots.visible = false;
								
				_quadrantInfo.x = EdtDEF.INFOX ;
				_quadrantInfo.y = EdtDEF.INFOY ;
				_quadrantInfo.text = _quadrantInfoArray[_quadrant];
				_quadrantInfo.selectable = false;
				
				
				_posX.x = EdtDEF.POSX ;
				_posX.y = EdtDEF.INFOY ;
				_posX.selectable = false;
				_posY.x = EdtDEF.POSX  + 50;
				_posY.y = EdtDEF.INFOY ;
				_posY.selectable = false;
				updataPosInfo();
				
				_sQ = 10;
				_scaleQ.x = EdtDEF.POSX  - 50;
				_scaleQ.y = EdtDEF.INFOY ;
				_scaleQ.selectable = false;
				
				_dotShape.x = EdtDEF.QUADRANT_WIDTH /2;
				_dotShape.y = EdtDEF.QUADRANT_HEIGHT /2;
				
				_lineShape.x = EdtDEF.QUADRANT_WIDTH /2;
				_lineShape.y = EdtDEF.QUADRANT_HEIGHT /2;
				_lineShape.alpha = 0.6;
				_lineShape.cacheAsBitmap = true;
				
				_lineShapeDym.x = EdtDEF.QUADRANT_WIDTH /2;
				_lineShapeDym.y = EdtDEF.QUADRANT_HEIGHT /2;
				_lineShapeDym.alpha = 0.3;
				
			}
			
			addChild (_girdBG);
			addChild (_girdMask);
			addChild (_gird);
			addChild (_CoordinateAxisX);
			addChild (_CoordinateAxisY);
			addChild (_hotSpots);
			addChild (_quadrantInfo);
			addChild (_posX);
			addChild (_posY);
			addChild (_scaleQ);
			
			/*
			if (_quadrant == PERSP ) {
				addChild (EditorMain.myWorld3D);
				EditorMain.myWorld3D.x =  EdtDEF.QUADRANT_WIDTH /2;
				EditorMain.myWorld3D.y =  EdtDEF.QUADRANT_HEIGHT /2;
			}*/
			
			addChild (_lineShape);
			addChild (_lineShapeDym);
			addChild (_dotShape);
			
			
		}
		
		public function update () : void {
		
		}
		
		public function updataPosInfo() : void {
			if (_quadrant <= 1 ) {
				_posX.text = "X: "+ _xQ;
				_posY.text = "Z: " + (-_yQ);
			}
			else if (_quadrant == 2 ) {
				_posX.text = "X: "+_xQ;
				_posY.text = "Y: "+_yQ;	
			}
			else //if (_quadrant == 3 )
			{
				_posX.text = "Z: "+_xQ;
				_posY.text = "Y: "+_yQ;	
			}
		}
		
		
		
		public function set BGColor (inColor : uint ) : void {
			EdtSET.bg_color = (inColor);
			_girdBG.transform.colorTransform = EdtSET.bg_color_t;	
		}
		
		public function set Lineolor (inColor : uint ) : void {
			EdtSET.gird_color = (inColor);
			_gird.transform.colorTransform = EdtSET.gird_color_t;	
		}
		

		public function set state (inState : int ) : void {
			
			if (inState == 2 ) {
				_hotSpots.visible = true;
				_hotSpots.transform.colorTransform = EdtSET.HOT_WORKON;
				_state = inState;
			}
			else if (inState == 1 ) {
				_hotSpots.visible = true;
				if ( _state != 2) {
					_hotSpots.transform.colorTransform = EdtSET.HOT_MOVEON;
					_state = inState;
				}
				
			}
			else if (inState == -1)
			{
				_hotSpots.visible = false;
				_state = inState;
			}
			else if (_state !== 2)
			{
				_hotSpots.visible = false;
				_state = inState;
			}
			
			
			
		}
		
		public function get isWorkOn () : Boolean {
			return (_state == 2);
		}
		
		public function QuadrantRelateDrag ( xOff : int , yOff : int) : void {
			_yQ += yOff;
			_xQ += xOff;
		//	_gird.x = (_gird.x + xOff) % DEF_TILE_WIDTH;
		//	_gird.y = (_gird.y + yOff) % DEF_TILE_WIDTH;
			updataPosInfo();
		}
		
		
		
		public function get _xQ () : int {
		//	return (_CoordinateAxisY.x - EdtDEF_QUADRANT_WIDTH/2 );
			return (xQ );
		}
		public function get _yQ () : int {
		//	return (_CoordinateAxisX.y - EdtDEF_QUADRANT_HEIGHT/2 );
			return ( yQ );
		}
		public function get _sQ () : int {
			return scaleQ10;
		}	
		
		public function set _sQ ( s : int) : void {
			
			scaleQ10 = s;
			scaleQ10 = Math.min (scaleQ10,EdtDEF.MAX_SCALE );
			scaleQ10 = Math.max (scaleQ10,EdtDEF.MIN_SCALE );

			scaleQ = scaleQ10/10;
			
			_scaleQ.text = "scale: "+ (scaleQ);

			_lineShape.graphics.clear();
			
			//TODO
			//for (var i : int = 0 ; i < EdtDotArray.length ; i++) {
			//	map3DTo2D (i);
			//	biuldLineCache (i);
			//}
		}	
		
		public function set _xQ (x : int) : void {
		//	trace (EditorMain.myWorld3D.x)
			xQ = x;
			_gird.x = (x - EdtDEF.TILE_WIDTH ) % EdtDEF.TILE_WIDTH ;
			_CoordinateAxisY.x = x + EdtDEF.QUADRANT_WIDTH /2;
		
			_dotShape.x = x + EdtDEF.QUADRANT_WIDTH /2;
			_lineShape.x = x + EdtDEF.QUADRANT_WIDTH /2;
			_lineShapeDym.x = x + EdtDEF.QUADRANT_WIDTH /2;
			
			updataPosInfo();
			
			/*
			if (_quadrant == PERSP ) {

				EditorMain.myWorld3D.x = x + EdtDEF.QUADRANT_WIDTH /2;
		//		trace (EditorMain.myWorld3D.x)
				Values.s_cam_x = _xQ;
				reDrawAll();
				
				if (isThisFull) {
					EditorMain.myWorld3D.x -= EdtDEF.QUADRANT_WIDTH  / 2 ;
					_dotShape.x -= EdtDEF.QUADRANT_WIDTH  / 2 ;
					_lineShapeDym.x -= EdtDEF.QUADRANT_WIDTH  / 2 ;
					_lineShape.x -= EdtDEF.QUADRANT_WIDTH  / 2 ;
					_CoordinateAxisY.x -= (EdtDEF.QUADRANT_WIDTH  / 2);
				}
			}*/
		}
		
		public function set _yQ (y : int) : void {
			yQ = y;
			_gird.y = (y - EdtDEF.TILE_WIDTH ) % EdtDEF.TILE_WIDTH ;
			_CoordinateAxisX.y = y + EdtDEF.QUADRANT_HEIGHT /2;
				
			_dotShape.y = y + EdtDEF.QUADRANT_HEIGHT /2;
			_lineShape.y = y + EdtDEF.QUADRANT_HEIGHT /2;
			_lineShapeDym.y = y + EdtDEF.QUADRANT_HEIGHT /2;
			updataPosInfo();
			
			
			/*
			if (_quadrant == PERSP ) {
				EditorMain.myWorld3D.y = y + EdtDEF.QUADRANT_HEIGHT /2;
				Values.s_cam_y = _yQ;
		//		
				reDrawAll();
				
				if (isThisFull) {
					EditorMain.myWorld3D.y += EdtDEF.QUADRANT_HEIGHT  / 2 ;
					_dotShape.y += EdtDEF.QUADRANT_HEIGHT  / 2 ;
					_lineShapeDym.y += EdtDEF.QUADRANT_HEIGHT  / 2 ;
					_lineShape.y += EdtDEF.QUADRANT_HEIGHT  / 2 ;
					_CoordinateAxisX.y += (EdtDEF.QUADRANT_HEIGHT  / 2 );
				}
				
			}*/
				
		}
		
		
		public function setFullSreen(isFull : Boolean): void {
			
			isThisFull = isFull;
			
			
			//_hotSpots.visible = !isFull;
			//_quadrantInfo.visible = !isFull;
			//_posX.visible = !isFull;
			//_posY.visible = !isFull;
			//_scaleQ.visible = !isFull;
			_hotSpots.scaleX = 
			_hotSpots.scaleY = 
			_CoordinateAxisX.scaleX = 
			_CoordinateAxisY.scaleY = 
			_girdBG.scaleX = 
			_girdBG.scaleY = 
			_gird.mask.scaleX = 
			_gird.mask.scaleY = 
			_gird.scaleX = 
			_gird.scaleY = isFull ? 2 : 1;
			
			
			_xQ -= ((((_quadrant&1)!=0)?1:-1)* EdtDEF.QUADRANT_WIDTH /2) * (isFull ? 1:-1);
			_yQ -= ((((_quadrant&2)!=0)?1:-1)* EdtDEF.QUADRANT_HEIGHT /2) * (isFull ? 1:-1);
			
			//trace(_xQ);
			
			_CoordinateAxisX.x -= (((_quadrant&1)!=0)? EdtDEF.QUADRANT_WIDTH    : 0 )* (isFull ? 1:-1);
			_CoordinateAxisY.y -= (((_quadrant&2)!=0)? EdtDEF.QUADRANT_HEIGHT  : 0 )* (isFull ? 1:-1);
		
					
			
			if (_quadrant != EdtQuadrant.PERSP)
				_sQ += (isFull ? 10 : -10);
			
			var scale : int = (isFull ? 2 : 1);
			
			for (var i : int = 0; i < EdtDotArray.length ; i++) {
				EdtDotArray[i].scaleX = scale;
				EdtDotArray[i].scaleY = scale;
			}
			
			//if (_quadrant == EdtQuadrant.PERSP) {
			//	EditorMain.myWorld3D.Edtdraw();
			//}
			
		}
		
		
		
	}
}