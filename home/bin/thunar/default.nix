{ config, lib, pkgs, ... }:

{
  # set my config options
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.1" encoding="UTF-8"?>

    <channel name="thunar" version="1.0">
      <property name="last-view" type="string" value="ThunarCompactView"/>
      <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_100_PERCENT"/>
      <property name="last-window-maximized" type="bool" value="true"/>
      <property name="last-compact-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_75_PERCENT"/>
      <property name="last-side-pane" type="string" value="THUNAR_SIDEPANE_TYPE_TREE"/>
      <property name="last-separator-position" type="int" value="240"/>
      <property name="last-show-hidden" type="bool" value="false"/>
      <property name="misc-single-click" type="bool" value="false"/>
      <property name="misc-date-style" type="string" value="THUNAR_DATE_STYLE_LONG"/>
      <property name="misc-middle-click-in-tab" type="bool" value="true"/>
      <property name="misc-full-path-in-tab-title" type="bool" value="true"/>
    </channel>
  '';

  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <unique-id>1234567890123456-1</unique-id>
        <command>alacritty --working-directory %f</command>
        <description>Open Alacritty in current directory</description>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
    </actions>
  '';
}
