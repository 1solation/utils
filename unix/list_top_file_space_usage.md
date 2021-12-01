# List top 5 directories eating up disk space in your current working directory, human-readable format

    du -hs * | sort -rh | head -5

### Explained

1.  `du`  command: Estimate file space usage.
2.  `-h`  : Print sizes in human-readable format (e.g. 1.5G).
3.  `-s`  : Display only a total for each argument.
4.  `sort`  command : sort lines of text files.
5.  `-r`  : Reverse the result of comparisons.
6.  `-h`  : Compare human readable numbers (e.g. 1G).
7.  `head`  : Output the first n number of files.

