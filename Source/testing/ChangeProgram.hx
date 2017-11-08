package testing;

import peote.view.PeoteView;
import peote.view.displaylist.DisplaylistType;
import haxe.Timer;
import samples.Sample;

import lime.ui.Window;

class ChangeProgram extends Sample
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
	
	public override function run()
	{	
		// set shaders
		peoteView.setProgram({
			program:0,
			fshader:'assets/lyapunov_01.frag'
			//, vars: [	"uPosition" => position	]
		});
		
		peoteView.setDisplaylist( { 
			displaylist:0,
			type:DisplaylistType.SIMPLE,
			maxElements:1,
			x:0,
			y:0,
		});
		
		peoteView.setElement( { 
			element:0,
			displaylist:0,
			program:0,
			x: 0,
			y: 0,
			w: 2000,
			h: 2000,
			tw:10000, th:10000
		});
		
		
		var timer = new Timer(2000);
		timer.run = function() {
			timer.stop();
			
			peoteView.setProgram({
				program:0,
				fshader:'assets/lyapunov_02.frag'
				//, vars: [	"uPosition" => position	]
			});

		}

		
	}
	
}
