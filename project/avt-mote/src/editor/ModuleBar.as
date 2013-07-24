package editor 
{
	import editor.config.StringPool;
	import editor.module.ModuleBase;
	import editor.ui.SripteWithRect;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import UISuit.UIComponent.BSSButton;
	/**
	 * ...
	 * @author ...
	 */
	public class ModuleBar  extends SripteWithRect
	{
		private var m_mdList : Vector.<ModuleBase> = new Vector.<ModuleBase>();
		private var m_firstX : int;
		
		public function ModuleBar() 
		{
			var tf : TextField = new TextField();
			tf.height = 20;
			tf.x = tf.y = 5;
			tf.width = 50;
			var tft :TextFormat = tf.defaultTextFormat;
			 tft.color = 0x992222;
			tf.defaultTextFormat = tft;
			
			tf.mouseEnabled = false;
			tf.text = StringPool.MODULE;
			addChild(tf);
			
			m_firstX = tf.textWidth + tf.x + 10;
		}
		
		public function onNew():void
		{
			
			var _mdA : ModuleBase
			
			for each (var _md : ModuleBase in  m_mdList)
			{
				if (_md.getButtonDsp().getState() == BSSButton.SBST_PRESS)
					_mdA = _md;
				_md.onNew();
				_md.getButtonDsp().setState(BSSButton.SBST_IDLE);
			}
			
			if (_mdA)
			{	
				_mdA.activate();
				_md.getButtonDsp().setState(BSSButton.SBST_PRESS);
				
			}
			//m_mdList[0].activate();
		}
		public function onSave(__root : XML):void
		{
			for each (var _md : ModuleBase in  m_mdList)
			{
				_md.onSave(__root);
			}
		}
		public function onExport(__rootBA : ByteArray):void
		{
			for each (var _md : ModuleBase in  m_mdList)
			{
				_md.onExport(__rootBA);
			}
		}
		
		public function onOpenXML(__root : XML):void
		{
			for each (var _md : ModuleBase in  m_mdList)
			{
				_md.onOpenXML(__root);
			}
		}
		
		private function deactivateAll(except : ModuleBase) : void
		{
			if (m_mdList)
			{
				for each (var md : ModuleBase in m_mdList)
					if (md != except)
						md.deactivate();
			}
		}
		public function addModule(md : ModuleBase) : void
		{
			var btn : BSSButton = md.getButtonDsp();
			btn.releaseFunction = function (btn:BSSButton) : void
			{
				deactivateAll(md);
				md.activate();
			}
			
			var lastBtn : BSSButton;
			
			if (m_mdList.length)
				lastBtn = m_mdList[m_mdList.length - 1].getButtonDsp();
			
			m_mdList.push(md);
			
			
			btn.y = 5;
			btn.x = (lastBtn ? (lastBtn.x + lastBtn.width + 5) : m_firstX);
			addChild(btn);
			
			
		}
		
		public override function dispose():void
		{
			if (m_mdList)
			{
				for each (var md : ModuleBase in m_mdList)
				{
					md.dispose();
				}
				m_mdList.length = 0;//prevent other use
				m_mdList = null;
			}
			
			super.dispose();
		}
		
	}

}