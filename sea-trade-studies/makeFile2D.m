function makeFile2D(datfile, linenumber1, linenumber2, value1, value2)

% Read txt into cell A
fid = fopen(datfile,'r');
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
fclose(fid);
% Change cell A
A{linenumber1} = sprintf('%d',value1);
A{linenumber2} = sprintf('%d',value2);
% Write cell A into txt
fid = fopen(datfile, 'w');
for i = 1:numel(A)
    if A{i+1} == -1
        fprintf(fid,'%s', A{i});
        break
    else
        fprintf(fid,'%s\n', A{i});
    end
end
fclose(fid);