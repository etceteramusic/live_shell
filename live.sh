#!/bin/bash
SETUPDIR=`pwd $0`

CFGFILE=$SETUPDIR/live.cfg
if [ -z "$CFGFILE" ]
then 
  echo "Missing live.cfg file. Exiting!"
  exit;
fi

# Disable power management
xset -dpms

cat $CFGFILE | 
grep -i -v "#" |
grep "^[a-z]" | 
gawk 'BEGIN {
  cmd="pwd";
  cmd | getline pwd
  close(cmd);
  print "== Setup directory: " pwd;
  cmd="uname -a";
  cmd | getline arch
  close(cmd);
  arch=substr(arch,match(arch,"x86"));
  arch=substr(arch,0,match(arch," ")-1);
  print "== Architecture: \"" arch "\""

  switch (arch) {
  case "x86_64":
                 mlversion="./MidiLayer-0.4.3-x86_64";
                 break;
  default:
                 mlversion="./MidiLayer-0.4.3-x86_32"
                 break;
  }

  startorder[0]="jackd";
  startorder[1]="a2jmidid";
  startorder[2]="non-mixer";
  startorder[3]="midilayer";
  startorder[4]="startBristol";
  startorder[5]="qtractor";
  startorder[6]="jack-keyboard";
  startorder[7]="carla";
}

function start_program(cmd, sleep)
{
  system(cmd);  
  close(cmd);
  cmd="sleep " sleep
  system(cmd);  
  close(cmd);
}

function start_jackd(cmd, sleep)
{
  start_program(cmd, sleep);
  cmd="ps -ef | grep \"/usr/bin/jackd\" | grep -v \"grep\"";  
  cmd | getline ps ;
  close(cmd);
  if(ps=="")
  {
    print "jackd failed to start. Exiting!"
    exit 1;
  }
}

{
  switch ($1) {
  case "jackd":     
  case "non-mixer":     
  case "qtractor":     
  case "jack-keyboard":     
  case "a2jmidid":     
  case "carla":     
  case "startBristol":
                exe=$1; 
                break;
  case "midilayer":
                exe=mlversion "/MidiLayer-0.4.3";
                break;
  default:
                print $1 " is not supported. Exiting!"; 
                exiting=1; exit 1;
  }

  cmd="which " exe; 
  cmd | getline exepath;
  close(cmd);
  if(!match(exepath,exe))
  {
    print exe " not found. Exiting!"
    exiting=1; exit 1;
  }
  else
  {
    programtype[NR]=$1
    arguments[NR]=exepath " " substr($0,match($0 " "," "));
  }
}

END{
  if(exiting)
    exit 1;
  # Loop startorder
  for(ix=0;ix<8;ix++)
  {
    # Loop instances
    for(jx=1;jx<=NR;jx++)
    {
      if(programtype[jx]==startorder[ix])
      {
        cmd=arguments[jx] " &";
        switch (programtype[jx]) { 
        case "jackd":     
                start_jackd(cmd, 5);
                break;
        case "non-mixer":     
                start_program(cmd,1);
                break;
        case "qtractor":     
                start_program(cmd,1);
                break;
        case "jack-keyboard":     
                start_program(cmd,1);
                break;
        case "a2jmidid":     
                start_program(cmd,5);
                break;
        case "carla":     
                start_program(cmd,0);
                break;
        case "startBristol":
                start_program(cmd,1);
                break;
        case "midilayer":
                start_program(cmd,1);
                break;
        default:
                print $1 " is not supported. Exiting!"; 
                exiting=1; exit 1;
        }
      }
    }
  }
}'
