

class ParticleEnable (Triggerable):
	
	initalState as bool = true
	
	def Start():
		initalState = particleSystem.isPlaying

	def Trigger():
		if particleSystem.isPlaying:
			particleSystem.Stop()
		else:
			particleSystem.Play()
			
	def Reset():
		if initalState:
			particleSystem.Play()
		else:
			particleSystem.Stop()
		
	
		
