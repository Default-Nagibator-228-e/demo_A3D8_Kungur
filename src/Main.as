package
{

	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Light3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.lights.AmbientLight;
	import alternativa.engine3d.lights.DirectionalLight;
	import alternativa.engine3d.loaders.ExporterA3D;
	import alternativa.engine3d.loaders.Parser3DS;
	import alternativa.engine3d.loaders.ParserA3D;
	import alternativa.engine3d.loaders.ParserCollada;
	import alternativa.engine3d.loaders.ParserMaterial;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.loaders.events.TexturesLoaderEvent;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.StandardMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.materials.VertexLightTextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.SkyBox;
	import alternativa.engine3d.objects.Surface;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import alternativa.engine3d.resources.Geometry;
	import alternativa.engine3d.shadows.DirectionalLightShadow;
	import alternativa.tanks.config.Config;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.StageQuality;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.events.TextEvent;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import utils.MaterialProcessor;
	import utils.ResourceManager;

	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Main extends Sprite {

		public static var stage3D:Stage3D;
		[Embed(source="/model/KungurAD.a3d", mimeType="application/octet-stream")]
	private const Model:Class;

	[Embed(source="/model/Tex_0062_0.PNG")]
	private const Texture_1:Class;
	[Embed(source="/model/Tex_0029_0.PNG")]
	private const Texture_2:Class;
	[Embed(source="/model/Tex_0070_0.PNG")]
	private const Texture_3:Class;
	[Embed(source="/model/Tex_0046_0.PNG")]
	private const Texture_4:Class;
	[Embed(source="/model/Tex_0074_0.PNG")]
	private const Texture_5:Class;
	[Embed(source="/model/Tex_0087_0.PNG")]
	private const Texture_6:Class;
	[Embed(source="/model/Tex_0099_0.PNG")]
	private const Texture_7:Class;
	[Embed(source="/model/Tex_0076_0.PNG")]
	private const Texture_8:Class;
	[Embed(source="/model/Tex_0077_0.PNG")]
	private const Texture_9:Class;
	[Embed(source="/model/Tex_0058_0.PNG")]
	private const Texture_10:Class;
	[Embed(source="/model/Tex_0045_0.PNG")]
	private const Texture_11:Class;
	[Embed(source="/model/Tex_0060_0.PNG")]
	private const Texture_12:Class;
	[Embed(source="/model/Tex_0075_0.PNG")]
	private const Texture_13:Class;
	[Embed(source="/model/Tex_0006_0.PNG")]
	private const Texture_14:Class;
	[Embed(source="/model/Tex_0037_0.PNG")]
	private const Texture_15:Class;
	[Embed(source="/model/Tex_0096_0.PNG")]
	private const Texture_16:Class;
	[Embed(source="/model/Tex_0028_0.PNG")]
	private const Texture_17:Class;
	[Embed(source="/model/Tex_0089_0.PNG")]
	private const Texture_18:Class;
	[Embed(source="/model/Tex_0080_0.PNG")]
	private const Texture_19:Class;
	[Embed(source="/model/Tex_0050_0.PNG")]
	private const Texture_20:Class;
	[Embed(source="/model/Tex_0056_0.PNG")]
	private const Texture_21:Class;
	[Embed(source="/model/Tex_0073_0.PNG")]
	private const Texture_22:Class;
	[Embed(source="/model/Tex_0007_0.PNG")]
	private const Texture_23:Class;
	[Embed(source="/model/Tex_0053_0.PNG")]
	private const Texture_24:Class;
	[Embed(source="/model/Tex_0010_0.PNG")]
	private const Texture_25:Class;
	[Embed(source="/model/Tex_0009_0.PNG")]
	private const Texture_26:Class;
	[Embed(source="/model/Tex_0027_0.PNG")]
	private const Texture_27:Class;
	[Embed(source="/model/Tex_0093_0.PNG")]
	private const Texture_28:Class;
	[Embed(source="/model/Tex_0003_0.PNG")]
	private const Texture_29:Class;
	[Embed(source="/model/Tex_0001_0.PNG")]
	private const Texture_30:Class;
	[Embed(source="/model/Tex_0088_0.PNG")]
	private const Texture_31:Class;
	[Embed(source="/model/Tex_0094_0.PNG")]
	private const Texture_32:Class;
	[Embed(source="/model/Tex_0041_0.PNG")]
	private const Texture_33:Class;
	[Embed(source="/model/Tex_0025_0.PNG")]
	private const Texture_34:Class;
	[Embed(source="/model/Tex_0069_0.PNG")]
	private const Texture_35:Class;
	[Embed(source="/model/Tex_0055_0.PNG")]
	private const Texture_36:Class;
	[Embed(source="/model/Tex_0043_0.PNG")]
	private const Texture_37:Class;
	[Embed(source="/model/Tex_0067_0.PNG")]
	private const Texture_38:Class;
	[Embed(source="/model/Tex_0051_0.PNG")]
	private const Texture_39:Class;
	[Embed(source="/model/Tex_0036_0.PNG")]
	private const Texture_40:Class;
	[Embed(source="/model/Tex_0042_0.PNG")]
	private const Texture_41:Class;
	[Embed(source="/model/Tex_0039_0.PNG")]
	private const Texture_42:Class;
	[Embed(source="/model/Tex_0095_0.PNG")]
	private const Texture_43:Class;
	[Embed(source="/model/Tex_0085_0.PNG")]
	private const Texture_44:Class;
	[Embed(source="/model/Tex_0059_0.PNG")]
	private const Texture_45:Class;
	[Embed(source="/model/Tex_0005_0.PNG")]
	private const Texture_46:Class;
	[Embed(source="/model/Tex_0044_0.PNG")]
	private const Texture_47:Class;
	[Embed(source="/model/Tex_0023_0.PNG")]
	private const Texture_48:Class;
	[Embed(source="/model/Tex_0000_0.PNG")]
	private const Texture_49:Class;
	[Embed(source="/model/Tex_0054_0.PNG")]
	private const Texture_50:Class;
	[Embed(source="/model/Tex_0022_0.PNG")]
	private const Texture_51:Class;
	[Embed(source="/model/Tex_0008_0.PNG")]
	private const Texture_52:Class;
	[Embed(source="/model/Tex_0086_0.PNG")]
	private const Texture_53:Class;
	[Embed(source="/model/Tex_0084_0.PNG")]
	private const Texture_54:Class;
	[Embed(source="/model/Tex_0012_0.PNG")]
	private const Texture_55:Class;
	[Embed(source="/model/Tex_0090_0.PNG")]
	private const Texture_56:Class;
	[Embed(source="/model/Tex_0004_0.PNG")]
	private const Texture_57:Class;
	[Embed(source="/model/Tex_0083_0.PNG")]
	private const Texture_58:Class;
	[Embed(source="/model/Tex_0068_0.PNG")]
	private const Texture_59:Class;
	[Embed(source="/model/Tex_0038_0.PNG")]
	private const Texture_60:Class;
	[Embed(source="/model/Tex_0017_0.PNG")]
	private const Texture_61:Class;
	[Embed(source="/model/Tex_0019_0.PNG")]
	private const Texture_62:Class;
	[Embed(source="/model/Tex_0047_0.PNG")]
	private const Texture_63:Class;
	[Embed(source="/model/Tex_0049_0.PNG")]
	private const Texture_64:Class;
	[Embed(source="/model/Tex_0016_0.PNG")]
	private const Texture_65:Class;
	[Embed(source="/model/Tex_0002_0.PNG")]
	private const Texture_66:Class;
	[Embed(source="/model/Tex_0082_0.PNG")]
	private const Texture_67:Class;
	[Embed(source="/model/Tex_0020_0.PNG")]
	private const Texture_68:Class;
	[Embed(source="/model/Tex_0072_0.PNG")]
	private const Texture_69:Class;
	[Embed(source="/model/Tex_0035_0.PNG")]
	private const Texture_70:Class;
	[Embed(source="/model/Tex_0015_0.PNG")]
	private const Texture_71:Class;
	[Embed(source="/model/Tex_0078_0.PNG")]
	private const Texture_72:Class;
	[Embed(source="/model/Tex_0081_0.PNG")]
	private const Texture_73:Class;
	[Embed(source="/model/Tex_0064_0.PNG")]
	private const Texture_74:Class;
	[Embed(source="/model/Tex_0091_0.PNG")]
	private const Texture_75:Class;
	[Embed(source="/model/Tex_0031_0.PNG")]
	private const Texture_76:Class;
	[Embed(source="/model/Tex_0014_0.PNG")]
	private const Texture_77:Class;
	[Embed(source="/model/Tex_0061_0.PNG")]
	private const Texture_78:Class;
	[Embed(source="/model/Tex_0097_0.PNG")]
	private const Texture_79:Class;
	[Embed(source="/model/Tex_0092_0.PNG")]
	private const Texture_80:Class;
	[Embed(source="/model/Tex_0057_0.PNG")]
	private const Texture_81:Class;
	[Embed(source="/model/Tex_0033_0.PNG")]
	private const Texture_82:Class;
	[Embed(source="/model/Tex_0034_0.PNG")]
	private const Texture_83:Class;
	[Embed(source="/model/Tex_0021_0.PNG")]
	private const Texture_84:Class;
	[Embed(source="/model/Tex_0024_0.PNG")]
	private const Texture_85:Class;
	[Embed(source="/model/Tex_0066_0.PNG")]
	private const Texture_86:Class;
	[Embed(source="/model/Tex_0065_0.PNG")]
	private const Texture_87:Class;
	[Embed(source="/model/Tex_0063_0.PNG")]
	private const Texture_88:Class;
	[Embed(source="/model/Tex_0013_0.PNG")]
	private const Texture_89:Class;
	[Embed(source="/model/Tex_0098_0.PNG")]
	private const Texture_90:Class;
	[Embed(source="/model/Tex_0071_0.PNG")]
	private const Texture_91:Class;
	[Embed(source="/model/Tex_0079_0.PNG")]
	private const Texture_92:Class;
	[Embed(source="/model/Tex_0040_0.PNG")]
	private const Texture_93:Class;
	[Embed(source="/model/Tex_0048_0.PNG")]
	private const Texture_94:Class;
	[Embed(source="/model/Tex_0011_0.PNG")]
	private const Texture_95:Class;
	[Embed(source="/model/Tex_0032_0.PNG")]
	private const Texture_96:Class;
	[Embed(source="/model/Tex_0030_0.PNG")]
	private const Texture_97:Class;
	[Embed(source="/model/Tex_0018_0.PNG")]
	private const Texture_98:Class;
		private var resourceManager:ResourceManager;
		public static var resourceManager1:ResourceManager;
		public static var scene:Object3D;
		private var mainCamera:Camera3D;
		private var dirLight:DirectionalLight;
		public static var shadow:DirectionalLightShadow;

		private var controller:SimpleObjectController;
		
		private var displayText:TextField;
		
		private var displayText1:TextField;
		
		private var loader:Loader = new Loader();
		
		private const RESOURCE_LIMIT_ERROR_ID:int = 3691;
		
		public static var saqq:int = 0;

		public function Main() {
			if (stage == null) {
				addEventListener(Event.ADDED_TO_STAGE, init);
			} else {
				init();
			}
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			stage.quality = StageQuality.HIGH;

			scene = new Object3D();
			
			resourceManager = new ResourceManager(scene);
			
			stage3D = stage.stage3Ds[0];
			if (stage3D.context3D != null) {
				onContext3DCreate();
			} else {
				stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
				stage3D.requestContext3D(Context3DRenderMode.AUTO);
			}

			mainCamera = new Camera3D(10, 50000);
			mainCamera.view = new View(stage.stageWidth, stage.stageHeight, false, 0, 1, 0);
			scene.addChild(mainCamera);

			addChild(mainCamera.view);
			addChild(mainCamera.diagram);
			
			initHUD();
			initController();
			prepareView();
			prepareLightsAndShadows();
		}
		
		private function initHUD():void {
			var info:TextInfo = new TextInfo();
			info.x = 10;
			info.y = 10;
			info.write("Map viewer");
			info.write("----");
			info.write("Про — передвижение");
			info.write("WSAD and Arrows — передвижение");
			info.write("Q — сглаживание включить/выключить");
			info.write("----");

			info.write("U — SSAO эффект включить/выключить");
			info.write("I — тени включить/выключить");
			info.write("----");

			info.write("+/- — интенсивность SSAO");
			addChild(info);
		}
		
		private function prepareView():void {
			controller.speed = 800;
			//mainCamera.view.backgroundColor = 0x146298;
			//mainCamera.farClipping = 500;
			//mainCamera.matrix = new Matrix3D(Vector.<Number>([-0.2912704050540924, 0.9566407799720764, 0, 0, -0.4682687222957611, -0.1425747573375702, -0.8720073699951172, 0, -0.8341978192329407, -0.25398993492126465, 0.4894927442073822, 0, 52.13594436645508, 19.32925796508789, 3.971318483352661, 1]));
			controller.smoothingDelay = 0.7;
			//controller.updateObjectTransform();

			/*mainCamera.effectMode = Camera3D.MODE_SSAO_COLOR;
			// Following four parameters depend on scene dimension / camera dimension ratio
			// We relied that in the current scene the camera sees about 30 units of 3d space
			// And the broken house has similar size
			mainCamera.ssaoAngular.occludingRadius = 0.7;
			mainCamera.ssaoAngular.secondPassOccludingRadius = 0.32;
			mainCamera.ssaoAngular.maxDistance = 1;
			mainCamera.ssaoAngular.falloff = 7.2;

			mainCamera.ssaoAngular.intensity = 0.85;
			mainCamera.ssaoAngular.secondPassAmount = 0.76;*/
		}
		
		private function inu(e:Event = null):void {
			//Main.shadow.addCaster(scene);
			//var k:ExporterA3D = new ExporterA3D();
			//var d:ByteArray = k.export(scene);
			//trace(d.readUTFBytes(d.bytesAvailable));
			stage.addEventListener(Event.ENTER_FRAME, on);
			//stage.addEventListener(Event.EXIT_FRAME, on1);
			stage.addEventListener(Event.RESIZE, onResize);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,iniSky);
			loader.load(new URLRequest("resources/2.jpg"));
		}
		
		private function prepareLightsAndShadows():void {
			var ambient:AmbientLight = new AmbientLight(0x8bccfa);//0x8bccfa
			ambient.intensity = 0.6;
			scene.addChild(ambient);
			dirLight = new DirectionalLight(Number(String("0x"+"FFA64D")));//0xffd98f//ffd98f
			dirLight.intensity = 1.2;
			dirLight.z = 17025;
			dirLight.x = -5000;
			dirLight.y = -10000;
			dirLight.lookAt(0, 0, 0);
			scene.addChild(dirLight);
			shadow = new DirectionalLightShadow(15000, 12000, -13000, 13000, 2048, 1);
			shadow.biasMultiplier = 0.996;//0.993;
			dirLight.shadow = shadow;
		}

		public function initController():void {
			mainCamera.z = 0;
			//mainCamera.lookAt(-4750, 9750, 1200);
			controller = new SimpleObjectController(stage, mainCamera, 100, 3, 0.7);
		}
		
		public function onContext3DCreate(e:Event = null):void {
			resourceManager.context3D = stage3D.context3D;
			stage3D.context3D.enableErrorChecking = true;
			initScene();
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			//scene.addChild(dirLight);
		}

		/**
		 * Override this method to perform scene initialization
		 */
		/*public function initScene():void {
			//var c:Config = new Config();
			//c.addEventListener(Event.COMPLETE,inu);
			//c.load("config.xml", "map");
			var parser:Parser3DS;
			parser = new Parser3DS();
			parser.parse(new SceneClass());
			var object:Mesh = parser.objects[0] as Mesh;
			//var skyBoxTexture1:BitmapData = new BitmapData(256, 256);
			/*var normal:BitmapData = new BitmapData(1, 1, false, 0x7F7FFF);
			var t2:BitmapTextureResource = new BitmapTextureResource(normal, true);
			var t:BitmapTextureResource = new BitmapTextureResource(skyBoxTexture1);
			var material:StandardMaterial = new StandardMaterial(t, t2);
			material.specularPower = 0;*/
			/*var d:ExternalTextureResource = new ExternalTextureResource("");
			var texture:Texture = stage3D.context3D.createTexture(skyBoxTexture1.width, skyBoxTexture1.height, Context3DTextureFormat.BGRA, true);
			texture.uploadFromBitmapData(skyBoxTexture1, 0);
			BitmapTextureResource.createMips(texture, skyBoxTexture1);
			d.data = texture;
			var skyBoxTexture:BitmapData = new BitmapData(1, 1, false, 0x7F7FFF);
			var d1:ExternalTextureResource = new ExternalTextureResource("");
			var texture1:Texture = stage3D.context3D.createTexture(skyBoxTexture.width, skyBoxTexture.height, Context3DTextureFormat.BGRA, true);
			texture1.uploadFromBitmapData(skyBoxTexture, 0);
			BitmapTextureResource.createMips(texture1, skyBoxTexture);
			d1.data = texture1;
			var material:StandardMaterial = new StandardMaterial(d, d1);
			material.specularPower = 0;
			object.setMaterialToAllSurfaces(material);
			object.scaleX = 1000;
			object.scaleY = 1000;
			object.scaleZ = 1000;
			object.geometry.calculateNormals();
			object.calculateBoundBox();
			scene.addChild(object);
			shadow.addCaster(object);
			inu();
		}*/
		
		public function initScene():void {
			var parser:ParserA3D = new ParserA3D();
			parser.parse(new Model());
			var object:Mesh;
			for each(var obt:* in parser.objects)
			{
				if (obt is Mesh)
				{
					object = Mesh(obt);
					object.geometry.calculateNormals();
					object.geometry.calculateTangents(0);
					object.calculateBoundBox();
					scene.addChild(object);
					shadow.addCaster(object);
				}
			}
			var materialProcessor:MaterialProcessor = new MaterialProcessor(stage3D.context3D);
			//process and initialize materials
			materialProcessor.setupMaterials(parser.objects);

			//get map of "texture url->texture data"
			var textureURLMap:Object = createTextureURLMap();
			//apply external textures
			for each (var textureResource:ExternalTextureResource in scene.getResources(true, ExternalTextureResource)) {
				//get texture name
				var textureName:String = getShortTextureName(textureResource.url).toLocaleLowerCase();
				materialProcessor.setupExternalTexture(textureResource, textureURLMap[textureName]);
			}
			inu();
		}
		
		private function getShortTextureName(name:String):String {
			var shortName:String = name.split("/").pop();
			shortName = shortName.split("\\").pop();
			return shortName;
		}
		
		private function creText(name:String):StandardMaterial {
			var skyBoxTexture1:BitmapData = new BitmapData(256, 256);
			var d:ExternalTextureResource = new ExternalTextureResource("");
			var texture:Texture = stage3D.context3D.createTexture(skyBoxTexture1.width, skyBoxTexture1.height, Context3DTextureFormat.BGRA, true);
			texture.uploadFromBitmapData(skyBoxTexture1, 0);
			BitmapTextureResource.createMips(texture, skyBoxTexture1);
			d.data = texture;
			var skyBoxTexture:BitmapData = new BitmapData(1, 1, false, 0x7F7FFF);
			var d1:ExternalTextureResource = new ExternalTextureResource("");
			var texture1:Texture = stage3D.context3D.createTexture(skyBoxTexture.width, skyBoxTexture.height, Context3DTextureFormat.BGRA, true);
			texture1.uploadFromBitmapData(skyBoxTexture, 0);
			BitmapTextureResource.createMips(texture1, skyBoxTexture);
			d1.data = texture1;
			var material:StandardMaterial = new StandardMaterial(d,d1);
			material.specularPower = 0;
			return material;
		}

	private function createTextureURLMap():Object {
		//map of "texture url->texture data"
		var urlMap:Object = new Object();
		urlMap["tex_0062_0.png"] = new Texture_1();
		urlMap["tex_0029_0.png"] = new Texture_2();
		urlMap["tex_0070_0.png"] = new Texture_3();
		urlMap["tex_0046_0.png"] = new Texture_4();
		urlMap["tex_0074_0.png"] = new Texture_5();
		urlMap["tex_0087_0.png"] = new Texture_6();
		urlMap["tex_0099_0.png"] = new Texture_7();
		urlMap["tex_0076_0.png"] = new Texture_8();
		urlMap["tex_0077_0.png"] = new Texture_9();
		urlMap["tex_0058_0.png"] = new Texture_10();
		urlMap["tex_0045_0.png"] = new Texture_11();
		urlMap["tex_0060_0.png"] = new Texture_12();
		urlMap["tex_0075_0.png"] = new Texture_13();
		urlMap["tex_0006_0.png"] = new Texture_14();
		urlMap["tex_0037_0.png"] = new Texture_15();
		urlMap["tex_0096_0.png"] = new Texture_16();
		urlMap["tex_0028_0.png"] = new Texture_17();
		urlMap["tex_0089_0.png"] = new Texture_18();
		urlMap["tex_0080_0.png"] = new Texture_19();
		urlMap["tex_0050_0.png"] = new Texture_20();
		urlMap["tex_0056_0.png"] = new Texture_21();
		urlMap["tex_0073_0.png"] = new Texture_22();
		urlMap["tex_0007_0.png"] = new Texture_23();
		urlMap["tex_0053_0.png"] = new Texture_24();
		urlMap["tex_0010_0.png"] = new Texture_25();
		urlMap["tex_0009_0.png"] = new Texture_26();
		urlMap["tex_0027_0.png"] = new Texture_27();
		urlMap["tex_0093_0.png"] = new Texture_28();
		urlMap["tex_0003_0.png"] = new Texture_29();
		urlMap["tex_0001_0.png"] = new Texture_30();
		urlMap["tex_0088_0.png"] = new Texture_31();
		urlMap["tex_0094_0.png"] = new Texture_32();
		urlMap["tex_0041_0.png"] = new Texture_33();
		urlMap["tex_0025_0.png"] = new Texture_34();
		urlMap["tex_0069_0.png"] = new Texture_35();
		urlMap["tex_0055_0.png"] = new Texture_36();
		urlMap["tex_0043_0.png"] = new Texture_37();
		urlMap["tex_0067_0.png"] = new Texture_38();
		urlMap["tex_0051_0.png"] = new Texture_39();
		urlMap["tex_0036_0.png"] = new Texture_40();
		urlMap["tex_0042_0.png"] = new Texture_41();
		urlMap["tex_0039_0.png"] = new Texture_42();
		urlMap["tex_0095_0.png"] = new Texture_43();
		urlMap["tex_0085_0.png"] = new Texture_44();
		urlMap["tex_0059_0.png"] = new Texture_45();
		urlMap["tex_0005_0.png"] = new Texture_46();
		urlMap["tex_0044_0.png"] = new Texture_47();
		urlMap["tex_0023_0.png"] = new Texture_48();
		urlMap["tex_0000_0.png"] = new Texture_49();
		urlMap["tex_0054_0.png"] = new Texture_50();
		urlMap["tex_0022_0.png"] = new Texture_51();
		urlMap["tex_0008_0.png"] = new Texture_52();
		urlMap["tex_0086_0.png"] = new Texture_53();
		urlMap["tex_0084_0.png"] = new Texture_54();
		urlMap["tex_0012_0.png"] = new Texture_55();
		urlMap["tex_0090_0.png"] = new Texture_56();
		urlMap["tex_0004_0.png"] = new Texture_57();
		urlMap["tex_0083_0.png"] = new Texture_58();
		urlMap["tex_0068_0.png"] = new Texture_59();
		urlMap["tex_0038_0.png"] = new Texture_60();
		urlMap["tex_0017_0.png"] = new Texture_61();
		urlMap["tex_0019_0.png"] = new Texture_62();
		urlMap["tex_0047_0.png"] = new Texture_63();
		urlMap["tex_0049_0.png"] = new Texture_64();
		urlMap["tex_0016_0.png"] = new Texture_65();
		urlMap["tex_0002_0.png"] = new Texture_66();
		urlMap["tex_0082_0.png"] = new Texture_67();
		urlMap["tex_0020_0.png"] = new Texture_68();
		urlMap["tex_0072_0.png"] = new Texture_69();
		urlMap["tex_0035_0.png"] = new Texture_70();
		urlMap["tex_0015_0.png"] = new Texture_71();
		urlMap["tex_0078_0.png"] = new Texture_72();
		urlMap["tex_0081_0.png"] = new Texture_73();
		urlMap["tex_0064_0.png"] = new Texture_74();
		urlMap["tex_0091_0.png"] = new Texture_75();
		urlMap["tex_0031_0.png"] = new Texture_76();
		urlMap["tex_0014_0.png"] = new Texture_77();
		urlMap["tex_0061_0.png"] = new Texture_78();
		urlMap["tex_0097_0.png"] = new Texture_79();
		urlMap["tex_0092_0.png"] = new Texture_80();
		urlMap["tex_0057_0.png"] = new Texture_81();
		urlMap["tex_0033_0.png"] = new Texture_82();
		urlMap["tex_0034_0.png"] = new Texture_83();
		urlMap["tex_0021_0.png"] = new Texture_84();
		urlMap["tex_0024_0.png"] = new Texture_85();
		urlMap["tex_0066_0.png"] = new Texture_86();
		urlMap["tex_0065_0.png"] = new Texture_87();
		urlMap["tex_0063_0.png"] = new Texture_88();
		urlMap["tex_0013_0.png"] = new Texture_89();
		urlMap["tex_0098_0.png"] = new Texture_90();
		urlMap["tex_0071_0.png"] = new Texture_91();
		urlMap["tex_0079_0.png"] = new Texture_92();
		urlMap["tex_0040_0.png"] = new Texture_93();
		urlMap["tex_0048_0.png"] = new Texture_94();
		urlMap["tex_0011_0.png"] = new Texture_95();
		urlMap["tex_0032_0.png"] = new Texture_96();
		urlMap["tex_0030_0.png"] = new Texture_97();
		urlMap["tex_0018_0.png"] = new Texture_98();
		return urlMap;
	}
		
		public function iniSky(e:Event):void {
			 var skyBoxTexture:BitmapData = (loader.content as Bitmap).bitmapData;
			 var SKYBOX_SIZE:int = 200000;
			 var skyBox:SkyBox = new SkyBox(SKYBOX_SIZE,null,null,null,null,null,null,0.001);
			 var sides:Array = [SkyBox.RIGHT,SkyBox.BACK,SkyBox.LEFT,SkyBox.FRONT,SkyBox.TOP,SkyBox.BOTTOM];
			 for(var i:int = 0; i < sides.length; i++)
			 {
				var skyBoxTexture1:BitmapData = new BitmapData(1024, 1024);
				var re:Rectangle = skyBoxTexture.rect;
				re.x = i*1024;
				skyBoxTexture1.copyPixels(skyBoxTexture,re,new Point(0,0));
				var t:BitmapTextureResource = new BitmapTextureResource(skyBoxTexture1);
				t.upload(Main.stage3D.context3D);
				var material:TextureMaterial = new TextureMaterial(t);
				
				skyBox.getSide(sides[i]).material = material;
			 }
			 skyBox.useShadow = false;
			 scene.addChild(skyBox);
		}

		public function on(e:Event):void {
			if (controller != null) controller.update();
			shadow.centerX = mainCamera.x;
			shadow.centerY = mainCamera.y;
			mainCamera.render(stage3D);
		}

		public function onResize(event:Event = null):void {
			mainCamera.view.width = stage.stageWidth;
			mainCamera.view.height = stage.stageHeight;
			mainCamera.render(stage3D);
		}

		public function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.Q:
					mainCamera.view.antiAlias = (mainCamera.view.antiAlias == 0) ? 4 : 0;
					if (mainCamera.view.antiAlias == 0) {
						// low
						//mainCamera.ssaoScale = 1;
					} else {
						//mainCamera.ssaoScale = 0;
					}
					break;
				case Keyboard.EQUAL:
				case Keyboard.NUMPAD_ADD:
					//mainCamera.ssaoAngular.intensity += (event.shiftKey) ? 0.01 : 0.05;
					break;
				case Keyboard.MINUS:
				case Keyboard.NUMPAD_SUBTRACT:
					//mainCamera.ssaoAngular.intensity -= (event.shiftKey) ? 0.01 : 0.05;
					//mainCamera.ssaoAngular.intensity = mainCamera.ssaoAngular.intensity <= 0 ? 0 : mainCamera.ssaoAngular.intensity;
					break;
				case Keyboard.U:
					//mainCamera.effectMode = mainCamera.effectMode == Camera3D.MODE_COLOR ? Camera3D.MODE_SSAO_COLOR : Camera3D.MODE_COLOR;
					break;
				case Keyboard.I:
					dirLight.shadow = (dirLight.shadow == shadow) ? null : shadow;
					break;
				case Keyboard.B:
					//mainCamera.blurEnabled = !mainCamera.blurEnabled;
					break;
			}
		}

		public function onKeyUp(event:KeyboardEvent):void {
		}

	}
}
