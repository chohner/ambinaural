# ambinaural
Mapping a 4 channel b-format (WXYZ) recording to 2-channel binaural.

## Current implementations

### Matlab
First static proof of concept. Used to extract the necessary HRIRs from the KEMAR HRTF Database.

### Ableton Live
Simple project to blend between simple b-format beamforming and the proposed method. You first need to generate output using matlab. Uses Live version 9.

### Max MSP
First dynamic proof of concept. Loads input and HRIRs and convolves in real time. To run you must first download and install the [*HISSTools*](http://eprints.hud.ac.uk/14897/).

## Thanks
- [**KEMAR HRIR database**](http://interface.cipic.ucdavis.edu/) by the *CIPIC- Center for Image Processing and Integrated Computing* [More information](http://interface.cipic.ucdavis.edu/)
- **multiconvolve~** max-msp object from the [**HISSTools**](http://eprints.hud.ac.uk/14897/) collection by *Alexander  Harker and Pierre Alexandre Tremblay*

## Authors
[Christoph Hohnerlein](http://chrisclock.com), Maximilian Ilse

## Copyright and License
Apache License 2.0, April 2015