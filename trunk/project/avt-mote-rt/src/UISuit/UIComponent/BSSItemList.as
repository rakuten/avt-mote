package   UISuit.UIComponent   {  
	import flash.geom.Rectangle;
	import UISuit.UIUtils.GraphicsUtil;
	import  flash.events.* ; 	
	import  flash.text.* ; 	
	import  flash.display.* ; 	

	
	/**
	 * ...
	 * @author blueshell
	 */
	public class BSSItemList extends Sprite
	{

		//private var 	m_itemList	: Array = new Array();
		private var 	m_spaceX	: int ;
		private var	m_spaceY	: int ;
		protected var 	m_offsetX	: int ;
		protected var	m_offsetY	: int ;
		
		private var 	m_mask		: Shape;
	

		protected var m_itemContainer : DisplayObjectContainer;

		
		public function setOffsetX(_offsetX : Number)
		: void 
		{
			m_offsetX = _offsetX;
		}
		public function setOffsetY(_offsetY : Number)
			: void 
		{
			m_offsetY = _offsetY;
		}
		
		public function setSpaceY(_spaceY : Number)
		: void 
		{
			m_spaceY = _spaceY;
			//trace(m_spaceY);
		}
		
		public function BSSItemList(_spaceX	: int = 0 , _spaceY	: int = 0)
		{
			m_spaceX = _spaceX;
			m_spaceY = _spaceY;
			m_itemContainer = new Sprite();
			addChild(m_itemContainer);

			m_mask = new Shape();
			m_mask.graphics.beginFill(0);
			m_mask.graphics.drawRect(0,0,1,1);
			m_mask.graphics.endFill();
			addChild(m_mask);
			m_itemContainer.mask = (m_mask);

			
		}
		
		 public function dispose()
		 : void 
		 {
			CONFIG::DEBUG {
				trace("BSSItemList dispose");
			}
			
			
			m_mask = null;
			
			/*
			 * var leng : int = m_itemList.length;
			for (var i : int = 0 ; i < leng ; i++ )
				m_itemList[i] = null;
			m_itemList = null;
			*/
			
			GraphicsUtil.removeAllChildrenWithDispose(this);
			 
	     }

		override public function set width(w : Number)
		: void 
		{
			m_mask.scaleX = (w);
		}
		
		override public function set height(h : Number)
		: void 
		{
			m_mask.scaleY = (h);
		}

		override public function get width() 
		: Number
		{
			return m_mask.scaleX;
		}
		override public function get height() 
		: Number
		{
			return m_mask.scaleY 
		}

		public  function get size()
		: int
		{
			return m_itemContainer.numChildren;
			//return m_itemList.length;
		}

		public  function clearAllItem(_disposeItem : Boolean = false)
		: void
		{
			/*
			CONFIG::Assert {		ASSERT(m_itemList.length == m_itemContainer.numChildren , ("error add other item??"));}
			if (m_itemList.length)
			{
				var len : int = m_itemList.length;
				for (var i : int = 0 ; i < len; i++ )
					m_itemList[i] = null;
				m_itemList.length = 0;
			}
			*/
			
			if (m_itemContainer.numChildren)
			{
				if (_disposeItem)
					GraphicsUtil.removeAllChildrenWithDispose(m_itemContainer);
				else
					GraphicsUtil.removeAllChildren(m_itemContainer);
			}
		}		
		
		public function refreshItem()
		: void
		{
			
		}
		
		public function removeItem(item : DisplayObject ):void
		{
			var idx : int = m_itemContainer.getChildIndex(item);
			if (idx == m_itemContainer.numChildren - 1)
				m_itemContainer.removeChild(item);
			else {
				var offsetY : int = m_itemContainer.getChildAt(idx + 1).y - item.y;
				for (var i : int = idx + 1 ; i < m_itemContainer.numChildren ; i++ )
					m_itemContainer.getChildAt(i).y -= offsetY;
				m_itemContainer.removeChild(item);
			}
			refreshItem();
		}
		public  function  addItem(item : DisplayObject )
		: void
		{
			CONFIG::ASSERT {
				ASSERT(!this.contains(item) );
				//var lbak : int = m_itemContainer.numChildren;
				//ASSERT(m_itemList.indexOf(item) == -1 , ("re addItem") );
			}
			if (m_itemContainer.numChildren)
			{
				var  itemLast : DisplayObject 
				//= DisplayObject(m_itemList[m_itemList.length - 1]);
				= m_itemContainer.getChildAt(m_itemContainer.numChildren - 1);
				
				item.x += m_offsetX;
				//var rect : Rectangle = itemLast.getBounds(itemLast.parent );
				//item.y = (rect.bottom + m_spaceY);
				item.y = itemLast.y + itemLast.height + m_spaceY;
				//trace("item.y " + item.y);
			}
			else
			{
				item.x += m_offsetX;
				item.y += m_offsetY;
			}
			

			
			
			//m_itemList.push(item);
			m_itemContainer.addChild(item);
			
			//CONFIG::Assert {ASSERT(m_itemContainer.numChildren == lbak+1 , ("re addItem") );}			
		}

		public  function getItemAt( _id : int ) : DisplayObject
		{
			return m_itemContainer.getChildAt[_id];// m_itemList[_id];
		}
	}
}


