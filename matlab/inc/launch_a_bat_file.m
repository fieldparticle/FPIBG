function launch_a_bat_file(dirnam,flnam)
%//LAUNCH_A_BAT_FYLE Run a bat file with asynchronous process control
%old_dir = pwd;
%cd(dirnam);
batFile = sprintf("%s/%s",dirnam,flnam);
startInfo = System.Diagnostics.ProcessStartInfo('cmd.exe', sprintf('/c "%s"', batFile));
%startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;  %// if you want it invisible
proc = System.Diagnostics.Process.Start(startInfo);
if isempty(proc)
    error('Failed to launch process');
end
while true
    if proc.HasExited
        fprintf('\nProcess exited with status %d\n', proc.ExitCode);
        break
    end
    fprintf('.');
    pause(.1);
end

%cd(old_dir);