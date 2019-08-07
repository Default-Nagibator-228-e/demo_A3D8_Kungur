package alternativa.tanks.config.loaders 
{
	
	import alternativa.proplib.objects.PropMesh;
	import alternativa.proplib.objects.PropSprite;
	
	public class MaterialUsersRegistry 
	{
		
		public var meshEntries:Vector.<BSPMaterialUserEntry>;
   
	   public var spriteEntries:Vector.<Sprite3DMaterialUserEntry>;
	   
	   function MaterialUsersRegistry()
	   {
		  this.meshEntries = new Vector.<BSPMaterialUserEntry>();
		  this.spriteEntries = new Vector.<Sprite3DMaterialUserEntry>();
		  super();
	   }
	   
	   public function addMesh(propMesh:PropMesh, textureName:String, materialUser:MeshWrapper) : void
	   {
		  var entry:BSPMaterialUserEntry = null;
		  var currentEntry:BSPMaterialUserEntry = null;
		  for each(currentEntry in this.meshEntries)
		  {
			 if(currentEntry.propMesh == propMesh && currentEntry.textureName == textureName)
			 {
				entry = currentEntry;
				break;
			 }
		  }
		  if(entry == null)
		  {
			 entry = new BSPMaterialUserEntry(propMesh,textureName);
			 this.meshEntries.push(entry);
		  }
		  entry.materialUsers.push(materialUser);
	   }
	   
	   public function addSprite3D(propSprite:PropSprite, wrapper:Sprite3DWrapper) : void
	   {
		  var entry:Sprite3DMaterialUserEntry = null;
		  var currentEntry:Sprite3DMaterialUserEntry = null;
		  for each(currentEntry in this.spriteEntries)
		  {
			 if(currentEntry.propSprite == propSprite)
			 {
				entry = currentEntry;
				break;
			 }
		  }
		  if(entry == null)
		  {
			 entry = new Sprite3DMaterialUserEntry(propSprite);
			 this.spriteEntries.push(entry);
		  }
		  entry.materialUsers.push(wrapper);
	   }
		
	}

}