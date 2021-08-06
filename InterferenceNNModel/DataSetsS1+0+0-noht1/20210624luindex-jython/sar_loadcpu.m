function cpudata = sar_loadcpu(sarfilepath, wantraw,sarcmd)
% cpudata = sar_loadcpu(sarfilepath, wantraw)
% extract utilization data from SAR
% want

AAAAAAAAA="222222222222"

sarfilepath= 'logNew.sar';
wantraw = 0;

sarcmd = 'sar';

ComToUpdatedSarFile= 'sadf -c log.sar > logNew.sar';
system(ComToUpdatedSarFile);
if isunix
    tempfilename = tempname;
    cmd = sprintf('%s -P ALL -f %s  | awk \''{ print $2,$3,$4,$5,$6,$7,$8}\'' | sed \''/all/d\'' | sed \''/CPU/d\'' | sed \''/^\\s*$/d\'' > %s',sarcmd,sarfilepath,tempfilename)
    system(cmd);
    cpudata.('raw')=load(tempfilename);
    % timestamps
    %tempfilename = tempname
    %cmd = sprintf('sar -P ALL -f %s  | awk \''{ print $1}\'' | sort| uniq | egrep "[0-9]"  > %s',sarfilepath,tempfilename);
    %system(cmd);
    X=cpudata.raw; X(:,2:end)=X(:,2:end)/100;
    X(find(sum(X(:,2:end),2)==0),:)=[]; % remove inactive cores
    cpudata.('ncores')=1+max(X(:,1));
    % extract utilization data for each processor
    Y={};
    for i=0:(cpudata.ncores-1)
        Y{i+1} = X((1+i):cpudata.ncores:end,2:end);
        Y{i+1}(Y{i+1}>1)=mean(Y{i+1}(Y{i+1}<=1)); % replace measurement errors with average
        if i>0
            Ytot = Ytot + Y{i+1};
        else
            Ytot = Y{1};
        end
    end
    Ytot=Ytot/cpudata.ncores;
    for i=0:(cpudata.ncores-1)
        cpudata.('core'){i+1}.('user') = Y{i+1}(:,1);
        cpudata.('core'){i+1}.('nice') = Y{i+1}(:,2);
        cpudata.('core'){i+1}.('system') = Y{i+1}(:,3);
        cpudata.('core'){i+1}.('iowait') = Y{i+1}(:,4);
        cpudata.('core'){i+1}.('steal') = Y{i+1}(:,5);
        cpudata.('core'){i+1}.('idle') = Y{i+1}(:,6);
        cpudata.('core'){i+1}.('busy') = nansum(Y{i+1}(:,1:5),2);
    end
    AAAAAA="1111111111111"
    cpudata.('all').('user') = Ytot(:,1);
    cpudata.('all').('nice') = Ytot(:,2);
    cpudata.('all').('system') = Ytot(:,3);
    cpudata.('all').('iowait') = Ytot(:,4);
    cpudata.('all').('steal') = Ytot(:,5);
    cpudata.('all').('idle') = Ytot(:,6);
    cpudata.('all').('busy') = sum(Ytot(:,1:5),2);
    cpudata
    if ~wantraw
        cpudata=rmfield(cpudata,'raw');
    end
else
    error('This script is available only under Linux.');
end

