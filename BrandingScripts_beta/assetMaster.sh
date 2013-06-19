#!/usr/bin/bash
#set -x

if [ $# -lt 1 ]
    then
    echo "Usage : $0 [function] [brand]"
    exit 1
fi
#brand=$2

color_arg=$2
brand_arg=$3

#brand_path=~/mpp/media/${brand}
#ios_path=${brand_path}/ios
#android_path=${brand_path}/android2

# populating IM values from images.config
populate()
{
_input="image.config"
while IFS="=" read -r key value
do
    case $key in
        tab_color)
        tab_color=$value
        echo $tab_color
    ;;
        tab_top_line)
        tab_top_line=$value
        echo $tab_top_line
    ;;
        tab_bottom_line)
        tab_bottom_line=$value
        echo $tab_bottom_line
    ;;
        tab_color_selected_selected)
        tab_color_selected=$value
        echo $tab_color_selected
    ;;
        tab_top_line_selected)
        tab_top_line_selected=$value
        echo $tab_top_line_selected
    ;;
        tab_bottom_line_selected)
        tab_bottom_line_selected=$value
        echo $tab_bottom_line_selected
    ;;
        tab_gradient)
        tab_gradient=$value
        echo $tab_gradient
    ;;
        tab_noise)
        tab_noise=$value
        echo $tab_noise
    ;;
        subtab_color)
        subtab_color=$value
        echo $subtab_color
    ;;
        subtab_bottom_line)
        subtab_bottom_line=$value
        echo $subtab_bottom_line
    ;;
        ui_icon_color)
        ui_icon_color=$value
        echo $ui_icon_color
    ;;
        tab_icon_color)
        tab_icon_color=$value
        echo $tab_icon_color
    ;;
    ###
    #   More to come!
    ###
    esac
done < $_input
}
function recolor { 
    output_color=""
    image_path=
    read -p "Enter desired icon colors: " output_color
    read -p "Enter path to icons (from:$HOME/):" image_path
    image_path=$HOME/${image_path}
    #if [ -z "$path_to_icons" ]; then
        #path_to_icons=${default_path}
        #fi
    mkdir ${image_path}/output_icons
    out_path=${image_path}/output_icons
    for line in `ls ${image_path}`
    do
        convert ${image_path}/${line} +level-colors "'#${output_color}'" ${out_path}/${line}
        
        echo "re-coloring icon " ${image_path}/${line} " to #${output_color}"
    done
}
function icons { 
    output_color=""
    image_path=
    read -p "Enter desired icon colors: " output_color
    read -p "Enter path to icons (from:$HOME/):" image_path
    image_path=$HOME/${image_path}
    #if [ -z "$path_to_icons" ]; then
        #path_to_icons=${default_path}
        #fi
    mkdir ${image_path}/output_icons
    out_path=${image_path}/output_icons
    for folder in `ls ${image_path}`
        do
            mkdir ${image_path}/output_icons/${folder}
        for line in `ls ${image_path}/${folder}`
            do
        convert ${image_path}/${folder}/${line} +level-colors "'#${output_color}'" ${out_path}/${folder}/${line}
        
        echo "re-coloring icon " ${image_path}/${folder}/${line} " to #${output_color}"
            done
        done
}
function create {
    #read -p "Subtab color:" subtab_color
    #read -p "Destination path (from:$HOME):" android_path
    subtab_color=$1
    android_path=${HOME}/mpp/media/$2/android2/res/drawable
    #####
    # Creating android subtabs
    #####
    convert source_assets/unselected_subtab.png -fill "#${subtab_color}" -draw 'fill-opacity 1.0 rectangle 1,4 2,4' -draw 'fill-opacity 0.5 rectangle 1,3 2,3' -draw 'fill-opacity 0.3 rectangle 1,1 2,2' ${android_path}/vpi__tab_unselected_focused_holo.9.png
    convert source_assets/unselected_subtab.png -fill "#${subtab_color}" -draw 'fill-opacity 1.0 rectangle 1,4 2,4' -draw 'fill-opacity 0.3 rectangle 1,3 2,3' -draw 'fill-opacity 0.0 rectangle 1,1 2,2' ${android_path}/vpi__tab_unselected_holo.9.png
    convert source_assets/unselected_subtab.png -fill "#${subtab_color}"  -draw 'fill-opacity 1.0 rectangle 1,4 2,4' -draw 'fill-opacity 0.7 rectangle 1,3 2,3' -draw 'fill-opacity 0.5 rectangle 1,1 2,2' ${android_path}/vpi__tab_unselected_pressed_holo.9.png
    convert source_assets/selected_subtab.png -fill "#${subtab_color}" -draw 'fill-opacity 1.0 rectangle 1,3 2,8' -draw 'fill-opacity 0.3 rectangle 1,1 2,2' ${android_path}/vpi__tab_selected_focused_holo.9.png
    convert source_assets/selected_subtab.png -fill "#${subtab_color}" -draw 'fill-opacity 1.0 rectangle 1,3 2,8'   -draw 'fill-opacity 0.0 rectangle 1,1 2,2' ${android_path}/vpi__tab_selected_holo.9.png
    convert source_assets/selected_subtab.png -fill "#${subtab_color}" -draw 'fill-opacity 1.0 rectangle 1,3 2,8' -draw 'fill-opacity 0.5 rectangle 1,1 2,2' ${android_path}/vpi__tab_selected_pressed_holo.9.png
    #####
    # Creating iOS tabs
    #####
    #convert -size 128x100 xc:${tab_color} -stroke ${top_line} -draw 'line 0,0 120,0' -stroke ${bottom_line} -draw 'line 0,90 120,90' -seed 1000 -attenuate .05 +noise gaussian stroke_attempt.png
    #convert -size 128x100 xc:${tab_color_selected} -stroke ${top_line_selected} -draw 'line 0,0 120,0' -stroke ${bottom_line_selected} -draw 'line 0,90 120,90' -seed 1000 -attenuate .05 +noise gaussian stroke_attempt.png
    
}

$1 $2 $3

#convert source_assets/vpi__tab_unselected_focused_holo.9.png -fill "#663366" -draw 'fill-opacity 0.1 rectangle 1,4 2,4' -draw 'fill-opacity 0.2 rectangle 1,1 2,2' -draw 'fill-opacity 0.5 rectangle 1,3 2,3' source_assets/result/vpi__tab_unselected_focused_holo.9.png

#formulas:

#sidebar:: convert -size 120x90 xc:$sidebar_color -stroke $top_line -draw 'line 0,0 120,0' -stroke $bottom_line -draw 'line 0,90 120,90' -seed 1000 -attenuate .05 +noise gaussian stroke_attempt.png

#gradient header:: convert -size 640x88 xc:$header_color -fill gradient:$start_color-$end_color -draw 'rectangle 0,0 640,88' large_image.png