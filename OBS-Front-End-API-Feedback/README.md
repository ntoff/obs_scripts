## Requirements:

* Requires python v3.6 (according to obs's docs https://obsproject.com/docs/scripting.html ONLY version 3.6 is supported)
* Requires python's "playsound" module (pip install playsound)

## Install:

Copy the obs-studio directory to wherever you installed obs studio. 
If you installed obs to a custom directory that isn't called obs-studio, 
just copy the "data" directory to your obs studio install directory.

In obs, tools -> scripts -> "+" button, and add front_end_feedback.py (there are no settings to configure)

## What it does?:

Python script to act on front end api events, playing a sound. This example only acts on
the replay buffer start / stop / save events. Similar to the "srbeep" plugin, but because
it's a python script, anyone can edit it and add / remove api events as they so desire
without having to know how to compile C code. 

## Word of warning: 
Python hates you, and your family, and will break if you mess up the tabulation.
Make sure you use a proper text editor like sublime, notepad++, vscode, etc. Something that knows
what tabs are, and how to not break them.