package alternativa.tanks.config.loaders 
{
	import utils.textureutils.TextureByteData;
	
	public class MaterialUserEntry 
	{
		
		public var materialUsers:Vector.<IMaterialUser>;
   
	   function MaterialUserEntry()
	   {
		  this.materialUsers = new Vector.<IMaterialUser>();
		  super();
	   }
	   
	   public function getTextureData() : TextureByteData
	   {
		  throw new Error("Not implemented");
	   }
		
	}

}