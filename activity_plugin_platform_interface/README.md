# activity_plugin_platform_interface

A common platform interface for the activity_plugin.

# Usage

To implement a new platform-specific implementation of activity_plugin,
extend ActivityPlatform with an implementation that performs the platform-specific behavior,
and when you register your plugin,
set the default ActivityPlatform by calling ActivityPlatform.instance = MyActivity().
