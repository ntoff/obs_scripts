obs         = obslua
source_name   = ""
privacy_hotkey     = obs.OBS_INVALID_HOTKEY_ID

function script_description()
    return "(temporarily) Enables a source to cover the screen for privacy when a hotkey is pressed and held down."
end

function script_update(settings)
    source_name = obs.obs_data_get_string(settings, "source")
end

function script_properties()
    local props = obs.obs_properties_create()
    local p = obs.obs_properties_add_list(props, "source", "Privacy Source", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
    local sources = obs.obs_enum_sources()
    if sources ~= nil then
        for _, source in ipairs(sources) do
            source_id = obs.obs_source_get_unversioned_id(source)
            local name = obs.obs_source_get_name(source)
            obs.obs_property_list_add_string(p, name, name)
        end
    end
    obs.source_list_release(sources)
    return props
end

function toggleSource(visibility)
    local sceneSource = obs.obs_frontend_get_current_scene()
    local scene = obs.obs_scene_from_source(sceneSource)
    local sceneitems = obs.obs_scene_enum_items(scene)
    
    if sceneitems ~= nil then
        for _, sceneitem in ipairs(sceneitems) do
          local source = obs.obs_sceneitem_get_source(sceneitem)
          local name = obs.obs_source_get_name(source)
          if name == source_name then
            obs.obs_sceneitem_set_visible(sceneitem, visibility)
          end
        end
      end
    
    obs.sceneitem_list_release(sceneitems)
    obs.obs_source_release(sceneSource)
end

function enableShield(pressed)
    if pressed then
        toggleSource(true)
    else
        toggleSource(false)
    end
end

function script_load(settings)
    privacy_hotkey = obs.obs_hotkey_register_frontend(privacy_hotkey, "Privacy Hotkey", enableShield)
    local hotkey_save_array = obs.obs_data_get_array(settings, "privacy_hotkey")
    obs.obs_hotkey_load(privacy_hotkey, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)
end

function script_save(settings)
    local hotkey_save_array = obs.obs_hotkey_save(privacy_hotkey)
    obs.obs_data_set_array(settings, "privacy_hotkey", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)
end

function script_unload(settings)
    obs.obs_hotkey_unregister(hotkey)
end