rmdir /S /Q vulkan\make\build_all\.vs
rmdir /S /Q vulkan\make\build_all\x64 
rmdir /S /Q vulkan\make\GenBenchData\x64 
rmdir /S /Q vulkan\make\GenBenchData\.vs 
del /S /Q vulkan\run\GenBenchData\*.pdb
del /S /Q vulkan\run\GenBenchData\*.exe
rmdir /S /Q vulkan\make\mmrtriangle\x64
rmdir /S /Q vulkan\make\mmrtriangle\.vs
del /S /Q vulkan\run\mmrtriangle\*.pdb
del /S /Q vulkan\run\mmrtriangle\*.exe
del /S /Q vulkan\run\ParticleOnly\*.pdb
del /S /Q vulkan\run\ParticleOnly\*.exe
rmdir /S /Q vulkan\make\ParticleOnly\ParticleOnly\x64
rmdir /S /Q vulkan\make\ParticleOnly\ParticleOnly
rmdir /S /Q vulkan\make\ParticleOnly\.vs
pause