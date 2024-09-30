rmdir /S /Q vulkan\make\build_all\.vs
rmdir /S /Q vulkan\make\build_all\x64 
rmdir /S /Q vulkan\make\GenBenchData\x64 
rmdir /S /Q vulkan\make\GenBenchData\.vs 
del /S /Q vulkan\run\GenBenchData\*.pdb
del /S /Q vulkan\run\GenBenchData\*.exe


del /S /Q vulkan\run\mmrrTriangle\*.spv
del /S /Q vulkan\run\mmrrTriangle\*.exp
del /S /Q vulkan\run\mmrrTriangle\*.lib
del /S /Q vulkan\run\mmrrTriangle\*.log
del /S /Q vulkan\run\mmrrTriangle\*.pdb
del /S /Q vulkan\run\mmrrTriangle\*.exe
rmdir /S /Q vulkan\make\mmrrTriangle\x64
rmdir /S /Q vulkan\make\mmrrTriangle\.vs

del /S /Q vulkan\run\mmrrTriangle\shaders\*.spv
del /S /Q vulkan\run\mmrrTriangle\shaders\*.log

del /S /Q vulkan\run\ParticleOnly\*.pdb
del /S /Q vulkan\run\ParticleOnly\*.exe
del /S /Q vulkan\run\ParticleOnly\*.spv
del /S /Q vulkan\run\ParticleOnly\*.exp
del /S /Q vulkan\run\ParticleOnly\*.lib
del /S /Q vulkan\run\ParticleOnly\*.log
rmdir /S /Q vulkan\make\ParticleOnly\x64
rmdir /S /Q vulkan\make\ParticleOnly\.vs

del /S /Q vulkan\run\PerfReport\*.pdb
del /S /Q vulkan\run\PerfReport\*.exe
del /S /Q vulkan\run\PerfReport\*.spv
del /S /Q vulkan\run\PerfReport\*.exp
del /S /Q vulkan\run\PerfReport\*.lib
del /S /Q vulkan\run\PerfReport\*.log
rmdir /S /Q vulkan\make\PerfReport\x64
rmdir /S /Q vulkan\make\PerfReport\.vs
rmdir /S /Q vulkan\make\PerfReport\PerfReport


pause