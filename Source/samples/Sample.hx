package samples;

import haxe.Timer;
import lime.graphics.opengl.WebGLContext;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;

import lime.app.Application;
import lime.app.Config;
import lime.graphics.GLRenderContext;
import lime.graphics.RenderContext;
import lime.ui.Touch;
import lime.ui.Window;
import lime.graphics.Renderer;

import peote.view.PeoteView;
import peote.view.displaylist.DisplaylistType;

// parent class for all samples
class Sample extends Application {
	
    public var width: Int;
    public var height: Int;
    public var mouse_x: Int = 0;
    public var mouse_y: Int = 0;
    public var xOffset: Int = 0;
    public var yOffset: Int = 0;
    public var zoom: Int = 1;
	
	private var peoteView:PeoteView;
	private var startTime:Float;
	
	public function new() { super (); }
	//public override function create(config:Config):Void [ super.create (config) };

	public override function onWindowCreate(window:Window):Void
	{
		switch (window.renderer.context) {
			case OPENGL (gl):
				var gl:WebGLContext = gl;
				width = window.width;
				height = window.height;
				trace ("gl.version:"+gl.version);
				trace ("gl.type:" + gl.type);
				
				init(); // init PeoteView
				
			default:
				trace("only opengl supported");
		}
	}
	
	public override function onPreloadProgress(loaded:Int, total:Int):Void
	{		
		trace(" --------- onPreloadProgress ----------- ");		
	}
	
	public override function onPreloadComplete():Void
	{	
		trace(" --------- onPreloadComplete ----------- ");
		run(); // start Example Code (override by child example classes)				
	}
	
	public function init():Void {} //overridden by Samples
	public function run():Void {} //overridden by Samples

	/*
	public override function update (deltaTime:Int):Void {
		trace(deltaTime);		
	}
	*/
	
	// ------------------------------------------------------------
	// ------------------------------------------------------------
	
	// ----------- Render Loop ------------------------------------
	public override function render(renderer:Renderer):Void
	{	
		//switch (renderer.context) { case OPENGL (gl): }
		if (peoteView != null) peoteView.render(width, height, zoom, xOffset, yOffset);
	}

	
	// ------------------------------------------------------------
	// ----------- EVENT HANDLER ----------------------------------
	public override function onWindowResize (window:Window, width:Int, height:Int):Void
	{
		//trace("onWindowResize:"+ window.width+','+ window.height);
		/*
		// hack for minimum width on cpp native
		var w = Math.floor(Math.max(200, width));
		var h = Math.floor(Math.max(200, height));
		
		if (w != width || h != height) window.resize(w, h);
		*/

		this.width = window.width;
		this.height = window.height;
	}
	
	public override function onMouseMove (window:Window, x:Float, y:Float):Void
	{
		trace("onMouseMove: " + x + "," + y );
		mouse_x = Std.int(x);
		mouse_y = Std.int(y);
		setOffsets();
	}
	
	public override function onTouchStart (touch:Touch):Void
	{
		trace("onTouchStart: " + touch.id );
		//trace("onTouchStart: " + touch.x + "," + touch.y );
	}
	
	public override function onTouchMove (touch:Touch):Void
	{
		trace("onTouchMove: " + touch.id + "," + touch.x + "," + touch.y );
		mouse_x = Std.int(touch.x); //* window.width;
		mouse_y = Std.int(touch.y);
		setOffsets();
	}
	
	public override function onTouchEnd (touch:Touch):Void
	{
		trace("onTouchEnd: " + touch.id );
		//trace("onTouchStart: " + touch.x + "," + touch.y );
	}
	
	public override function onMouseDown (window:Window, x:Float, y:Float, button:Int):Void
	{	
		trace("onMouseDown: x=" + x + " y="+ y);
		/*if ( button == 0) zoom++;
		else if (button == 1 && zoom > 1) zoom--;
		setOffsets();*/
	}
	
	public override function onMouseUp (window:Window, x:Float, y:Float, button:Int):Void
	{	
		trace("onmouseup: "+button+" x=" + x + " y="+ y);
	}
	
	public override function onMouseWheel (window:Window, deltaX:Float, deltaY:Float):Void
	{	
		//trace("onmousewheel: " + deltaX + ',' + deltaY );
		if ( deltaY>0 ) zoom++;
		else if (zoom > 1) zoom--;
		setOffsets();
	}

	public override function onRenderContextLost (renderer:Renderer):Void
	{		
		trace(" --------- ERROR :  LOST RENDERCONTEXT ----------- ");		
	}
	
	public override function onRenderContextRestored (renderer:Renderer, context:RenderContext):Void
	{
		trace(" --------- onRenderContextRestored ----------- ");		
	}
	
	public override function onKeyDown (window:Window, keyCode:KeyCode, modifier:KeyModifier):Void
	{
		switch (keyCode) {
			case KeyCode.F:
				#if html5
				var e:Dynamic = untyped __js__("document.getElementById('content').getElementsByTagName('canvas')[0]");
				var noFullscreen:Dynamic = untyped __js__("(!document.fullscreenElement && !document.mozFullScreenElement && !document.webkitFullscreenElement && !document.msFullscreenElement)");
				
				if ( noFullscreen)
				{	// enter fullscreen
					if (e.requestFullScreen) e.requestFullScreen();
					else if (e.msRequestFullScreen) e.msRequestFullScreen();
					else if (e.mozRequestFullScreen) e.mozRequestFullScreen();
					else if (e.webkitRequestFullScreen) e.webkitRequestFullScreen();
				}
				else
				{	// leave fullscreen
					var d:Dynamic = untyped __js__("document");
					if (d.exitFullscreen) d.exitFullscreen();
					else if (d.msExitFullscreen) d.msExitFullscreen();
					else if (d.mozCancelFullScreen) d.mozCancelFullScreen();
					else if (d.webkitExitFullscreen) d.webkitExitFullscreen();					
				}
				#else
				window.fullscreen = !window.fullscreen;
				#end				
			default:
		}
	}
	
	// end Event Handler ------------------------------
	// ------------------------------------------------------------
	
	public function setOffsets():Void {
		xOffset = -mouse_x;
		yOffset = -mouse_y;
	}

	// -- Math-Stuff
	private inline function random(n:Int):Int
	{
		return Math.floor(Math.random() * n);
	}
	
	
}
