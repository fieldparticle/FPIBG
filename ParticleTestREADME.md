# Fast parallel index-based GPU-driven particle collision detection
## Running performance tests

Running `particleR.exe` is performed in the same manner as the deug version. The difference is 
that verification number will not be written as they are not available. Writing verifcation number slows the 
process considerably and does not represent the real perfomance of the application.

Once particleD.exe runs without errors, build and run `FPIBG\vulkan\run\particleOnly/particleR.exe`. 
It will read the files generated by `FPIBG\vulkan\run\GenBenchData\GenDataSets.exe` 

Each perfomance test is run which will result in the generation `*R.csv` files instead of `*D.csv`.



If there are errors the error will be reported in the log file

`FPIBG\vulkan\run\ParticleOnly\particle.log`
