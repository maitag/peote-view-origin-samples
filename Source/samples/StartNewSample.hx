/*
 *        o-o    o-o  o-o-o  o-o    
 *       o   o  o        o      o   
 *      o-o-o  o-o   o    o    o-o  
 *     o      o     (_\    o      o 
 *    o      o-o     |\     o    o-o
 * 
 * PEOTE VIEW - haxe 2D OpenGL Render Library
 * Copyright (c) 2014 Sylvio Sell, http://maitag.de
 * 
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package samples;

import lime.ui.Touch;
import peote.view.PeoteView;
import peote.view.displaylist.DisplaylistType;
import haxe.Timer;

import lime.ui.Window;

class StartNewSample extends Sample
{
	public override function init() 
	{
		peoteView = new PeoteView({
			maxDisplaylists:    10,
			maxPrograms:       100,
			maxTextures:       100,
			maxImages:        1000
		});		
	}
	
	public override function run():Void
	{
		// -----------------------------------------------------
		// --------------------- TEXTURECACHES -----------------
		// -----------------------------------------------------
		
		peoteView.setTexture( {  texture: 0,
			
			w:   512,        // Texture width
			h:   512,        // Texture height	
			slots: 16
			//type: RGBA  // not implemented yes (allways RGBA)
		});
		
		// -----------------------------------------------------
		// ------------------- IMAGES --------------------------
		// -----------------------------------------------------
		
		peoteView.setImage( {  image: 0,
		
			texture:0,
			filename: "assets/peote_tiles.png"
		});
		
		peoteView.setImage( {  image: 1,
		
			texture:0,
			filename: "assets/peote_tiles_bunnys.png"
		});
		
		// -----------------------------------------------------
		// ---------------- PROGRAM SHADER ---------------------
		// -----------------------------------------------------
		peoteView.setProgram( {	program: 0,
			texture: 0
		});
		
		
		// -----------------------------------------------------
		// ---------------- DISPLAYLISTS -----------------------
		// -----------------------------------------------------
		peoteView.setDisplaylist( {	displaylist: 0,
			
			type: DType.ANIM |
			      DType.RGBA |
				  DType.ROTATION |
				  DType.PICKING |
				  DType.ZINDEX
				,
			
			maxElements:       10000,
			bufferSegmentSize:  5000,
			bufferSegments:        2,
			
			x: 0,
			y: 0,
			w: 512,
			h: 512,
			z: 0,
			
			renderBackground:true,

			r:0.1,
			g:0.5,
			b:0.8,
			a:0.8,
			
			blend:1, // alpha blending
			
			enable:true
		});
		
		// -----------------------------------------------------
		// ---------------- ELEMENTS ---------------------------
		// -----------------------------------------------------
		//peoteView.setElementDefaults( { displaylist:0 } );
		
		peoteView.setElement({
			element:0,
			x:100, y:100,
			w:100, h:100,
			z:32767,  // max z-value
			pivotX:50, pivotY:50,
			rotation:-90,
			program:0,
			image:0,
			tile:1
		});
		
		peoteView.setElement({
			element:1,
			x:200, y:100,
			w:100, h:100,
			z:32766,
			pivotX:40, pivotY:70,
			end: {
				rotation:360 * 3,
				time: peoteView.time + 5
			},
			program:0,
			image:1,
			tile:2
		});
		

	}


	public override function onMouseDown (_window:Window, x:Float, y:Float, button:Int):Void
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
	

}