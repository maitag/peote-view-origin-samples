package testing;

import haxe.Timer;

import peote.view.PeoteView;
import peote.view.displaylist.DisplaylistType;

import samples.Sample;

import lime.ui.Window;

class FloatZoom extends Sample
{
	public override function init() 
	{
		// set Time
		startTime = Timer.stamp();
		
		peoteView = new PeoteView({
			maxDisplaylists:     4,
			maxPrograms:         4,
			maxTextures:         4,
			maxImages:           4
		});
	}
	
	public override function run():Void
	{	
		peoteView.setTexture({ texture:0, w:512, h:512, mipmaps:false, magFilter:0,	minFilter:0 });
		peoteView.setTexture({ texture:1, w:512, h:512, mipmaps:false, magFilter:1,	minFilter:1 });
		peoteView.setTexture({ texture:2, w:512, h:512, mipmaps:true , magFilter:0,	minFilter:0 });
		peoteView.setTexture({ texture:3, w:512, h:512, mipmaps:true , magFilter:1,	minFilter:1 });
		
		peoteView.setImage({ image:0, texture:0, filename:"assets/peote_font_white.png", fit:"in" });
		peoteView.setImage({ image:1, texture:1, filename:"assets/peote_font_white.png", fit:"in" });
		peoteView.setImage({ image:2, texture:2, filename:"assets/peote_font_white.png", fit:"in" });
		peoteView.setImage({ image:3, texture:3, filename:"assets/peote_font_white.png", fit:"in" });
		
		peoteView.setProgram({ program:0, texture:0 });
		peoteView.setProgram({ program:1, texture:1 });
		peoteView.setProgram({ program:2, texture:2 });
		peoteView.setProgram({ program:3, texture:3 });
		
		peoteView.setDisplaylist({ displaylist:0, maxElements:1, x:0,   y:0,   w:512, h:512, renderBackground:true, r:0.2, pivotX:256, pivotY:256 });
		peoteView.setDisplaylist({ displaylist:1, maxElements:1, x:514, y:0,   w:512, h:512, renderBackground:true, r:0.2, pivotX:512, pivotY:0   });
		peoteView.setDisplaylist({ displaylist:2, maxElements:1, x:0,   y:514, w:512, h:512, renderBackground:true, r:0.2, pivotX:512, pivotY:512 });
		peoteView.setDisplaylist({ displaylist:3, maxElements:1, x:514, y:514, w:512, h:512, renderBackground:true, r:0.2, pivotX:0,   pivotY:0   });
		
		// ---------------- ELEMENTS ---------------------------
		peoteView.setElement( { displaylist:0, element:0, x:0, y:0, w:512, h:512, program:0, image:0 });
		peoteView.setElement( { displaylist:1, element:0, x:0, y:0, w:512, h:512, program:1, image:1 });
		peoteView.setElement( { displaylist:2, element:0, x:0, y:0, w:512, h:512, program:2, image:2 });
		peoteView.setElement( { displaylist:3, element:0, x:0, y:0, w:512, h:512, program:3, image:3 });
		
		
		var fz:Float = 0.1;
		//peoteView.setDisplaylist({ displaylist:0, zoom:fz });
		
		
		var timer = new Timer(16);
		timer.run = function() {
			if (fz < 2.0) fz *= 1.01; else timer.stop();
			peoteView.setDisplaylist({ displaylist:0, zoom:fz });
			peoteView.setDisplaylist({ displaylist:1, zoom:fz });
			peoteView.setDisplaylist({ displaylist:2, zoom:fz });
			peoteView.setDisplaylist({ displaylist:3, zoom:fz });
			trace(fz);
		}
		
	}
	public override function setOffsets():Void {
		xOffset = -mouse_x;
		yOffset = -mouse_y;
	}
	
}