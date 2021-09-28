import eyed3
from pathlib import Path
import subprocess

ABS_PATH_TO_ROOT = "/home/amirali/lab/music_scourgify/"
ORGANIZED_PATH = ABS_PATH_TO_ROOT + "music/"

songs_path_list = Path(ABS_PATH_TO_ROOT + "toOrganize/").glob("**/*.mp3")
for path in songs_path_list:
    song_path = str(path)

    song = eyed3.load(song_path)
    artist = song.tag.artist
    album = song.tag.album

    artist_path = ""
    album_path = ""

    # Creating artist directory
    if artist == None:
        artist_path = ORGANIZED_PATH + "unknown_artists"
    else:
        artist_path = ORGANIZED_PATH + artist

        # Creating album sub-directory inside its artist directory
        if song.tag.album == None:
            album_path = ORGANIZED_PATH + "unknown_artists"
        else:
            album_path = artist_path + "/" + album


    subprocess.run(["mkdir", artist_path])
    subprocess.run(["mkdir", album_path])
    subprocess.run(["cp", song_path, album_path])

subprocess.run(["tree", ORGANIZED_PATH])
print("Done!")