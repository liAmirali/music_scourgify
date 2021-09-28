import eyed3
from pathlib import Path
import subprocess

ABS_PATH_TO_ROOT = "/home/amirali/lab/music_scourgify/"
ORGANIZED_PATH = ABS_PATH_TO_ROOT + "music/"

songs_path_list = Path(ABS_PATH_TO_ROOT + "toOrganize/").glob("**/*.mp3")
for path in songs_path_list:
    path_str = str(path)

    song = eyed3.load(path_str)
    artist = song.tag.artist
    album = song.tag.album

    # Creating artist directory
    if artist == None:
    	subprocess.run(["mkdir", ORGANIZED_PATH + "unknown_artists"])
    else:
    	subprocess.run(["mkdir", ORGANIZED_PATH + artist])

		# Creating album sub-directory inside its artist directory
    	if song.tag.album == None:
    		subprocess.run(["mkdir", ORGANIZED_PATH + artist + "/unknown_album"])	
    	else:
    		subprocess.run(["mkdir", ORGANIZED_PATH + artist + "/" + album])


subprocess.run(["tree", ORGANIZED_PATH])
print("Done!")