package alternativa.tanks.config.loaders 
{
	
	import alternativa.proplib.objects.PropMesh;
	import utils.textureutils.TextureByteData;
	
	public class BSPMaterialUserEntry extends MaterialUserEntry
	{
		
		public var propMesh:PropMesh;
   
	   public var textureName:String;
	   
	   function BSPMaterialUserEntry(propMesh:PropMesh, textureName:String)
	   {
		  super();
		  this.propMesh = propMesh;
		  this.textureName = textureName;
	   }
	   
	   override public function getTextureData() : TextureByteData
	   {
		  var ro:TextureByteData = this.propMesh.textures.getValue(this.textureName);
		  if(ro == null)
		  {
			 trace(this.textureName);
		  }
		  return ro;
	   }
		
	}

}