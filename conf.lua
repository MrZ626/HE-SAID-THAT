function love.conf(t)
	t.accelerometerjoystick=nil--Enable the accelerometer on iOS and Android by exposing it as a Joystick (boolean)
	local W=t.window
	W.title="群友说"
	W.width,W.height=800,250
	W.minwidth,W.minheight=500,250
	W.resizable=true
	W.vsync=nil
	t.modules={window=true,
		system=true,
		event=true,
		font=true,
		graphics=true,
		image=true,
		keyboard=true,
	}
end