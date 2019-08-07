package alternativa.tanks.config.loaders
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.engine3d.primitives.Box;
   import alternativa.engine3d.primitives.Plane;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.proplib.PropLibRegistry;
   import alternativa.proplib.PropLibrary;
   import alternativa.proplib.objects.PropMesh;
   import alternativa.proplib.objects.PropObject;
   import alternativa.proplib.objects.PropSprite;
   import alternativa.proplib.types.PropData;
   import alternativa.proplib.types.PropGroup;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   [Event(name="complete",type="flash.events.Event")]
   public class MapLoader extends EventDispatcher
   {
      
      private static const STATIC_COLLISION_GROUP:int = 255;
      
      private static const MAX_BATCH_SIZE:int = 20;
      
      private static var objectMatrix:Matrix3D = new Matrix3D();
      
      private static var components:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(1,1,1)]);
      
      public var mapXml:XML;
      
      public var propLibRegistry:PropLibRegistry;
      
      private var loader:URLLoader;
      
      private var _objects:Vector.<Object3D>;
      
      private var _lights:Vector.<Light3D>;
      
      private var _sprites:Vector.<Object3D>;
      
      private var _visualCollisionObjects:Vector.<Object3D>;
      
      private var spawnPoints:Object;
      
      private var materialUsersRegistry:MaterialUsersRegistry;
      
      private var batchTextureBuilder:BatchTextureBuilder;
      
      private var mipMapResolution:Number = 5;
      
      public function MapLoader()
      {
         this._objects = new Vector.<Object3D>();
         this._sprites = new Vector.<Object3D>();
         this._lights = new Vector.<Light3D>();
         this.spawnPoints = {};
         super();
      }
      
      private static function isNaNVector(v:Vector3) : Boolean
      {
         return isNaN(v.x) || isNaN(v.y) || isNaN(v.z);
      }
      
      private static function readVector3(xml:XMLList, result:Vector3) : void
      {
         var element:XML = null;
         if(xml.length() > 0)
         {
            element = xml[0];
            result.x = Number(element.x);
            result.y = Number(element.y);
            result.z = Number(element.z);
         }
         else
         {
            result.x = result.y = result.z = 0;
         }
      }
      
      private static function readVector3D(xml:XMLList, result:Vector3D) : void
      {
         var el:XML = null;
         el = null;
         if(xml.length() > 0)
         {
            el = xml[0];
            result.x = Number(el.x);
            result.y = Number(el.y);
            result.z = Number(el.z);
         }
         else
         {
            result.x = result.y = result.z = 0;
         }
      }
      
      private static function xmlToString(xml:XML, defaultValue:String) : String
      {
         if(xml == null)
         {
            return defaultValue;
         }
         return xml.toString() || defaultValue;
      }
      
      public function load(url:String, libRegistry:PropLibRegistry) : void
      {
         if(url == null)
         {
            throw new ArgumentError("Parameter url cannot be null");
         }
         if(libRegistry == null)
         {
            throw new ArgumentError("Parameter libRegistry cannot be null");
         }
         this.propLibRegistry = libRegistry;
         this.loader = new URLLoader();
         this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.loader.load(new URLRequest(url));
      }
      
      public function get lights() : Vector.<Light3D>
      {
         return this._lights;
      }
      
      public function get objects() : Vector.<Object3D>
      {
         return this._objects;
      }
      
      public function get sprites() : Vector.<Object3D>
      {
         return this._sprites;
      }
      
      public function getFlagPosition(type:String) : Vector3D
      {
         var xmlList:XMLList = this.mapXml.elements("ctf-flags").elements("flag-" + type);
         if(xmlList.length() == 0)
         {
            return null;
         }
         var position:Vector3D = new Vector3D();
         readVector3D(xmlList,position);
         return position;
      }
      
      public function get visualCollisionObjects() : Vector.<Object3D>
      {
         /*var colXml:XML = null;
         var v0:Vector3D = null;
         var v1:Vector3D = null;
         var v2:Vector3D = null;
         var w:Number = NaN;
         var l:Number = NaN;
         var plane:Plane = null;
         var size:Vector3D = null;
         var box:Box = null;
         var tri:Triangle = null;*/
         if(this._visualCollisionObjects != null)
         {
            return this._visualCollisionObjects;
         }
         this._visualCollisionObjects = new Vector.<Object3D>();
         /*var components:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(1,1,1)]);
         var matrix:Matrix3D = new Matrix3D();
         for each(colXml in this.mapXml.elements("collision-geometry").elements("collision-plane"))
         {
            w = Number(colXml.width);
            l = Number(colXml.length);
            plane = new Plane(w,l);
            readVector3D(colXml.position,components[0]);
            readVector3D(colXml.rotation,components[1]);
            matrix.recompose(components);
            plane.matrix = matrix;
            this._visualCollisionObjects.push(plane);
         }
         for each(colXml in this.mapXml.elements("collision-geometry").elements("collision-box"))
         {
            size = components[0];
            readVector3D(colXml.size,size);
            box = new Box(size.x,size.y,size.z);
            readVector3D(colXml.position,components[0]);
            readVector3D(colXml.rotation,components[1]);
            matrix.recompose(components);
            box.matrix = matrix;
            this._visualCollisionObjects.push(box);
         }
         v0 = new Vector3D();
         v1 = new Vector3D();
         v2 = new Vector3D();
         for each(colXml in this.mapXml.elements("collision-geometry").elements("collision-triangle"))
         {
            readVector3D(colXml.v0,v0);
            readVector3D(colXml.v1,v1);
            readVector3D(colXml.v2,v2);
            tri = new Triangle(v0,v1,v2,false);
            readVector3D(colXml.position,components[0]);
            readVector3D(colXml.rotation,components[1]);
            matrix.recompose(components);
            tri.matrix = matrix;
            this._visualCollisionObjects.push(tri);
         }*/
         return this._visualCollisionObjects;
      }
      
      private function onLoadingComplete(e:Event) : void
      {
         this.mapXml = XML(this.loader.data);
         this.loader = null;
         this.parseProps();
         this.parseCollisionPrimitives();
         this.runTextureBuilder();
      }
      
      private function parseProps() : void
      {
         var propXML:XML = null;
         this.materialUsersRegistry = new MaterialUsersRegistry();
         for each(propXML in this.mapXml.elements("static-geometry").prop)
         {
            this.parseProp(propXML);
         }
      }
      
      private function parseProp(propXml:XML) : void
      {
         var propObject:PropObject = this.getPropObject(propXml);
         if(propObject is PropMesh)
         {
            this.parsePropMesh(propXml,PropMesh(propObject));
         }
         else if(propObject is PropSprite)
         {
            this.parsePropSprite(propXml,PropSprite(propObject));
         }
      }
      
      private function getPropObject(propXml:XML) : PropObject
      {
         var libName:String = propXml.attribute("library-name");
         var groupName:String = propXml.attribute("group-name");
         var propName:String = propXml.@name;
         var library:PropLibrary = this.propLibRegistry.getLibrary(libName);
         if(library == null)
         {
            throw new Error("Library not found " + libName);
         }
         var group:PropGroup = library.rootGroup.getGroupByName(groupName);
         if(group == null)
         {
            throw new Error("Group not found " + groupName);
         }
         var propData:PropData = group.getPropByName(propName);
         if(propData == null)
         {
            throw new Error("Prop data not found " + propName);
         }
         return propData.getDefaultState().getDefaultObject();
      }
      
      private function parsePropMesh(propXml:XML, propMesh:PropMesh) : void
      {
         //var omni:OmniLight = null;
         var mesh:Mesh = Mesh(propMesh.object.clone());
         var textureName:String = xmlToString(propXml.elements("texture-name")[0],PropMesh.DEFAULT_TEXTURE);
         if(textureName == "invisible")
         {
            return;
         }
         var position:Vector3D = components[0];
         var rotation:Vector3D = components[1];
		 readVector3D(propXml.position, position);
		 readVector3D(propXml.rotation, rotation);
         this._objects.push(mesh);
         mesh.x = position.x;
         mesh.y = position.y;
         mesh.z = position.z;
         /*if(propXml.elements("texture-name")[0] == "pumpkin")
         {
            omni = new OmniLight(16744448,500,1000);
            omni.x = bsp.x;
            omni.y = bsp.y;
            omni.z = bsp.z - 400;
            this._lights.push(omni);
         }*/
		 mesh.rotationZ = rotation.z;
         this.materialUsersRegistry.addMesh(propMesh,textureName,new MeshWrapper(mesh));
      }
      
      private function parsePropSprite(propXml:XML, propSprite:PropSprite) : void
      {
         var sprite:Sprite3D = Sprite3D(propSprite.object.clone());
         this._sprites.push(sprite);
         var position:Vector3D = components[0];
         readVector3D(propXml.position,position);
         sprite.x = position.x;
         sprite.y = position.y;
         sprite.z = position.z;
         sprite.width = propSprite.scale;
         this.materialUsersRegistry.addSprite3D(propSprite,new Sprite3DWrapper(sprite));
      }
      
      private function parseCollisionPrimitives() : void
      {
         /*var rotation:Vector3 = null;
         var primitive:CollisionPrimitive = null;
         var primitiveXml:XML = null;
         var v0:Vector3 = null;
         var v1:Vector3 = null;
         var v2:Vector3 = null;
         this._collisionPrimitives = new Vector.<CollisionPrimitive>();
         var rotationMatrix:Matrix3 = new Matrix3();
         var halfSize:Vector3 = new Vector3();
         var position:Vector3 = new Vector3();
         rotation = new Vector3();
         var collisionXml:XMLList = this.mapXml.elements("collision-geometry")[0].elements("collision-plane");
         for each(primitiveXml in collisionXml)
         {
            halfSize.x = 0.5 * Number(primitiveXml.width);
            halfSize.y = 0.5 * Number(primitiveXml.length);
            halfSize.z = 0;
            readVector3(primitiveXml.position,position);
            readVector3(primitiveXml.rotation,rotation);
            rotationMatrix.setRotationMatrix(rotation.x,rotation.y,rotation.z);
            primitive = new CollisionRect(halfSize,STATIC_COLLISION_GROUP);
            primitive.transform.setFromMatrix3(rotationMatrix,position);
            this._collisionPrimitives.push(primitive);
         }
         collisionXml = this.mapXml.elements("collision-geometry")[0].elements("collision-box");
         for each(primitiveXml in collisionXml)
         {
            readVector3(primitiveXml.size,halfSize);
            halfSize.scaleBy(0.5);
            readVector3(primitiveXml.position,position);
            readVector3(primitiveXml.rotation,rotation);
            rotationMatrix.setRotationMatrix(rotation.x,rotation.y,rotation.z);
            primitive = new CollisionBox(halfSize,STATIC_COLLISION_GROUP);
            primitive.transform.setFromMatrix3(rotationMatrix,position);
            this._collisionPrimitives.push(primitive);
         }
         v0 = new Vector3();
         v1 = new Vector3();
         v2 = new Vector3();
         collisionXml = this.mapXml.elements("collision-geometry")[0].elements("collision-triangle");
         for each(primitiveXml in collisionXml)
         {
            readVector3(primitiveXml.v0,v0);
            readVector3(primitiveXml.v1,v1);
            readVector3(primitiveXml.v2,v2);
            if(!(isNaNVector(v0) || isNaNVector(v1) || isNaNVector(v2)))
            {
               readVector3(primitiveXml.position,position);
               readVector3(primitiveXml.rotation,rotation);
               rotationMatrix.setRotationMatrix(rotation.x,rotation.y,rotation.z);
               primitive = new CollisionTriangle(v0,v1,v2,STATIC_COLLISION_GROUP);
               primitive.transform.setFromMatrix3(rotationMatrix,position);
               this._collisionPrimitives.push(primitive);
            }
         }*/
      }
      
      private function runTextureBuilder() : void
      {
         this.batchTextureBuilder = new BatchTextureBuilder();
         this.batchTextureBuilder.addEventListener(Event.COMPLETE,this.onTexturesComplete);
         this.batchTextureBuilder.run(this.mipMapResolution,MAX_BATCH_SIZE,this.materialUsersRegistry.meshEntries,this.materialUsersRegistry.spriteEntries);
      }
      
      private function onTexturesComplete(e:Event) : void
      {
         this.batchTextureBuilder.removeEventListener(Event.COMPLETE,this.onTexturesComplete);
         this.batchTextureBuilder = null;
         this.complete();
      }
      
      private function complete() : void
      {
         this.propLibRegistry = null;
         this.materialUsersRegistry = null;
         if(hasEventListener(Event.COMPLETE))
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}
