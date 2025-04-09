function [rccddrv,prefxdir] = addPathCD(wrkdir)

rccddrv = getenv('RCCDDRIVE');
rccdver = getenv('RCCDVER');
prefxdir = sprintf('%s/RCCD%s/',rccddrv,rccdver);
rccdmatdir = sprintf('%s/RCCD%s/%s',rccddrv,rccdver,wrkdir);
cd(rccdmatdir);
%addpath('J:/sandboxR7/svnmatlab/Latex')
addpath('../../mps')
addpath('../common')
addpath('../../Latex')

end