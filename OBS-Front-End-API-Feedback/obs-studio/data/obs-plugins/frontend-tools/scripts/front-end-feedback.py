# Requires python 3.6.x and playsound (pip install playsound)
# ffmpeg must be in your path environment variable

import obspython as obs
from playsound import playsound
import threading, os

def script_description():
	return "Plays audio based on front end api events"

def on_event(event):
    if event == obs.OBS_FRONTEND_EVENT_REPLAY_BUFFER_STARTED:
        play_thread = threading.Thread(target=play_audio, args=('../../data\obs-plugins/frontend-tools/scripts/front-end-feedback/replay_start.mp3',))
        play_thread.start()
    if event == obs.OBS_FRONTEND_EVENT_REPLAY_BUFFER_STOPPED:
        play_thread = threading.Thread(target=play_audio, args=('../../data\obs-plugins/frontend-tools/scripts/front-end-feedback/replay_stop.mp3',))
        play_thread.start()
    if event == obs.OBS_FRONTEND_EVENT_REPLAY_BUFFER_SAVED:
        play_thread = threading.Thread(target=play_audio, args=('../../data\obs-plugins/frontend-tools/scripts/front-end-feedback/replay_saved.mp3',))
        play_thread.start()

def play_audio(audio_file):
    playsound(audio_file)
    
def script_load(settings):
	obs.obs_frontend_add_event_callback(on_event)

def script_unload():
    obs.obs_frontend_remove_event_callback(on_event)
