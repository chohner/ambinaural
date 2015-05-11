# ambinaural
Mapping a 4 channel b-format (WXYZ) recording to 2-channel binaural. Ideal for mobile - fast, stable, low memory footprint.

## Current implementations
The general b-format decoding is described as:

![B Format Equation][b_format_equation]

Where ![phi][phi] is the *azimuth* and ![theta][theta] the *lateral* head position. Faktor ![omega][omega] changes the beamforming characteristic, from full spherical ( ![omega][omega] = 0) to full cardioid ( ![omega][omega] = 1)


[b_format_equation]: http://www.sciweavers.org/tex2img.php?eq=S(%20%5Cvarphi%20,%20%20%5Ctheta,%20%20%5Comega%20%20)%20%3D%20(%20%5Comega%20%20-%201)%20%20%5Ccdot%20W%20%20%20%20%2B%20%5Comega%20[%20X%20%5Ccdot%20%20cos(%20%5Cvarphi%20)%20cos%20(%20%5Ctheta%20)%20%2B%20%20Y%20%5Ccdot%20%20sin(%20%5Cvarphi%20)%20cos%20(%20%5Ctheta%20)%20%2B%20Z%20%5Ccdot%20sin%20(%20%5Ctheta%20)%20]&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0 "B Format Equation"


[phi]: http://www.sciweavers.org/tex2img.php?eq=\varphi&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0 "phi"

[theta]: http://www.sciweavers.org/tex2img.php?eq=\theta&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0 "theta"

[omega]: http://www.sciweavers.org/tex2img.php?eq=\omega&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0 "omega"

### Matlab
First static proof of concept. Used to extract the necessary HRIRs from the KEMAR HRTF Database.

### Ableton Live
Simple project to blend between simple b-format beamforming and the proposed method. You first need to generate output using matlab. Uses Live version 9.

### Max MSP
First dynamic proof of concept. Loads input and HRIRs and convolves in real time. To run you must first download and install the [*HISSTools*](http://eprints.hud.ac.uk/14897/).

## Thanks
- [**KEMAR HRIR database**](http://interface.cipic.ucdavis.edu/) by the *CIPIC- Center for Image Processing and Integrated Computing*
- **multiconvolve~** max-msp object from the [**HISSTools**](http://eprints.hud.ac.uk/14897/) collection by *Alexander  Harker and Pierre Alexandre Tremblay*

## Authors
[Christoph Hohnerlein](http://chrisclock.com), Maximilian Ilse

## Copyright and License
Apache License 2.0, April 2015