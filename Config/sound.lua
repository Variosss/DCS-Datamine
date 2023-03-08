sound = {}

-- set up cockpit types
-- TODO: to move this setting to modules descriptions
sound['cockpit_world'] = {
  ['a-10a'] 	= { gain = 0.12, lowpass = 1000 },
  ['A-10C'] 	= { gain = 0.12, lowpass = 1000 },
  ['AH-64D_apache'] = { gain = 0.3,  lowpass = 3000 },
  ['Bf-109K-4'] = { gain = 0.15, lowpass = 3000 },
  ['F-15C'] 	= { gain = 0.15, lowpass = 800 },
  ['F-5E-3'] 	= { gain = 0.15, lowpass = 800 },
  ['F-86F'] 	= { gain = 0.15, lowpass = 1500 },
  ['FA-18C_hornet'] 	= { gain = 0.15, lowpass = 800 },
  ['F-16C_50'] 	= { gain = 0.15, lowpass = 1000 },
  ['FW-190D9'] 	= { gain = 0.15, lowpass = 3000 },
  ['ka-50'] 	= { gain = 0.3,  lowpass = 3000 },
  ['L-39C'] 	= { gain = 0.15, lowpass = 1500 },
  ['L-39ZA'] 	= { gain = 0.15, lowpass = 1500 },
  ['mi-8mt'] 	= { gain = 0.3,  lowpass = 3000 },
  ['Mi-24P'] 	= { gain = 0.3,  lowpass = 3000 },
  ['MiG-15bis'] = { gain = 0.15, lowpass = 1500 }, 
  ['mig-29'] 	= { gain = 0.15, lowpass = 800 },
  ['mig-29c'] 	= { gain = 0.15, lowpass = 800 },
  ['MosquitoFBMkVI'] = { gain = 0.25, lowpass = 4000 },
  ['P-47D-30'] 	= { gain = 0.15, lowpass = 3000 },
  ['P-51D'] 	= { gain = 0.15, lowpass = 3000 },
  ['SpitfireLFMkIX'] = { gain = 0.15, lowpass = 3000 },
  ['su-25'] 	= { gain = 0.15, lowpass = 800 },
  ['su-25T'] 	= { gain = 0.15, lowpass = 800 },
  ['su-27'] 	= { gain = 0.15, lowpass = 800 },
  ['su-33'] 	= { gain = 0.15, lowpass = 800 },
  ['TF-51D'] 	= { gain = 0.15, lowpass = 3000 },
  ['UH-1H'] 	= { gain = 0.3,  lowpass = 3000 },
  ['Yak-52'] 	= { gain = 0.15, lowpass = 3000 },
}


ambientSound =
{
	surfaceSamples = 12, --must be a multiple of 3
	sampleRadius = 30, -- meters
	resampleDistance = 10, -- meters
	resampleTime = 0.5, -- seconds
	fadeOutHeight = 100, -- meters
}

sound.limiter = 
{
	release = 0.8,
}

sound.doppler_warp = 1
sound.world_fadein_time = 4

--set up spatial crosstalk {threshold, exponent}
sound.cockpit_spatial_crosstalk = {1.3, 2.0}
sound.world_spatial_crosstalk = {3.6, 1.6}