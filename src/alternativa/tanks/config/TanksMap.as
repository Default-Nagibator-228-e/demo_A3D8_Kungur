package alternativa.tanks.config
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.materials.StandardMaterial;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.MeshSet;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.config.loaders.MapLoader;
   import alternativa.tanks.config.loaders.PlusMesh;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Vector3D;
   import utils.ResourceManager;
      
   public class TanksMap extends ResourceLoader
   {
       
      
      public var mapContainer:Object3D;
      
      private var loader:MapLoader;
      
      private var spawnMarkers:Object;
      
      private var ctfFlags:Object;
      
      private var mapId:String;
      
      public function TanksMap(config:Config, idMap:String)
      {
         this.spawnMarkers = {};
         this.ctfFlags = {};
         this.mapId = idMap;
         super("Tank map loader", config);
      }
      
      override public function run() : void
      {
         if(config.xml.map.length() == 0)
         {
            throw new Error("No map found");
         }
         this.loader = new MapLoader();
         this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
         this.loader.load(this.mapId + ".xml",config.propLibRegistry);
      }
      
      public function showCTFFlagMarker(type:String) : void
      {
         var marker:Object3D = this.getCTFFlagMarker(type);
         if(marker != null && marker.parent == null)
         {
            this.mapContainer.addChild(marker);
         }
      }
      
      public function hideCTFFlagMarker(type:String) : void
      {
         var marker:Object3D = this.getCTFFlagMarker(type);
         if(marker != null && marker.parent != null)
         {
            this.mapContainer.removeChild(marker);
         }
      }
      
      public function toggleCTFFlagMarker(type:String) : void
      {
         var marker:Object3D = this.getCTFFlagMarker(type);
         if(marker != null)
         {
            if(marker.parent != null)
            {
               this.mapContainer.removeChild(marker);
            }
            else
            {
               this.mapContainer.addChild(marker);
            }
         }
      }
      
      private function getCTFFlagMarker(type:String) : Sprite3D
      {
         var pos:Vector3D = null;
         var texture:BitmapData = null;
         var sprite:Sprite3D = this.ctfFlags[type];
         if(sprite == null)
         {
            pos = this.loader.getFlagPosition(type);
            if(pos == null)
            {
               return null;
            }
            texture = config.textureLibrary.getTexture(type + "_flag");
            sprite = new Sprite3D(texture.width,texture.height);
            sprite.originX = 0;
            sprite.originY = 1;
			var t:BitmapTextureResource = new BitmapTextureResource(texture);
		    var t1:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1, 1, false, 0x7F7FFF));
		    var t2:StandardMaterial = new StandardMaterial(t, t1);
		    t2.specularPower = 0.1;
            sprite.material = t2;
            sprite.x = pos.x;
            sprite.y = pos.y;
            sprite.z = pos.z;
            this.ctfFlags[type] = sprite;
         }
         return sprite;
      }
      
      private function onLoadingComplete(e:Event) : void
      {
		 var sa:Mesh;
		 var k:int = 0;
		 for each(sa in this.loader.objects)
		 {
			Main.scene.addChild(sa);
			Main.shadow.addCaster(sa);
		 }
		 var sprite:Sprite3D = null;
         for each(sprite in this.loader.sprites)
         {
            Main.scene.addChild(sprite);
			sprite.useShadow = false;
         }
         completeTask();
      }
   }
}

import alternativa.engine3d.core.Object3D;

class SpawnMarkersData
{
    
   
   public var markers:Vector.<Object3D>;
   
   function SpawnMarkersData()
   {
      super();
   }
}
