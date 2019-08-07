package alternativa.tanks.config.loaders 
{
	import alternativa.proplib.objects.PropSprite;
	import utils.textureutils.TextureByteData;
	
	public class Sprite3DMaterialUserEntry extends MaterialUserEntry
	{
		
		public var propSprite:PropSprite;
   
	   function Sprite3DMaterialUserEntry(propSprite:PropSprite)
	   {
		  super();
		  this.propSprite = propSprite;
	   }
	   
	   override public function getTextureData() : TextureByteData
	   {
		  return this.propSprite.textureData;
	   }
		
	}

}