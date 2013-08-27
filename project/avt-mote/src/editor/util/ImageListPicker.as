package editor.util 
{
	import editor.config.Config;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ...
	 */
	public class ImageListPicker
	{
		
		protected var m_callback : Function;
		public var m_filename : String;
		private var m_loadArray : Array;
		private var m_fileListLength : uint;
		private var m_fileLoading : uint;
		
		public function ImageListPicker(callback : Function ,filefArray : Array  , multiFile : Boolean) 
		{
			m_callback = callback;
			new FilePicker(onBA , filefArray , multiFile);
		}
		
		private function loadImg(str :String) : void
		{
			var ldr : Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE , onComplete );
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onComplete );
			var url : String;
			if (Config.isAirVersion)
			{	
				if (m_filename.indexOf(":/") == -1 && m_filename.indexOf(":\\") == -1)
					m_filename = FilePicker.s_lastOpen +  m_filename;
				url = m_filename;
			}
			else
				url = TextureLoader.s_imgPath +  m_filename;
				
			m_fileLoading++;
			ldr.load(new URLRequest(url));
			
			//trace(url , TextureLoader.s_imgPath +  m_filename);
		}
		
		private function onBA(_filename : String , ba : ByteArray , _fileListLength : uint ):void
		{
			m_filename = _filename;
			m_fileListLength = _fileListLength;
			
			if (m_filename.indexOf(".png") != -1)
			{
				var ldr : Loader = new Loader();
				ldr.contentLoaderInfo.addEventListener(Event.COMPLETE , onComplete );
				ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onComplete );
				m_fileLoading++;
				ldr.loadBytes(ba);
			}
			else {
				var _info : String = String(ba);
				while(_info.indexOf('\r') != -1)
					_info = _info.replace('\r' , "");
				var _loadArray : Array = _info.split("\n");
				
				if (m_loadArray)
				{
					for each (var _str : String in _loadArray)
						if (_str)
							m_loadArray.push(_str);
				}
				else
					m_loadArray = _loadArray;
				
				if (m_loadArray[m_loadArray.length - 1] == "")
					m_loadArray.pop();
				//trace(m_loadArray);
				
				
				m_filename = m_loadArray.shift();
				loadImg(m_filename);
			}
			
			
			
			//var ldr : Loader = new Loader();
			//ldr.contentLoaderInfo.addEventListener(Event.COMPLETE , onComplete );
			//ldr.loadBytes(ba);
		}
		
		
		private function onComplete(e:Event):void 
		{
			if (m_fileLoading)
				m_fileLoading--;
				
			e.currentTarget.removeEventListener(Event.COMPLETE , onComplete );
			e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR , onComplete );
			
			if (e.type == IOErrorEvent.IO_ERROR)
			{
				trace(e);
				return;
			}
			var ldi : LoaderInfo = (e.currentTarget) as LoaderInfo;
			
			if (m_callback != null)
			{	
				m_callback(	m_filename , Bitmap(ldi.content).bitmapData);
			}	
			
			if (!m_loadArray)
			{
				if (m_fileListLength == 0 && m_fileLoading == 0)
					m_callback = null;
				return;
			}
			
			
			if (m_loadArray.length == 0)	
			{	
				m_loadArray = null;
				if (m_fileListLength == 0 && m_fileLoading == 0)
					m_callback = null;
			}	
			else {
				
				m_filename = m_loadArray.shift();
				
				loadImg(m_filename);
			}
			
		}
	}
	

}