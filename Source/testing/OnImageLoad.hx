package testing;

import haxe.Timer;

import peote.view.PeoteView;
import peote.view.displaylist.DisplaylistType;

import samples.Sample;

import lime.ui.Window;

class OnImageLoad extends Sample
{
	public override function init() 
	{
		peoteView = new PeoteView({
			maxDisplaylists:     2,
			maxPrograms:         3,
			maxTextures:         2,
			maxImages:           2
		});
		
	}
	
	public override function run()
	{	
		// ------------------- TEXTURE -------------------------		
		peoteView.setTexture( {  texture: 0,
			//slots: 2,
			w:   512,
			h:   512,
		});
		
		// ------------------- IMAGE --------------------------
		peoteView.setImage( {  image: 0,
			texture:0,
			filename: "assets/peote_font_white.png",
		});
		
		// ------------------- TEXTURE -------------------------		
		peoteView.setTexture( {  texture: 1,
			//slots: 2,
			w:   512,
			h:   512,
		});
		// ------------------- IMAGE --------------------------
		peoteView.setImage( {  image: 1,
			texture:1,
			filename: "assets/peote_tiles.png",
		});
		
		// ---------------- PROGRAM SHADER ---------------------
		peoteView.setProgram( {	program: 0,
			texture: 0,
		});
		
		peoteView.setProgram( {	program: 1,
			texture: 1,
		});
		/*
		peoteView.setProgram( {	program: 2,
			fshader: 'assets/lyapunov_01.frag'
		});*/
		
		// ---------------- DISPLAYLISTS -----------------------
		peoteView.setDisplaylist( {	displaylist: 0,
			
			type: DisplaylistType.ANIM |
			      DType.RGBA |
				  DType.ROTATION |
				  DType.ZINDEX
				,
			
			maxElements:        3,
			bufferSegmentSize:  2,
			bufferSegments:     2,
			
			x: 0, y: 0, w: 512,	h: 512,
			z:0,
			
			renderBackground:true,
			r:0.2, g:0.3, b:0.8, a:1.0,
			
			//blend:0,
			enable:true
		});
		
		// ---------------- ELEMENTS ---------------------------
		peoteView.setElementDefaults( { displaylist:0 } );
		
		peoteView.setElement( { element:0,
			x:0, y:0,
			w:256, h:256,
			program:0,
			image:0,
		});
		peoteView.setElement( { element:1,
			x:256, y:0,
			w:256, h:256,
			program:1,
			image:1,
		});
		
		var timer = new Timer(1000);
		timer.run = function() {
			timer.stop();
			peoteView.setElement( { element:2,
				x:0, y:256,
				w:256, h:256,
				program:0,
				image:0,
			});
		}
	}
	
}