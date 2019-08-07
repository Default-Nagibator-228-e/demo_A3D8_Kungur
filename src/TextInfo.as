package 
{
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TextInfo extends Sprite
	{
    
		private var bg:Sprite;
   
		private var textField:TextField;
   
	    function TextInfo()
	    {
		  super();
		  this.bg = new Sprite();
		  with(this.bg.graphics)
		  {
			 
			 beginFill(0,0.6);
			 drawRect(0,0,10,10);
			 endFill();
		  }
		  this.textField = new TextField();
		  this.textField.autoSize = TextFieldAutoSize.LEFT;
		  this.textField.selectable = false;
		  this.textField.defaultTextFormat = new TextFormat("Tahoma",10,16777215);
		  this.textField.x = 5;
		  this.textField.y = 5;
		  addChild(this.bg);
		  addChild(this.textField);
	    }
   
		public function write(param1:String) : void
		{
			this.textField.appendText(param1 + "\n");
			this.bg.width = this.textField.width + 10;
			this.bg.height = this.textField.height + 10;
		}
	}
}