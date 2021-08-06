function [] = PreprocessInputDatasets_2Jobs(pathDataSets, dacapo)
   
    initpwd=pathDataSets



    Zscale = 0; % think time in the experiments
    Tperiod = 5; % sampling period in the experiments
    dataset1 = {'DataSetsS1+0+0-noht' 'DataSetsS2+0+0-noht' 'DataSetsS3+0+0-noht' 'DataSetsS5+0+0-noht' 'DataSetsS7+0+0-noht'}; % BASELINE NO-HT
    dataset2 = {'DataSetsS1+0+0-ht' 'DataSetsS1+5+0-ht' 'DataSetsS2+0+0-ht' 'DataSetsS2+5+0-ht' 'DataSetsS2+10+0-ht'}; % BASELINE HT
    dataset3 = {'DataSetsS1+1+0-noht' 'DataSetsS1+5+0-noht' 'DataSetsS1+10+0-noht' 'DataSetsS1+15+0-noht'};% 'DataSetsS2+0+0-noht' 'DataSetsS2+1+0-noht' 'DataSetsS2+5+0-noht' 'DataSetsS2+10+0-noht' 'DataSetsS2+15+0-noht'}; % NICE NO-HT
    dataset4 = {'DataSetsS1+5+0-ht' 'DataSetsS2+0+0-ht' 'DataSetsS2+5+0-ht' 'DataSetsS2+10+0-ht'}; % NICE HT
    dataset5 = {'DataSetsS7+0+0-noht-batch'}; % SCHEDULER
    dataset6 = {'DataSetsS7+0+0+0+0-noht' 'DataSetsS7+15+10+15+15-noht' 'DataSetsS7+15+5+5+15-noht' 'DataSetsS7+15+10+10+15-noht' 'DataSetsS7+15+10+5+15-noht' 'DataSetsS7+15+10+5+0-noht'}; % 4 jobs
    %datasets = {dataset6{:}}; C=4;
    %%
    %datasets = {'DataSetsS7+0+0-noht'}; C=2;
    %datasets = {'DataSetsS7+10+0-noht'}; C=2;
    %datasets = {'DataSetsS7+15+10+10+15-noht'}; C=4;

    %datasets = {'DataSetsS7+15+10+5+0-noht'}; C=4;
    %datasets = {'DataSetsS7+15+10+5+15-noht'}; C=4;
    %datasets = {'DataSetsS7+15+10+10+15-noht'}; C=4;
    %datasets = {'DataSetsS7+15+5+5+15-noht'}; C=4;
    %datasets = {'DataSetsS7+15+10+15+15-noht'}; C=4;
    datasets = {'DataSetsS7+0+0+0+0-noht4'}; C=4;
    datasets = {'DataSetsS7+0+0-noht1' 'DataSetsS7+0+0-noht2' 'DataSetsS7+0+0-noht3' 'DataSetsS7+0+0-noht4'}; C=2;
%    datasets = {'DataSetsS8+0+0+0+0-noht'}; C=4;
    %datasets = {'server08+0+0+0+0-noht' }; C=4;


    %datasets = {'DataSetsS7+0+0+0+0-noht-z2'}; C=4; Zscale = 2;

    %datasets = {'DataSetsS7+0+0-noht-fifo'}; C=2;
    %datasets = {'DataSetsS7+0+0-noht-batch'}; C=2;
    %datasets = {'DataSetsS2+0+0-noht'}; C=2;
    %datasets = {'DataSetsS7+15+10+5+0-noht'}; C=4;
    %datasets = {'DataSetsS2+0+0-noht-z2'}; C=2; Zscale = 2;
    %%%%%%%%%%%%%%%%%%%datasets = {'DataSetsS2+10+0-noht-z2'}; C=2; Zscale = 2;
    %datasets = {'DataSetsS7+0+0+0+0-noht-z2'}; C=4; Zscale = 2;
    %datasets = {'DataSetsS1+0+0+0+0-noht'}; C=4;
    %datasets = {dataset1{:},dataset2{:},dataset3{:},dataset4{:},dataset5{:}}; C=2;
    %%
    MaxExceptions = 10;
    ERR =[];
    MAXERR =[];
    servers =         {'DataSetsS0','DataSetsS1','DataSetsS2','DataSetsS3','DataSetsS4','DataSetsS5','DataSetsS6','DataSetsS7','DataSetsS8'};
    %servers =         {'server00','server01','server02','server03','server04','server05','server06','server07','server08'};

    servers_sockets = [  1,    2,    2  ,  1  ,  1  ,  1  ,  1  ,  1  ,  2  ];
    for d=1:length(datasets)
        p = find(cellfun(@(s) strcmpi(datasets{d}(1:3), s), servers));
        sockets(d) = servers_sockets(p);
        if strfind(datasets{d},'noht')
            hwthreads(d) = 1;
        else
            hwthreads(d) = 2;
        end
        if C==2
            tmp = regexp(datasets{d}, 'p\d\d([+-]\d+)([+-]\d+)','tokens');
        elseif C==4
            tmp = regexp(datasets{d}, 'p\d\d([+-]\d+)([+-]\d+)([+-]\d+)([+-]\d+)','tokens');
        end
        for c=1:C
            nice(d,c) = str2num(tmp{1}{c});
        end
    end

    for d=1:length(datasets)
        fprintf(1,'Processing %20s\t',datasets{d});
        clear RunQ CPU Errors Tput dacapoRun1Trace
        dataset=datasets{d};
        startpwd=pwd;
        %dacapo={'batik','jython','luindex','lusearch','sunflow','xalan'};
        %dacapoAbbreviations={'ba','jy','li','ls','sf','xa'};

        basepath=sprintf('%s%s%s',pwd,filesep,dataset);
        cd(basepath);
        nameToRun1Trace=[]; % mapping from dacapo cell array to trace file for 1-job run
        D=dir('2*'); traces={D.name};
        Run1Trace=zeros(length(traces),2);

        try
            %delete('./mondata.mat');
            load('./mondata.mat')
            fprintf(1,' [data]');
        catch
            %% for all experiments
            fprintf(1,' [parse]');
            for j=1:length(traces)
                cd(traces{j});
                % load utilization data
                try
                    CPU{j} = sar_loadcpu('logNew.sar',0,'sar');
                    [~,u]=system('sar -f logNew.sar -q |awk ''{print $2}'' | sed ''/[^0-9]/d''  | sed ''1d''');
                catch me
                    CPU{j} = sar_loadcpu('logNew.sar',0,'sar');
                    [~,u]=system('sar -f log.sar -q |awk ''{print $2}'' | sed ''/[^0-9]/d''  | sed ''1d''');
                end
                % load Linux scheduler runqueue data
                RunQTrace{j} = str2num(u);
                RunQ(j,1)=mean(RunQTrace{j});
                RunQ(j,2)=max(RunQTrace{j});
                RunQ(j,3)=std(RunQTrace{j});
                RunQ(j,4)=prctile(RunQTrace{j},75);
                RunQ(j,5)=prctile(RunQTrace{j},90);
                % load exceptions and failures
                [~,x]=system('grep Exception *.err |wc|awk ''{print $1}''');
                Errors(j,1)=str2num(x);
                [~,x]=system('grep FAILED *.err |wc|awk ''{print $1}''');
                Errors(j,2)=str2num(x);
                cd(basepath);
            end

            %% load 1-job dataset
            fprintf(1,' [load1]');
            for j=1:length(traces)
                cd(traces{j});
                % load iterations (throughput)
                [~,y1]=system('cat bench1.err |grep "rundacapo"| awk ''{print $4}''|tail -n 1'); % Use this for old version of Dacapo, ex dataset from G
                [~,y1]=system('cat bench1.err |grep "starting"|awk ''{print $7}''|tail -n 1') % use this for the new version of Dacapo, ex, exp that i have run by myself
                if ~isempty(str2num(y1))
                    Tput(j,1)=str2num(y1)/(length(CPU{j}.all.busy)*Tperiod);
                else
                    Tput(j,1)=0;
                end
                % map from dacapo cell array index to trace files index
                tmp = regexp(traces{j}, '\d+(\w+)$','tokens');
                if ~isempty(tmp)
                    f=find(cellfun(@(s) strcmpi(tmp{1}, s), dacapo)); 
                    nameToRun1Trace(f)=j;
                end
                cd(basepath);
            end

            if isempty(nameToRun1Trace)
                error('Profiling runs not included in the directory');
            end

            %% load C-job datasets
            fprintf(1,' [load%1d]',C);
            for j=1:length(traces)
                if C==2
                    tmp = regexp(traces{j}, '\d+(\w+)\-(\w+)','tokens');
                elseif C==4
                    tmp = regexp(traces{j}, '\d+(\w+)\-(\w+)\-(\w+)\-(\w+)','tokens');
                end
                if ~isempty(tmp)
                    cd(traces{j});
                    % associate with 1-job runs
                    for c=1:C
                        Run1Trace(j,c) = nameToRun1Trace(find(cellfun(@(s) strcmpi(tmp{1}{c}, s), dacapo)));
                        % record iterations (throughput) for class-c job
                        [~,y1]=system(sprintf('cat bench%1d.err |grep "rundacapo "|awk ''{print $4}''|tail -n 1',c)); % Use this for old version of Dacapo, ex dataset from G
                        [~,y1]=system('cat bench2.err |grep "starting"|awk ''{print $7}''|tail -n 1') % use this for the new version of Dacapo, ex, exp that i have run by myself

                        if ~isempty(str2num(y1))
                            Tput(j,3+c)=str2num(y1)/(length(CPU{j}.all.busy)*Tperiod); % denominator is observation period
                        else
                            Tput(j,3+c)=0;
                        end
                    end

                    % total iterations
                    Tput(j,1)=sum(Tput(j,3+(1:C)));
                    cd(basepath);
                end
            end
            save mondata.mat Run1Trace Tput nameToRun1Trace CPU RunQ Errors RunQTrace traces;
            %To copy mondata file to upper folder

                Filename="cp mondata.mat " + pathDataSets+"/"+"mondata-"+datasets{d}+".mat"
                system(Filename)
        end

        %% running predictors
        fprintf(1,' [pred]');
            aaa="111111111111111111"

        stat=zeros(length(traces),4);
        CTLin = [];
        CTMeas = [];
        CTModelRunQ = [];
        QModelRunQ = {};
        CTModelUtil = [];
        ERRLin = [];
        ERRUtil = [];
        ERRRunQ = [];
        for t=1:length(traces)
            cd(traces{t});
            if Run1Trace(t,1)>0 && Errors(t,1)<=MaxExceptions % if it's not a 2-job trace
                RunQ(t,2) = 0;
                M = CPU{Run1Trace(t,1)}.ncores; % / hwthreads(d); % scale by hw threads per core

                %% Measurement
                CTMeas(t,1:C) =  1./Tput(t,3+(1:C));
                TMeas(t,1:C) =  Tput(t,3+(1:C));

                %% Linear model
                for c=1:C
                    TLin(t,c) =  Tput(Run1Trace(t,c),1);
                    CTLin(t,c) =  1./TLin(t,c)+Zscale;
                end
                ERRLin(t,:)  = abs((CTMeas(t,:)-CTLin(t,:)))./CTMeas(t,:);
                ERRTLin(t,:)  = abs((TMeas(t,:)-TLin(t,:)))./TMeas(t,:);

                %% Linear model scaled
                m(t) = 0; % total number of cores needed without overprovisioning
                for c=1:C
                    m(t) = m(t) + mean(CPU{Run1Trace(t,c)}.all.busy * CPU{Run1Trace(t,c)}.ncores);
                end
                for c=1:C
                    if m(t) > M
                        TLinS(t,c) =  Tput(Run1Trace(t,c),1) * M / m(t) ;%* CTLin(t,c) / (Zscale + CTLin(t,c));
                    else
                        TLinS(t,c) =  Tput(Run1Trace(t,c),1) ;% * CTLin(t,c) / (Zscale + CTLin(t,c));
                    end
                    CTLinS(t,c) =  Zscale+1./TLinS(t,c);
                end
                ERRLinS(t,:)  = abs((CTMeas(t,:)-CTLinS(t,:)))./CTMeas(t,:);
                ERRTLinS(t,:)  = abs((TMeas(t,:)-TLinS(t,:)))./TMeas(t,:);

                %% Runqueue-based model
                Z = [];
                L = [];
                for c=1:C
                    Nmax(c) = RunQ(Run1Trace(t,c),2); % Q maximum
                    X(c) = Tput(Run1Trace(t,c),1)*Nmax(c);
                    Navg(c) = RunQ(Run1Trace(t,c),1); % Q average
                    Z(c) = (Nmax(c)-Navg(c))/X(c); % Z=(N-Q)/X
                    L(c) = Navg(c)/(Nmax(c)-Navg(c)) * Z(c)/(M+Navg(c)*(Nmax(c)-1)/Nmax(c));
                end
                w=[];
                for j=1:length(nice(d,:))
                    w(j)= 1024 * (1.25)^(-nice(d,j));
                end
                relprio = repmat(w,M,1);
                isfcfs=zeros(1,M);
                L = repmat(L(:)',M,1); % assume all cores identical
                [TModelRunQ(t,1:C), QModelRunQ{t}] = amvadps(L,Nmax,Z+Zscale,relprio,isfcfs);
                TModelRunQ(t,1:C) = TModelRunQ(t,1:C)./Nmax;
                CTModelRunQ(t,1:C) = 1./TModelRunQ(t,1:C); % Z is included
                ERRRunQ(t,:) = abs((CTMeas(t,:)-CTModelRunQ(t,:)))./CTMeas(t,:);
                ERRTRunQ(t,:) = abs((TMeas(t,:)-TModelRunQ(t,:)))./TMeas(t,:);

                %% Utilization-based model
                n=[]; xm=[]; dm=[]; zm=[];
                for c=1:C
                    n(1,c) = nanmean(CPU{Run1Trace(t,c)}.all.busy * CPU{Run1Trace(t,c)}.ncores);% /hwthreads(d);
                    xm(c) = Tput(Run1Trace(t,c),1);
                    dm(1,c) = 1/xm(c)/M; % multi-core approximation
                    zm(c) = 1/xm(c)-dm(c); % multi-core approximation
                end
                w=zeros(1,length(nice(d,:)));
                for j=1:length(nice(d,:))
                    w(j)= 1024 * (1.25)^(-nice(d,j));
                end
                relprio = repmat(w,M,1);
                TModelUtil(t,1:C) = amvadps(dm,n,zm+Zscale,relprio,isfcfs)./n;
                CTModelUtil(t,1:C) = 1./TModelUtil(t,1:C);
                ERRUtil(t,:) = abs((CTMeas(t,:)-CTModelUtil(t,:)))./CTMeas(t,:);
                ERRTUtil(t,:) = abs((TMeas(t,:)-TModelUtil(t,:)))./TMeas(t,:);

            else
                CTMeas(t,1:C)=NaN;
                ERRLin(t,1:C)=NaN;
                ERRTLin(t,1:C)=NaN;
                ERRLinS(t,1:C)=NaN;
                ERRTLinS(t,1:C)=NaN;
                ERRUtil(t,1:C)=NaN;
                ERRTUtil(t,1:C)=NaN;
                ERRRunQ(t,1:C)=NaN;
                ERRTRunQ(t,1:C)=NaN;
            end
            cd(basepath);
        end
        %%
        MERRLin{d,1} = nanmean(ERRLin);
        MERRTLin{d,1} = nanmean(ERRTLin);
        fprintf(1,' [Lin');
        for c=1:C
            fprintf(1,' %.3f',MERRLin{d}(c));
        end
        fprintf(1,']');
        %%
        MERRLinS{d,1} = nanmean(ERRLinS);
        MERRTLinS{d,1} = nanmean(ERRTLinS);
        fprintf(1,' [LinS');
        for c=1:C
            fprintf(1,' %.3f',MERRLinS{d}(c));
        end
        fprintf(1,']');
        %%
        MERRUtil{d,1} = nanmean(ERRUtil);
        MERRTUtil{d,1} = nanmean(ERRTUtil);
        fprintf(1,' [Util');
        for c=1:C
            fprintf(1,' %.3f',MERRUtil{d}(c));
        end
        fprintf(1,']');
        %%
        MERRRunQ{d,1} = nanmean(ERRRunQ);
        MERRTRunQ{d,1} = nanmean(ERRTRunQ);
        fprintf(1,' [RunQ');
        for c=1:C
            fprintf(1,' %.3f',MERRRunQ{d}(c));
        end
        fprintf(1,']');
        %%
        fprintf(1,'\n');
        cd(startpwd)
        ErrTraces(d) = sum(Errors(:,1)>MaxExceptions);
    end

    %%
    MERRLin=cell2mat(MERRLin); MERRLin(MERRLin==0)=NaN;
    MERRLinS=cell2mat(MERRLinS); MERRLinS(MERRLinS==0)=NaN;
    MERRUtil=cell2mat(MERRUtil); MERRUtil(MERRUtil==0)=NaN;
    MERRRunQ=cell2mat(MERRRunQ); MERRRunQ(MERRRunQ==0)=NaN;
    MERRTLin=cell2mat(MERRTLin); MERRTLin(MERRTLin==0)=NaN;
    MERRTLinS=cell2mat(MERRTLinS); MERRTLinS(MERRTLinS==0)=NaN;
    MERRTUtil=cell2mat(MERRTUtil); MERRTUtil(MERRTUtil==0)=NaN;
    MERRTRunQ=cell2mat(MERRTRunQ); MERRTRunQ(MERRTRunQ==0)=NaN;
    fprintf(1,'Summary (Lin): %.3f\n',nanmean(nanmean(MERRLin,2)));
    fprintf(1,'Summary (LinS): %.3f\n',nanmean(nanmean(MERRLinS,2)));
    fprintf(1,'Summary (Util): %.3f\n',nanmean(nanmean(MERRUtil,2)));
    fprintf(1,'Summary (RunQ): %.3f\n',nanmean(nanmean(MERRRunQ,2)));
    fprintf(1,'Summary (T-Lin): %.3f\n',nanmean(nanmean(MERRTLin,2)));
    fprintf(1,'Summary (T-LinS): %.3f\n',nanmean(nanmean(MERRTLinS,2)));
    fprintf(1,'Summary (T-Util): %.3f\n',nanmean(nanmean(MERRTUtil,2)));
    fprintf(1,'Summary (T-RunQ): %.3f\n',nanmean(nanmean(MERRTRunQ,2)));
    fprintf(1,'Summary (Errors): %d\n',sum(ErrTraces));
    initpwd
    cd(initpwd);

    figure
    %subplot(1,2,1);
    x=[nanmean(ERRLin')',nanmean(ERRLinS')',nanmean(ERRRunQ')']*100;
    boxplot(x,'symbol','')
    hold on
    mx = nanmean(x);
    plot(mx,'.')
    plot(nanmedian(x),'x')
    set(gca,'xticklabel',{'No model','OA','QN'})
    title('Completion Time - Percentage Error (Dataset: ' + string(datasets) +' )')
    legend('mean','median')
    ylim([0,max(100,1.1*max(x(:)))])
    ylim([0,600]);%max(100,1.1*max(x(:)))])

    %fontset

    %subplot(1,2,2);
    %boxplot([max(MERRTLinS')',max(MERRTUtil')',max(MERRTRunQ')']*100)
    %set(gca,'xticklabel',{'Lin-Scaled','Model (Cores)','Model (Runq)'})
    %title('Completion Rate - Percentage Error')

    %char(datasets) is name of dataset after change from cell to char
    aaa="11111111 The End before save 1111111111"
    saveas(gcf,char(datasets),'epsc')
    aaa="11111111 The End after save 1111111111"



    %%%%%%%%%%%%%%% .  Functions 

    function [XN,QN,UN,CN]=amvadps(L,N,Z,relprio,isfcfs)
    %cccc="=================================================="
    %cccc="========= Inside amvadps function  ==========="
    [M,R]=size(L);
    if ~exist('isfcfs','var') isfcfs = zeros(1,M); end
    [XN,QN,UN,CN]=pfqn_amvabs_dps(L,N,Z,1e-6,1000,repmat(N,M,1)/M,relprio,isfcfs);
    end



    function [XN,QN,UN,CN]=pfqn_amvabs_dps(L,N,Z,tol,maxiter,QN,relprio,isfcfs)
    if ~exist('Z','var')
        Z=0*N;
    end
    if ~exist('tol','var')
        tol = 1e-6;
    end
    if ~exist('maxiter','var')
        maxiter = 1000;
    end
    [M,R]=size(L);
    CN=zeros(M,R);
    if ~exist('QN','var')
        QN=repmat(N,M,1)/M;
    end
    if ~exist('relprio','var')
        relprio = ones(M,R);
    end
    XN=zeros(1,R);
    UN=ones(M,R)/M/R;
    CN_1=L;
    for it=1:maxiter
        QN_1 = QN;
        for r=1:R
            for i=1:M
                tss=5; % time-scale separation threshold
                hi = find(relprio(i,:)>tss*relprio(i,r));
                Uhi(i,r) = sum(UN(i,hi));
            end
        end
        for r=1:R
            for i=1:M
                CN(i,r) = L(i,r)/(1-Uhi(i,r));
                for s=1:R
                    if isfcfs(i)
                        demand = L(i,s)/(1-Uhi(i,s));
                    else
                        demand = L(i,r)/(1-Uhi(i,r));
                    end
                    if s~=r && relprio(i,s)==relprio(i,r)
                        CN(i,r) = CN(i,r) + demand*QN(i,s);
                    %elseif s~=r && relprio(i,s)/relprio(i,r)>tss
                        % if there is time-scale separation, 
                        % all is accounted for by 1/(1-Uhi)
                    elseif s~=r && relprio(i,s)/relprio(i,r)<tss
                        CN(i,r) = CN(i,r) + demand*QN(i,s)*relprio(i,s)/relprio(i,r);
                    elseif s==r
                        CN(i,r) = CN(i,r) + demand*QN(i,r)*(N(r)-1)/N(r);
                    end
                end
            end
            XN(r) = N(r)/(Z(r)+sum(CN(:,r)));
        end
        for r=1:R
            for i=1:M
                QN(i,r) = XN(r)*CN(i,r);
            end
        end
        for r=1:R
            for i=1:M
                UN(i,r) = XN(r)*L(i,r);
            end
        end
        if max(abs(QN-QN_1)./QN_1) < tol
            break
        end
        CN_1=CN;
    end
    end



    function cpudata = sar_loadcpu(sarfilepath, wantraw,sarcmd)
    % cpudata = sar_loadcpu(sarfilepath, wantraw)
    % extract utilization data from SAR
    % want
    % This is a function that is used for file "run_all_gen.m"
    cccc="=================================================="
    cccc="========= Inside sar_loadcpu function  ==========="
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

    end

end
