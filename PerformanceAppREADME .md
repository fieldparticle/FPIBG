# FPIBG
# Fast parallel index-based GPU-driven particle collision detection
## Particle Collison Detection Performance Reports

Once perfApp runs without errors and the relese version has been run perfApp will analyze the
data and wrtie a comma separated value file to one of

`FPIBGDATA\perfdataPQB\PQBReport.csv`

`FPIBGDATA\perfdataPCD\PCDReport.csv`

`FPIBGDATA\perfdataCFB\CFBReport.csv`

perfApp will caluate the following parameters:

`file` directory and file name of the *.tst file

`numparticles` the number of particles processed

`numcollisions` the number of collsions prosesse.

`avgfps` the average frames per second

`avgcpums` the average cpu time per frame in seconds.

`avgcms` the average compute shader time per frame in seconds.

`avggms` the average graphics pipeline time per frame in seconds.

`minfps` the minimum frames per second.

`mincpums` the minimum cpu time per frame in seconds

`mincms` the minimum compute time per frame in seconds

`mingms` the minimum graphics pipline time per frame in seconds

`maxfps` the maximum frames per second.

`maxcpums`the maximum cpu time per frame in seconds

`maxcms` the maximum compute time per frame in seconds

`maxgms` the maximum graphics pipline time per frame in seconds


If there are errors the error will be reported in the log file 

`FPIBG\vulkan\run\PerfReport\PerfReport.log`

