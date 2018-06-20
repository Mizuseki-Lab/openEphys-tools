clear
baseDir='~/data/sleep/pooled_withCohEMG/';
coreName='sleep';

varList={'basics'
    'behavior'
    ...'ripple'
    ...'spindle'
    ...'hpcSpindlePhase'
    ...'ctxSpindlePhase'
    ...'HL'
    ...'HLwavelet'
    ...'MA'
    ...'HLfine'
    ...'onOff'
    ...'hpcSWA'
    ...'pfcSWA'
    ...'recStart'
    ...'position'
    ...'speed'
    ...'spectrum'
    ...'spikes'
    ...'modulatedCell'
    ...thetaPhase'
    ...'pfcEeg'
    ...'emg'
    ...'firing'
    ...'eventRate'
    'stableSleep20s'
    ...'stableWake'
    'stateChange20s'
    'trisecFiring'
    ...'binnedFiring'
    ...'thetaBand'
    ...'sleepPeriod'
    ...'recStart'
    ...'deltaBand'
    ...'thetaBand'
    ...'pairCorr'
    ...'pairCorrHIGH'
    'timeNormFR'
    }';

for varName=varList
    load([baseDir coreName '-' varName{1} '.mat'])
end

% HL=HLfine;
dList=fieldnames(basics);

%%

nDiv=5;
nShuffle=5;
% stateList={'nrem','rem','rem2nrem','nrem2rem','nrem2rem2nrem','rem2nrem2rem'};
% 'quiet2nrem','nrem2quiet','rem2quiet'
% stateList={'nrem2rem2nrem','rem2nrem2rem'};
funcCI=@(x) diff(x,1,2)./sum(x,2);

% wakeString='quiet';

% for stateIdx=1:length(stateList)
%     state=stateList{stateIdx};
state='nrem';
display([datestr(now) ' started ' state])
clear fr

stateNames=strsplit(state,'2');
% saveStateName=strrep(state,wakeString,'wake');

for dIdx=1:length(dList)
    dName=dList{dIdx};
    
    targetIdx=stateChange.(dName).(state);
    
    dur=diff(behavior.(dName).list(targetIdx,1:2)/1e6,1,2);
    
    toUse=false(size(targetIdx,1),1);
    isFirst=false(size(targetIdx,1),1);
    isLast=false(size(targetIdx,1),1);
    for slpIdx=1:size(stableSleep.(dName).time,1)
        temp=false(size(targetIdx));
        for n=1:length(stateNames)
            temp(ismember(targetIdx(:,n),stableSleep.(dName).(stateNames{n}){slpIdx}),n)=true;
        end
        temp=all(temp,2);
        toUse(temp)=true;
        isFirst(find(temp,1,'first'))=true;
        isLast(find(temp,1,'last'))=true;
    end
    
    toUse(isFirst&isLast)=false;
    
    targetIdx(~toUse,:)=[];
    isFirst(~toUse)=[];
    isLast(~toUse)=[];
    dur(~toUse)=[];
    
    fr(dIdx).isFirst=isFirst;
    fr(dIdx).isLast=isLast;
    fr(dIdx).dur=dur;
    %     for n=1:length(stateNames)
    %         if strcmpi(stateNames{n},wakeString)
    %             targetIdx(diff(behavior.(dName).list(targetIdx(:,n),1:2),1,2)<60e6,:)=[];
    %         end
    %     end
    
    for cType={'pyr','inh'}
        fr(dIdx).(cType{1})=double.empty(0,0,0);
        
        if isempty(trisecFiring.(dName).(cType{1}).rate{1})
            continue
        end
        
        switch length(stateNames)
            case 1 %nrem / rem
                temp1=cat(3,trisecFiring.(dName).(cType{1}).rate{targetIdx(:,1)});
                if isempty(temp1)
                    continue
                end
                fr(dIdx).(cType{1})=temp1(:,[1,end],:);
            case 2 %'quiet2nrem','nrem2quiet','rem2quiet','rem2nrem','nrem2rem'
                if strcmpi(stateNames{1},wakeString)
                    temp1=cellfun(@(x) mean(x,2),timeNormFR.(dName).offset.(cType{1})(targetIdx(:,1)),'UniformOutput',false);
                    if isempty(temp1)
                        continue
                    end
                    temp1=cat(3,temp1{:});
                else
                    temp1=cat(3,trisecFiring.(dName).(cType{1}).rate{targetIdx(:,1)});
                    if isempty(temp1)
                        continue
                    end
                    temp1=temp1(:,end,:);
                end
                
                if strcmpi(stateNames{2},wakeString)
                    temp2=cellfun(@(x) mean(x,2),timeNormFR.(dName).onset.(cType{1})(targetIdx(:,2)),'UniformOutput',false);
                    if isempty(temp2)
                        continue
                    end
                    temp2=cat(3,temp2{:});
                else
                    temp2=cat(3,trisecFiring.(dName).(cType{1}).rate{targetIdx(:,2)});
                    if isempty(temp2)
                        continue
                    end
                    temp2=temp2(:,1,:);
                end
                fr(dIdx).(cType{1})=cat(2,temp1,temp2);
            case 3
                temp1=cat(3,trisecFiring.(dName).(cType{1}).rate{targetIdx(:,1)});
                if isempty(temp1)
                    continue
                end
                %                     temp1=temp1(:,end,:);
                temp1=mean(temp1,2);
                
                temp2=cat(3,trisecFiring.(dName).(cType{1}).rate{targetIdx(:,end)});
                if isempty(temp2)
                    continue
                end
                %                     temp2=temp2(:,1,:);
                temp2=mean(temp2,2);
                
                fr(dIdx).(cType{1})=cat(2,temp1,temp2);
            otherwise
                continue
        end
    end
end

%%
close all
nZero=[];
nCell=[];
dur=[];
for dIdx=1:length(dList)
    nZero=[nZero;squeeze(sum(fr(dIdx).pyr(:,1,:)==0))];
    nCell=[nCell;size(fr(dIdx).pyr,1)*ones(size(fr(dIdx).pyr,3),1)];
    dur=[dur;fr(dIdx).dur];    
end

temp=(1:3)+(1:3)'*4;
subplot(4,4,temp(:))

plot(dur,nZero./nCell*100,'.')
set(gca,'XScale','log')
ylabel('Fraction of zero-firing cell in first thirds (%)')
xlabel('NREM duration (s)')
get(gca,'xtick')
xRange=get(gca,'xlim');
yRange=get(gca,'ylim');

subplot(4,4,1:3)
[cnt,bin]=hist(dur,10.^(1:0.1:4));
plot(bin,cnt/sum(cnt)*100)
set(gca,'xscale','log')
ylabel('%')
xlim(xRange)

subplot(4,4,8:4:16)
[cnt,bin]=hist(nZero./nCell*100,0:2.5:100);
plot(cnt/sum(cnt)*100,bin)
xlabel('%')
ylim(yRange)

addScriptName(mfilename)

print(gcf,'~/Dropbox/Quantile/preliminary/NREMduration_zeroFiring.pdf','-dpdf')




















