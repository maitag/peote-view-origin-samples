package samples;

import peote.view.PeoteView;
import peote.view.displaylist.DisplaylistType;

import lime.ui.Window;

class Picking extends Sample
{
	public override function init() 
	{
		peoteView = new PeoteView({
			maxDisplaylists:    1,
			maxPrograms:        1,
			maxTextures:        1,
			maxImages:          1
		});
		
	}
	
	public override function run():Void
	{
		// --------------------- TEXTURECACHES -----------------		
		peoteView.setTexture( {
			texture: 0,
			w:   512,        // Texture width
			h:   512,        // Texture height
		});

		// ------------------- IMAGES --------------------------
		peoteView.setImage({
			image: 0,
			texture: 0,
			filename: "assets/peote_tiles.png"
		});
		
		// ---------------- PROGRAM SHADER ---------------------
		peoteView.setProgram( {
			program: 0,
			texture: 0
		});
		
		// ---------------- DISPLAYLISTS -----------------------		
		peoteView.setDisplaylist( {
			displaylist:0,
			type:DType.ANIM|DType.RGBA|DType.ROTATION|DType.PICKING|DType.ZINDEX,
			maxElements:3,
			x:0, y:0,
			w:512, h:384,
			renderBackground:true,
			r:0.1,g:0.5,b:0.8, a:0.8
		});

		
		// ---------------- ELEMENTS ---------------------------		
		peoteView.setElementDefaults( { displaylist:0, program:0, image:0, w:100, h:100 } );
		
		peoteView.setElement({
			element:0,
			x:0, y:0,
			rgba:0xffff00ff,
			pivotX:50,
			pivotY:50,
			rotation:360,
			end: {
				x:400,
				rotation:180,
				time: peoteView.time + 20,
				rgba:0x00ffffff
			},
			tile:1
		});
		peoteView.setElement({
			element:1,
			x:100, y:100,
			pivotX:50, pivotY:50,
			rotation: -90,
			tile:2
		});
		peoteView.setElement({
			element:2,
			x:150, y:100,
			pivotX:50, pivotY:50,
			rotation:135,
			tile:3
		});

	}
	
	public override function onMouseDown (window:Window, x:Float, y:Float, button:Int):Void
	{
		// pick element number from displaylist 0
		var e:Int = peoteView.pick(0, mouse_x, mouse_y, zoom, xOffset, yOffset);
		if (e != -1)
		{
			peoteView.setElement( { element:e,
				tile: peoteView.getElement({element:e}).tile+1
			});
		}
		
	}
	/*
	public override function onMouseMove (window:Window, x:Float, y:Float):Void
	{		
		super.onMouseMove(window, x, y);

		var e:Int = peoteView.pick(0, mouse_x, mouse_y, zoom, xOffset, yOffset);
		if (e != -1)
		{
			trace('MouseOver Element: $e');
		}
		
	}
	*/


	
}