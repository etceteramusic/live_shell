# live.sh
# Bash shell script to start linux audio applications from a local folder.
 
This script was written to make live music a little easier for those that wish to use Linux+KXstudio for 
live music playing.
Currently it supports only startup of jackd, non-mixer, qtractor, jack-keyboard, a2jmidid, carla, bristol and MidiLayer-0.4.3.

The main idea is to have a complete configuration of a Linux live setup in one folder, that may be packaged and moved 
to other machines. 
The script does not configure the applications or their connections. That is left entirely to you. It does however 
operate on the assumption, that all configuration files are placed in the same folder as the script, so that the 
configuration file may start your setup entirely from configurations local to the folder.
 
Configuration files work in different ways for each program, but for all the programs included in the script there is a way
to define configurations locally. 

The live.cfg file defines the programs to start when the script is executed, and the parameters to pass to the 
program to load local configurations.
The script assumes a startup sequence that begins with starting jackd and ends with starting carla.
You may define several instances of each program too. The script will attempt to start them all.

The script was written for a setup that uses
  jackd as audio backend
  a2jmidid which may be necessary for some applications
  carla to manage audio plugins and routing
  MidiLayer-0.4.3 to manage patches
  NON-mixer to manage audio mixing 
plus
  qtractor for MIDI sequencing
  bristol for the odd synthesizer not hosted by carla
  jack-keyboard because a keyboard is handy for testing connections
   
Adding support for more programs should be very easy

There is also a simple mechanism that tries to determine whether one is running 32-bit or 64-bit
and setup environment variables accordingly, so that it is possible to port the setup from a 
32-bit machine to a 64-bit or vice versa. This is only used for setting up MidiLayer-0.4.3, as
it comes with two different executables.

The script terminates if it does not find a program from the configuration. It will also terminate if
it fails to start or find a running jackd instance. So to use the script you will have to have the programs
installed and configured to use settings local to the script folder, and you will have to add the parameters
to the script configuration to enable it to load the local settings.

So what does it do that you couldn't do with a plain shell script? Not much really, except enforcing a program start order, checking the existence of programs, adding suitable wait times between programs, and most important; isolating the program configuation from the actual program start. 

The point of doing so, is to have a template for wrapping portability issues, and making the configuration file more universal. In other words, all compatibility issues between different installations should be resolved in the script rather than in the configuration file. So, over time I expect that the script will get more an more complex, and that it will address more and more details of the configuration. Ideas I have for the script, is for it to be able to modify config files to use realtive paths rathet than global paths, or search for existing local .jackdrc files instead of configured ones, or to handle localization of the RDF/ttl files that configure plugins, so these configurations are contained in the packaged setup. 

What I want eventyally, is a setup which is easier to start up and easier to zip and move to another machine.

I have no idea it this is useful for you in its current state, but it solved a lot of problems for me when I was building a live setup for a friend who lived far away.

Frank
