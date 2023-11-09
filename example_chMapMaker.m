%% load predefine maps

clear
run('predefineMaps')
%% setting probes, preamps, and an output file
%
%example for recoding with buz32, buz64sp, and emg. 
%aux inputs and adc are enabled

mapFileName='~/Desktop/buz32+64sp+16.map';
idx=0;

%probe1: buz32
idx=idx+1;
probes{idx}=predefine.probe.buz32;
preamps{idx}=predefine.preamp.rhd2132;

%probe2: buz64sp, preamp is flipped
idx=idx+1;
probes{idx}=predefine.probe.buz64sp;
preamps{idx}=predefine.preamp.rhd2164;
preamps{idx}.flip=true;

%emg, use only 2 channels
idx=idx+1;
probes{idx}=predefine.probe.emg;
preamps{idx}=predefine.preamp.custom2216;
probes{idx}.toUse=[false(1,3),true,false,true,false(1,10)];

%aux, use 1st and 3rd probes
for n=1:3
    idx=idx+1;
    probes{idx}=predefine.probe.aux;
    preamps{idx}=predefine.preamp.aux;
end
probes{5}.toUse(:)=false;

%adc
idx=idx+1;
probes{idx}=predefine.probe.adc;
preamps{idx}=predefine.preamp.adc;

%% run chMapMaker
chMapMaker(probes,preamps,mapFileName);

%%

