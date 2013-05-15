package editor.ui 
{
	import editor.config.StringPool;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import UISuit.UIComponent.BSSButton;
	import UISuit.UIComponent.BSSSlider;
	import UISuit.UIUtils.GraphicsUtil;
	/**
	 * ...
	 * @author ...
	 */
	public class EdtAddUI extends SpriteWH
	{
		private var _text : TextField;
		
		public var okFunction : Function ;
		public var changeFunction : Function ;
		
		public function get value() : int
		{
			return int(_text.text);
		}
		
		public function EdtAddUI(min : Number, max : Number)
		{
			var _btn:BSSButton;
			
			var shape : Shape;
			
			
			var g : Graphics;
			var btnCtar : Sprite = new Sprite();
			
			shape = new Shape();
			g = shape.graphics;
			g.lineStyle(1, 0xFFFF00 , 0.25);
			g.beginFill(0xFF9999 , 0.7 )
			g.moveTo( 0, 0);
			g.lineTo( -5, 10);
			g.lineTo( +5, 10);
			g.lineTo( 0, 0);
			btnCtar.addChild(shape);
			
			shape = new Shape();
			g = shape.graphics;
			g.lineStyle(1, 0xFFFF00 , 0.50);
			g.beginFill(0xFF6666 , 0.9 )
			g.moveTo( 0, 0);
			g.lineTo( -5, 10);
			g.lineTo( +5, 10);
			g.lineTo( 0, 0);
			btnCtar.addChild(shape);
			
			
			shape = new Shape();
			g = shape.graphics;
			g.lineStyle(1, 0x4444FF , 0.90);
			g.beginFill(0xDDDDFF , 0.9 )
			g.moveTo( 0, 0);
			g.lineTo( -5, 10);
			g.lineTo( +5, 10);
			g.lineTo( 0, 0);
			btnCtar.addChild(shape);
			
			
			_btn = new BSSButton(btnCtar);
			
			var _slider : BSSSlider = BSSSlider.createSimpleBSSSlider(true, _btn, 0, 150, min, max);
			_slider.x  = 10;
			_slider.y = 10;
			addChild(_slider);
			
			_slider.dragFunction = onChange;
			
			_text = new TextField();
			_text.width = 30;
			_text.height = 20;
			_text.background = true;
			_text.border = true;
			_text.x = _slider.x + _slider.width + 5;
			_text.y = 5;
			_text.mouseEnabled = false;
			addChild(_text);
			
			_slider.setThumbValue(0 , min);
			_text.text = "" + int(_slider.getThumbValue(0));
			
			var btn : BSSButton = BSSButton.createSimpleBSSButton(20, 20, StringPool.OK);
			btn.releaseFunction = onOK;
			btn.x = _text.x + _text.width + 5;
			btn.y = _text.y;
			addChild(btn);
			
			
			graphics.clear();
			graphics.beginFill(0xEEEEFF , 0.95);
			graphics.lineStyle(1 , 0x9999FF);
			graphics.drawRect(0, 0, rect.right + 5 , rect.bottom + 5 );
			
			
			
			
		}
		private function onOK(btn : BSSButton) : void
		{
			if (okFunction != null)
			{
				okFunction(int(_text.text));
			}
		}
		private function onChange(_slider : BSSSlider):void
		{
			_text.text = "" + int(_slider.getThumbValue(0));
			if (changeFunction != null)
			{
				changeFunction(value);
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
			GraphicsUtil.removeAllChildrenWithDispose(this);
		}
	}

}