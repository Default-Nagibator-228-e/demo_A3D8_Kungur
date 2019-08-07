package alternativa.tanks.config.loaders 
{
	import alternativa.engine3d.core.VertexAttributes;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.Surface;
	import alternativa.engine3d.resources.Geometry;
	/**
	 * ...
	 * @author 
	 */
	public class PlusMesh extends Mesh
	{
		
		private var TorusMaterial2:FillMaterial = new FillMaterial(0x001bcc);

		private var TorusMaterial1:FillMaterial = new FillMaterial(0xb2cc00);

		private var attributes:Array;

		public function PlusMesh(kj:Vector.<Mesh>) {

			attributes = new Array();
			attributes[0] = VertexAttributes.POSITION;
			attributes[1] = VertexAttributes.POSITION;
			attributes[2] = VertexAttributes.POSITION;
			attributes[3] = VertexAttributes.TEXCOORDS[0];
			attributes[4] = VertexAttributes.TEXCOORDS[0];
			attributes[5] = VertexAttributes.NORMAL;
			attributes[6] = VertexAttributes.NORMAL;
			attributes[7] = VertexAttributes.NORMAL;
			attributes[8] = VertexAttributes.TANGENT4;
			attributes[9] = VertexAttributes.TANGENT4;
			attributes[10] = VertexAttributes.TANGENT4;
			attributes[11] = VertexAttributes.TANGENT4;

			var g:Geometry = new Geometry();
			g.addVertexStream(attributes);
			
			var vertices:Array = [];
			
			var uvt:Array = new Array();
			var ind:Array = [];
			var normals:Array = [];
			var sa:Mesh;
			 for each(sa in kj)
			 {
				 var ttr:Vector.<Number> = sa.geometry.getAttributeValues(VertexAttributes.POSITION);
				 var trp:Number;
				 for each(trp in ttr)
				 {
					 vertices.push(trp);
				 }
				 var ttr1:Vector.<Number> = sa.geometry.getAttributeValues(VertexAttributes.NORMAL);
				 var tr1:Number;
				 for each(tr1 in ttr1)
				 {
					 normals.push(tr1);
				 }
				 var ttr2:Vector.<uint> = sa.geometry.indices;
				 var tr2:Number;
				 for each(tr2 in ttr2)
				 {
					 ind.push(tr1);
				 }
			 }
			 g.numVertices = vertices.length / 3;
			var tangent:Array = new Array();

			g.setAttributeValues(VertexAttributes.POSITION, Vector.<Number>(vertices));
			//g.setAttributeValues(VertexAttributes.TEXCOORDS[0], Vector.<Number>(uvt));
			g.setAttributeValues(VertexAttributes.NORMAL, Vector.<Number>(normals));
			//g.setAttributeValues(VertexAttributes.TANGENT4, Vector.<Number>(tangent));
			g.indices =  Vector.<uint>(ind);

			//g.calculateNormals();
			//g.calculateTangents(0);
			this.geometry = g;
			this.addSurface(null, 0, 0);
			//this.addSurface(TorusMaterial1, 246, 1070);
			this.calculateBoundBox();
			var sa:Mesh;
			var gg:int;
			 for each(sa in kj)
			 {
				 var rp:Surface;
				 var d:int = 0;
				 for each(rp in sa._surfaces)
				 {
					if (rp.indexBegin > d) d = rp.indexBegin;
					this.addSurface(null, gg + rp.indexBegin, rp.numTriangles);
				 }
				 gg += d;
			 }
			 this.setMaterialToAllSurfaces(TorusMaterial1);
			this.x = 0;
			this.y = 6;
			this.z = 600;
			this.rotationX = 0;
			this.rotationY = 0;
			this.rotationZ = 0;
			//this.scaleX = 1.000000;
			//this.scaleY = 1.000000;
			//this.scaleZ = 1.000000;
		}
	}
}