#!/bin/bash
echo "Starting!"

function usage() {
    echo "-a path_to_read_from"
    echo "-b path_to_write_in"
    #will add later #echo "-R for recursive" 
    #will add later #echo "-A [true|false] to enable/disable album sub-directory making
}

function create_directory() {
    
}


PATH_TO_READ="unorganized"
PATH_TO_WRITE="organized"
song_new_path="${PATH_TO_WRITE}"

while getopts "a:b:R" option; do
    case $option in
        a)
            PATH_TO_READ="${OPTARG}"
            ;;
        b)
            PATH_TO_WRITE="${OPTARG}"
            ;;            
        \?)
            usage
            ;;
    esac   
done

for song in $PATH_TO_READ/*.mp3; do
    echo $song
    song_artist=$(eyeD3 "${song}" | grep "^artist: ")
    temp="artist: "
    temp=${#temp}
    song_artist="${song_artist:$temp:${#song_artist}}"

    if [[ -z ${song_artist} ]]; then
        echo "${song} artist not found"
        song_artist="unknown_artist"
    fi

    song_new_path="${PATH_TO_WRITE}/${song_artist}"
    if [[ -d ${song_new_path} ]]; then
        echo "Directory ${song_new_path} exists"
    else
        echo "Creating ${song_new_path} directory"
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

    song_new_path="${PATH_TO_WRITE}/${song_artist}/${song_album}"
    if [[ -d "${song_new_path}" ]]; then
        echo "Directory ${song_new_path} exists"
    else
        echo "Creating ${song_new_path} directory"
        mkdir "${song_new_path}"
    fi

    cp "${song}" "${song_new_path}"
    echo "${song} copied."

    echo "-------"
done

tree $PATH_TO_WRITE
echo "Finished!"