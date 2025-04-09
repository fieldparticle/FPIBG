function ret = svplt(name)
if exist ('OCTAVE_VERSION', 'builtin') == 0

set(gcf,'PaperOrientation','portrait');        
    print(name,'-djpeg' );   
else
set(gcf,'PaperOrientation','portrait');        
    print(name,'-djpeg');   
end