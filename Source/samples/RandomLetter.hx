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

import haxe.Timer;

import peote.view.PeoteView;
import peote.view.displaylist.DisplaylistType;

class RandomLetter extends Sample
{
	
	var w:Int = 34; //162;
	var h:Int = 20; //110;
	var s:Int = 30; //12;
	var timer:Timer;
	var firstrun:Bool = true;
		
	public override function init() 
	{
		peoteView = new PeoteView({
			maxImages: 2
		});
	}
	
	public override function run():Void
	{		
		// ------------------- TEXTURE ------------------------
		peoteView.setTexture({ texture:0, slots:2, w:512, h:512 });

		// ------------------- IMAGES --------------------------
		peoteView.setImage({image:0, texture:0, filename:"assets/peote_font_white.png"});
		peoteView.setImage({image:1, texture:0, filename:"assets/peote_tiles.png"});
		
		// ------------------- PROGRAM -------------------------
		peoteView.setProgram({ program:0, texture:0 });
		
		// ---------------- DISPLAYLIST -----------------------
		peoteView.setDisplaylist({ displaylist:0, type:DisplaylistType.RGBA, maxElements:w*h  });
		
		// ---------------- ELEMENTS ---------------------------
		peoteView.setElementDefaults({ displaylist:0, z:0, program:0, image:0 });
		
		timer = new Timer(1);
		timer.run = randomizeLetters;
	}
	
	private function randomizeLetters():Void
	{
		timer.stop();
		for (x in 0...w)
		{	for (y in 0...h)
			{	
				var nr:Int = y * w + x;
				if ( !firstrun )
				{	
					var t:Int =  peoteView.getElement( { element:nr } ).tile;
					if (
						 ( (nr--) % 7 == 0 && t == 72) ||
						 ( (nr--) % 7 == 0 && t == 65) ||
						 ( (nr--) % 7 == 0 && t == 88) ||
						 ( (nr--) % 7 == 0 && t == 69) ||
						 ( (nr--) % 7 == 0 && t == 85) ||
						 ( (nr--) % 7 == 0 && t == 73) ||
						 ( (nr--) % 7 == 0 && t == 3)
					   )
					continue;
				}
				peoteView.setElement( { element: y * w + x,
					x:x*s,
					y:y*s - s,
					w:s,
					h:s,
					tile:random(256),
					rgba: random(34) << 24 | random(55) << 16 | random(256) << 8 | 128+random(128)
				});		
			}
		}
		firstrun = false;
		timer = new Timer(1);
		timer.run = randomizeLetters;
	}

}