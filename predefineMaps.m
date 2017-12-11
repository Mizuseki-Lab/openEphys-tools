%% maps for probes and preamps
% channel maps designed to use with chMapMaker
%
% predefine.probe.[probename] has following fields
%     .shank : map on recoding site
%     .omnetics : map on connector
%     .toUse : whether channel to be used or not
%
% predefine.probe.[preampname] has following fields
%     .inputPin : map on input pins of preamp
%     .flip : true if the preamp is backside front.
%
%
% by Hiroyuki Miyawaki, 2017
%

%Buz 32
predefine.probe.buz32.shank=reshape(reshape([1:4;8:-1:5],1,[])'+(0:8:24),1,[]);
predefine.probe.buz32.omnetics=[18 27 28 29 17 30 31 32  1  2  3 16  4  5  6 15
                          20 21 22 23 19 24 25 26  7  8  9 14 10 11 12 13];
predefine.probe.buz32.toUse=true(1,32);

%Buz 64sp
predefine.probe.buz64sp.shank=[reshape(reshape([1:5;10:-1:6],1,[])'+[0,10,20,30,44,54],1,[]),37,38,39,36];
predefine.probe.buz64sp.omnetics=[37 39 40 42 43 45 46 48 17 19 20 22 23 25 26 28
                                  36 38 35 41 34 44 33 47 18 32 21 31 24 30 27 29
                                  64 62 60 58 56 54 52 50 15 13 11  9  7  5  3  1
                                  63 61 59 57 55 53 51 49 16 14 12 10  8  6  4  2];
predefine.probe.buz64.toUse=true(1,64);


%addtional input for emg, ecg, etc.
predefine.probe.emg.shank=1:16;
predefine.probe.emg.omnetics=1:16;
predefine.probe.emg.toUse=true(1,16);

%3 aux inputs on intan preamps
predefine.probe.aux.shank=1:3;
predefine.probe.aux.omnetics=1:3;
predefine.probe.aux.toUse=true(1,3);

%8 adc inputs on intan system
predefine.probe.adc.shank=1:8;
predefine.probe.adc.omnetics=1:8;
predefine.probe.adc.toUse=true(1,8);


%intan rhd2132, 32ch amp
predefine.preamp.rhd2132.inputPin=[ 8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
                                 7  6  5  4  3  2  1  0 31 30 29 28 27 26 25 24]+1;
predefine.preamp.rhd2132.flip=false;
                      
%intan rhd2164, 64ch amp
predefine.preamp.rhd2164.inputPin=[16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46
                         17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47
                         15 13 11  9  7  5  3  1  63 61 59 57 55 53 51 49
                         14 12 10  8  6  4  2  0  62 60 58 56 54 52 50 48]+1;
predefine.preamp.rhd2164.flip=false;
                     
%intan rhd2216, 16ch amp w/ custom connector                     
predefine.preamp.custom2216.inputPin=1:16;
predefine.preamp.custom2216.flip=false;

%3 aux inputs on intan preamps
predefine.preamp.aux.inputPin=1:3;
predefine.preamp.aux.flip=false;

%8 adc inputs on intan system
predefine.preamp.adc.inputPin=1:8;
predefine.preamp.adc.flip=false;








