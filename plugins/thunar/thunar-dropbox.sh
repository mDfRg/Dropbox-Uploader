#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

dropup=$DIR"/../../dropbox_uploader.sh" #Path to your Dropbox-Uploader installation

chosen=$1
file_from_Dropbox=`echo $chosen | grep Dropbox/ |wc -l`
path_dropbox=${chosen#*Dropbox/}

if [[ $file_from_Dropbox == 0 ]] ; then
    notify-send "Copying ${chosen##*/} to Dropbox/Public..."
    cp -r "$chosen" "$HOME/Dropbox/Public/"
    path_dropbox=Public/${chosen##*/}
    sleep 3s
fi

share_link_text=$($dropup share "$path_dropbox")
cut_share_link=${share_link_text#*: }


echo $cut_share_link | xclip -selection "clipboard"

if [[ $cut_share_link == "FAILED" ]]; then
	notify-send "FAILED to create shotrlink for ${chosen##*/}!"
else
	notify-send "Link for ${chosen##*/} ($cut_share_link) is ready to paste!"
fi
