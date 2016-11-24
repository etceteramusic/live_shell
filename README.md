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

What you get is a setup which is easy to start up and easy to zip and move to another machine.

I have no idea it this is useful for you, but it solved a lot of problems for me when I was building a live setup
for a friend who lived far away.

Frank
