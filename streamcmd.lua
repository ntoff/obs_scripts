obs         = obslua
start_script_name = ""
end_script_name = ""

function on_event(event)
	if event == obs.OBS_FRONTEND_EVENT_STREAMING_STARTED then
		if start_script_name ~= "start_script" then
			obs.script_log(obs.LOG_INFO, "executing " .. start_script_name)
			os.execute(start_script_name)
		end
	end
	if event == obs.OBS_FRONTEND_EVENT_STREAMING_STOPPED then
		if end_script_name ~= "end_script" then
			obs.script_log(obs.LOG_INFO, "executing " .. end_script_name)
			os.execute(end_script_name)
		end
	end
end
-----------------------------------------------------------------------------------------------------

function script_update(settings)
	start_script_name = obs.obs_data_get_string(settings, "start_script_name")
	end_script_name = obs.obs_data_get_string(settings, "end_script_name")
end

function script_description()
	return "run a script / executable when the stream starts or ends"
end

function script_properties()
	props = obs.obs_properties_create()

	obs.obs_properties_add_path(props, "start_script_name", "Start Stream", obs.OBS_PATH_FILE, "(*.exe *.bat *.sh);;(*.*)", NULL)
	obs.obs_properties_add_path(props, "end_script_name", "End Stream", obs.OBS_PATH_FILE, "(*.exe *.bat *.sh);;(*.*)", NULL)
		
	return props
end

function script_defaults(settings)
	obs.obs_data_set_default_string(settings, "start_script_name", "start_script")
	obs.obs_data_set_default_string(settings, "end_script_name", "end_script")
end

function script_load(settings)
	obs.obs_frontend_add_event_callback(on_event)
end