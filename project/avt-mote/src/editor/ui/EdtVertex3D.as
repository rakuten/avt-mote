package editor.ui 
{
	/**
	 * ...
	 * @author Blueshell
	 */
	public class EdtVertex3D extends Vertex3D
	{
		public var priority : int;
		public var conect : Vector.<EdtVertex3D> = new Vector.<EdtVertex3D>();
		
		public function EdtVertex3D(_x : Number = 0,_y : Number = 0,_z : Number = 0) 
		{
			super(_x, _y, _z);
		}
		
	}

}