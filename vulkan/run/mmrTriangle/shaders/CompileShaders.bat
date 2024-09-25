echo off

cd J:\sandboxR7\svnvulcan\run\mmrrTriangle\shaders

	
set src=mmrrTriangle.vert
set dst=vert.spv
echo Compiling vert shader %src% to %dst%
	j:/Vulkan3rdpty/VulkanSDK/Bin/glslc.exe  %src% -o  %dst% >> vert.log
	IF %ERRORLEVEL% NEQ 0 ( 
	  echo vert shader compile failed
	  goto errexit
	)
	
set src=mmrrTriangle.frag
set dst=frag.spv
echo Compiling frag shader %src% to %dst%
	j:/Vulkan3rdpty/VulkanSDK/Bin/glslc.exe %src% -o  %dst% >> frg.log
	IF %ERRORLEVEL% NEQ 0 ( 
	  echo frag shader compile failed
	  goto errexit
	)

exit /B 0
	
:errexit
	pause
	exit /B 1
:sucexit
	pause
	exit /B 0
	
	

