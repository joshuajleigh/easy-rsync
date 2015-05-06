# easy-rsync
This is intended for use to make one time backups in a way that is difficult to break.

The script will
* Query user for directory
* Verify directory is real
  * Have user confirm a second time to prevent error	
  * change / translate the paths to prevent relative path and destination path error

* Transfer keeping permission and symlinks when possible
* Give verbose output
  * Will show percentages on larger files

* compares size of source and destination directories
  * Give a friendly recap at the end confirming success or failure
