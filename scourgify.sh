#!/bin/bash

function usage() {
    echo "-a path_to_read_from"
    echo "Optinal: -b path_to_write_in"
    #will add later #echo "-A [true|false] to enable/disable album sub-directory making
}

PATH_TO_READ=""
PATH_TO_WRITE="scourgified"
song_new_path="${PATH_TO_WRITE}"

while getopts "a:b:" option; do
    case $option in
        a)
            PATH_TO_READ="${OPTARG}"
            if [[ -z $PATH_TO_READ ]]; then
                usage
                exit
            fi
            ;;
        b)
            PATH_TO_WRITE="${OPTARG}"
            ;;
        \?)
            usage
            exit
            ;;
    esac
done

if [[ -z $PATH_TO_READ ]]; then
    usage
    exit
fi

OIFS="$IFS"
IFS=$'\n'

if [[ ! -d $PATH_TO_WRITE ]]; then
    mkdir "${PATH_TO_WRITE}"
fi

for song in $(find -P $PATH_TO_READ -type f -name '*.mp3'); do
    echo "Starting!"
    echo $song
    song_artist=$(eyeD3 "${song}" | grep "^artist: ")
    temp="artist: "
    temp=${#temp}
    song_artist="${song_artist:$temp:${#song_artist}}"

    if [[ -z ${song_artist} ]]; then
        echo "${song} artist not found"
        song_artist="unknown_artist"
    fi

    song_artist=$(LC_ALL=C sed 's/[\d128-\d255]//g' <<< $song_artist)
    song_artist=${song_artist//["/#;"]/"_"}
    song_new_path="${PATH_TO_WRITE}/${song_artist}"
    if [[ -d ${song_new_path} ]]; then
        echo "Directory ${song_new_path} exists"
    else
        echo "Creating ${song_new_path}"
        mkdir "${song_new_path}"
    fi

    song_album=$(eyeD3 "${song}" | grep "^album: ")
    temp="album: "
    temp=${#temp}
    song_album="${song_album:$temp:${#song_album}}"
    if [[ -z "${song_album}" ]]; then
        echo "${song} album not found"
        song_album="unkown_album"
    fi

    song_album=$(LC_ALL=C sed 's/[\d128-\d255]//g' <<< $song_album)
    song_album=${song_album//["/#;"]/"_"}
    song_new_path="${PATH_TO_WRITE}/${song_artist}/${song_album}"
    if [[ -d "${song_new_path}" ]]; then
        echo "Directory ${song_new_path} exists"
    else
        echo "Creating ${song_new_path}"
        mkdir "${song_new_path}"
    fi

    cp "${song}" "${song_new_path}"
    echo "${song} copied."

    echo "-------"
done

IFS="$OIFS"

tree $PATH_TO_WRITE
echo "Finished!"