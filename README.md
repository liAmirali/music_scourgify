# Introduction
You're a boomer and you still store your songs locally? (Or you're not a boomer but for whatever reason you do that?)   
And the songs directory is messy and you suffer from OCD?   
Pfff I got u.   
# Functionality  
This program looks into a directory and first creates sub-directories for each artist.   
And then in each artist directory, it creates sub-directories for albums.  
And at the end it puts the songs in the corresponding directory.   
That's how you get your OCD satisfied. :)
# Installation
Install the dependencies:  
```bash
$ sudo apt install eyeD3
```
# Usage
Make sure that the scourgify.sh file has execute permission.  
The `-a` option is used to specify a path that you want to *scourgify*. (By default it searches recursively and finds any file that ends with `.mp3`)  
The `-b` option is used to specify a path that you want to write the scourgified songs into.
For example:
```bash
$ ./scourgify.sh -a dummy_path/messy_directory/ -b smort_path/cool_scourgified_directory/
```
The `-b` flag is optional, and by default it will create a directory named `scourgified` right next to the scourgify.sh file and writes into that.
