package alternativa.tanks.config.loaders 
{
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.materials.EnvironmentMaterial;
	import alternativa.engine3d.materials.StandardMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.materials.VertexLightTextureMaterial;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import utils.textureutils.ITextureConstructorListener;
	import utils.textureutils.TextureByteData;
	import utils.textureutils.TextureConstructor;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class BatchTextureBuilder extends EventDispatcher implements ITextureConstructorListener
	{
   
	   private var maxBatchSize:int;
	   
	   private var batchSize:int;
	   
	   private var firstBatchIndex:int;
	   
	   private var batchCouner:int;
	   
	   private var totalCounter:int;
	   
	   private var entries:Vector.<MaterialUserEntry>;
	   	   
	   private var constructors:Vector.<IndexedTextureConstructor>;
	   
	   function BatchTextureBuilder()
	   {
		  super();
	   }
	   
	   public function run(mipMapResolution:Number, maxBatchSize:int, bspEntries:Vector.<BSPMaterialUserEntry>, spriteEntries:Vector.<Sprite3DMaterialUserEntry>) : void
	   {
		  var bspEntry:BSPMaterialUserEntry = null;
		  var spriteEntry:Sprite3DMaterialUserEntry = null;
		  this.maxBatchSize = maxBatchSize;
		  this.constructors = new Vector.<IndexedTextureConstructor>(maxBatchSize);
		  for(var i:int = 0; i < maxBatchSize; i++)
		  {
			 this.constructors[i] = new IndexedTextureConstructor();
		  }
		  this.entries = new Vector.<MaterialUserEntry>();
		  for each(bspEntry in bspEntries)
		  {
			 this.entries.push(bspEntry);
		  }
		  for each(spriteEntry in spriteEntries)
		  {
			 this.entries.push(spriteEntry);
		  }
		  this.totalCounter = 0;
		  this.firstBatchIndex = 0;
		  this.createBatch();
	   }
	   
	   public function onTextureReady(constructor:TextureConstructor,dsaa:Boolean) : void
	   {
		  var materialUser:IMaterialUser = null;
		  var textureConstructor:IndexedTextureConstructor = IndexedTextureConstructor(constructor);
		  var t:BitmapTextureResource = new BitmapTextureResource(textureConstructor.texture);
		  //dsaa = true;
		  if (dsaa)
		  {
			  var t1:TextureMaterial = new TextureMaterial(t);
			  t1.alphaThreshold = 1;
			  for each(materialUser in this.entries[textureConstructor.index].materialUsers)
			  {
				 materialUser.setMaterial(t1);
			  }
		  }else{
			  var te:BitmapData = textureConstructor.texture;
			  var normal:BitmapData = new BitmapData(1, 1, false, 0x7F7FFF);
			  var t2:BitmapTextureResource = new BitmapTextureResource(normal, true);
			  var m:StandardMaterial = new StandardMaterial(t,t2);
			  //m.specularMap = new BitmapTextureResource(new BitmapData(normal.width, normal.height, false, 0xff000000), true);
			  //m.alphaThreshold = 1;
			  m.specularPower = 0;
			  for each(materialUser in this.entries[textureConstructor.index].materialUsers)
			  {
				 materialUser.setMaterial(m);
			  }
		  }
		  this.totalCounter++;
		  this.batchCouner++;
		  if(this.totalCounter == this.entries.length)
		  {
			 this.complete();
		  }
		  else if(this.batchCouner == this.batchSize)
		  {
			 this.createBatch();
		  }
	   }
	   
	   private function createBatch() : void
	   {
		  var textureConstructor:IndexedTextureConstructor = null;
		  var textureData:TextureByteData = null;
		  this.batchCouner = 0;
		  var nextIndex:int = this.firstBatchIndex + this.maxBatchSize;
		  if(nextIndex > this.entries.length)
		  {
			 nextIndex = this.entries.length;
		  }
		  this.batchSize = nextIndex - this.firstBatchIndex;
		  for(var i:int = 0; i < this.batchSize; i++)
		  {
			 textureConstructor = this.constructors[i];
			 textureConstructor.index = this.firstBatchIndex + i;
			 textureData = this.entries[textureConstructor.index].getTextureData();
			 if (this.entries[textureConstructor.index] is Sprite3DMaterialUserEntry)
			 {
				textureConstructor.createTexture(textureData, this, true);
			 }else{
				textureConstructor.createTexture(textureData, this);
			 }
		  }
		  this.firstBatchIndex = nextIndex;
	   }
	   
	   private function complete() : void
	   {
		  this.constructors = null;
		  this.entries = null;
		  dispatchEvent(new Event(Event.COMPLETE));
	   }
		
	}

}