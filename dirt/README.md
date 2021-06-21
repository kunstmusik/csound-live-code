# Dirt Sample Player

1. Set SSDIR environment variable to point to where you have have your samples. (See https://csound.com/docs/manual/CommandEnvironment.html for more information.) For example, mine is set in ~/work/csound/samples and I have an entry in my .zshrc file on macOS that has ```export SSDIR=/Users/stevenyi/work/audio/samples/```.
2. Clone the [Dirt Sample Set](https://github.com/tidalcycles/Dirt-Samples) into the SSDIR directory.
3. Copy the gen_dirt_samples_txt.sh file into the root of the Dirt-Samples folder and execute it using ```sh gen_dirt_samples_txt```. This will look through the directory structure and generate a dirt_samples.txt file. Copy this file into this folder (i.e., csound-live-code/dirt). 
4. Run ```csound livecode-dirt.csd``` in the root folder to start the csound-live-code system including the dirt sample player system. This will first load the dirt samples into memory and then enable using the opcodes defined in dirt.orc.



