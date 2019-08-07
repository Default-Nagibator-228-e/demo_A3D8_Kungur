package alternativa.tanks.config.loaders 
{
	
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.objects.Mesh;
	
	public class MeshWrapper implements IMaterialUser
	{
		private var mesh:Mesh;
   
	   function MeshWrapper(mesh:Mesh)
	   {
		  super();
		  this.mesh = mesh;
	   }
	   
	   public function setMaterial(material:Material) : void
	   {
		  this.mesh.setMaterialToAllSurfaces(material);
		  //this.mesh.geometry.calculateNormals();
	   }
		
	}

}