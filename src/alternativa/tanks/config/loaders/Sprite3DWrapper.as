package alternativa.tanks.config.loaders 
{
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Sprite3D;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import flash.display.BitmapData;
	
	public class Sprite3DWrapper implements IMaterialUser
	{
		
		private var sprite:Sprite3D;
   
	   function Sprite3DWrapper(sprite:Sprite3D)
	   {
		  super();
		  this.sprite = sprite;
	   }
	   
	   public function setMaterial(material:Material) : void
	   {
		  var texture:BitmapData = ((material as TextureMaterial).diffuseMap as BitmapTextureResource).data;
		  this.sprite.material = material;
		  var scale:Number = this.sprite.width;
		  this.sprite.width = scale * texture.width;
		  this.sprite.height = scale * texture.height;
	   }
		
	}

}