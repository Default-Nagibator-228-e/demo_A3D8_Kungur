package alternativa.proplib.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.loaders.Parser3DS;
   import alternativa.engine3d.loaders.ParserMaterial;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.ExternalTextureResource;
   import alternativa.proplib.utils.TextureByteDataMap;
   import utils.ByteArrayMap;
   import utils.textureutils.TextureByteData;
   import flash.utils.ByteArray;
   
   public class PropMesh extends PropObject
   {
      
      public static const DEFAULT_TEXTURE:String = "$$$_DEFAULT_TEXTURE_$$$";
      
      public static var threshold:Number = 0.01;
      
      public static var meshDistanceThreshold:Number = 0.001;
      
      public static var meshUvThreshold:Number = 0.001;
      
      public static var meshAngleThreshold:Number = 0.001;
      
      public static var meshConvexThreshold:Number = 0.01;
      
      public var textures:TextureByteDataMap;
	  
	  public var mesh1:Mesh;
      
      public function PropMesh(modelData:ByteArray, objectName:String, textureFiles:Object, files:ByteArrayMap, imageMap:TextureByteDataMap)
      {
         super(PropObjectType.MESH);
         this.parseModel(modelData, objectName, textureFiles, files, imageMap);
      }
      
      private function parseModel(modelData:ByteArray, objectName:String, textureFiles:Object, files:ByteArrayMap, imageMap:TextureByteDataMap) : void
      {
         var textureName:* = null;
         var textureFileName:String = null;
         var textureByteData:TextureByteData = null;
         var mesh:Mesh = this.processObjects(modelData,objectName);
         this.object = mesh;
         var defaultTextureFileName:String = this.getTextureFileName(mesh);
         if(defaultTextureFileName == null && textureFiles == null)
         {
			//return;
            throw new Error("PropMesh: no textures found");
         }
         if(textureFiles == null)
         {
            textureFiles = {};
         }
         if(defaultTextureFileName != null)
         {
            textureFiles[PropMesh.DEFAULT_TEXTURE] = defaultTextureFileName;
         }
         this.textures = new TextureByteDataMap();
         for(textureName in textureFiles)
         {
            textureFileName = textureFiles[textureName];
            if(imageMap == null)
            {
               textureByteData = new TextureByteData(files.getValue(textureFileName),null);
            }
            else
            {
               textureByteData = imageMap.getValue(textureFileName);
            }
            this.textures.putValue(textureName,textureByteData);
         }
      }
      
      private function processObjects(modelData:ByteArray, objectName:String) : Mesh
      {
		 var currObject:Object3D = null;
         var currObjectName:String = null;
         modelData.position = 0;
         var parser:Parser3DS = new Parser3DS();
         parser.parse(modelData);
		 for each(currObject in parser.objects)
         {
            if(currObject != parser.objects[0])
            {
               (currObject as Mesh).setMaterialToAllSurfaces(null);
			   (currObject as Mesh).useShadow = false;
			   currObject = null;
            }
         }
		 mesh1 = (parser.objects[0] as Mesh).clone() as Mesh;
		 mesh1.geometry.calculateNormals();
		 mesh1.calculateBoundBox();
		 parser.objects[0] = null;
		 currObject = null;
		 parser.clean();
         return mesh1 != null?mesh1:Mesh(parser.hierarchy[0]);
      }
      
      private function getTextureFileName(mesh:Mesh) : String
      {
		if (mesh1 != null) {
			try{
				return (mesh1.getSurface(0).material.getResources()[0] as ExternalTextureResource).url;
			}catch (e:Error){}
		}
        return null;
      }
      
      override public function traceProp() : void
      {
         var textureName:* = null;
         var textureData:TextureByteData = null;
         super.traceProp();
         for(textureName in this.textures)
         {
            textureData = this.textures[textureName];
         }
      }
   }
}
