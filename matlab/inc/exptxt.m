
% Always returns as string
% eqflag 1 return as string string
% eqflag 1 return as string equation


function str_ret = exptxt(Val,digits,eqflag)
Val;
%printf('This is exptxt\r\n');
str2_fmt = sprintf('%0.10e',Val);
mantassa = ' ';
length(str2_fmt);
for i = 1:digits+2
	if (str2_fmt(i) == 'e')
		break;
	end
	mantassa(i) = str2_fmt(i);
end
idx = strfind(str2_fmt, 'e');

t=1;
expnt = ' ';

%accomodate negatve
if(str2_fmt(idx+1) == '-')
	expnt(t) = '-';
	t=2;
else
	t=2;
end

for i = idx+t:length(str2_fmt)
	if(str2_fmt(i) ~= '0')
		break;
	end
end

%get rid of leading zeros.
for ii = i:length(str2_fmt)
	expnt(t)=str2_fmt(ii);
	t = t+1;
end
if eqflag == 1
	str_ret = sprintf('%s\\textrm{x}10^{%s}',mantassa,expnt);
else
	str_ret = sprintf('$%s \\ x \\ 10^{%s}$',mantassa,expnt);
end
mantassa;
expnt;