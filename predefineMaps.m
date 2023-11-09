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
% predefine.probe.buz64sp.shank=[reshape(reshape([1:5;10:-1:6],1,[])'+[0,10,20,30,44,54],1,[]),37,38,39,36];
predefine.probe.buz64sp.shank=[ 1 10  2  9  3  8  4  7  5  6 ...
                               11 20 12 19 13 18 14 17 15 16 ...
                               21 30 22 29 23 28 24 27 25 26 ...
                               31 44 32 43 33 42 34 41 35 40 ...
                               45 54 46 53 47 52 48 51 49 50 ...
                               55 64 56 63 57 62 58 61 59 60 ...
                               37 38 39 36];

predefine.probe.buz64sp.omnetics=[37 39 40 42 43 45 46 48 17 19 20 22 23 25 26 28
                                  36 38 35 41 34 44 33 47 18 32 21 31 24 30 27 29
                                  64 62 60 58 56 54 52 50 15 13 11  9  7  5  3  1
                                  63 61 59 57 55 53 51 49 16 14 12 10  8  6  4  2];
predefine.probe.buz64sp.toUse=true(1,64);

%linear 32ch
predefine.probe.linear32.shank=32:-1:1;
predefine.probe.linear32.omnetics=[18 27 28 29 17 30 31 32  1  2  3 16  4  5  6 15
                          20 21 22 23 19 24 25 26  7  8  9 14 10 11 12 13];
predefine.probe.linear32.toUse=true(1,32);

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

% Cambridge F probe
predefine.probe.CamF.shank=[ 41 24 39 33 27 35 40 26 28 37 ...
                             25 43 38 30 36 20 23 45 34 22 21 ...
                             48 46 50 19 17 42 29 44 47 32 18 ...
                             14  1  4 31 53 49 12 16 51 15  3 ...
                             56 63 13 10 52 59  2  6 54 61  8 ...
                             60 58  7  5 64 57 11 55 62  9]

predefine.probe.CamF.omnetics=[32 30 28 26 24 22 20 18 16 14 12 10  8  6  4  2
                               31 29 27 25 23 21 19 17 15 13 11  9  7  5  3  1
                               33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63
                               34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64];
predefine.probe.CamF.toUse=true(1,64);


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


predefine.probe.dbc128_8.shank=[ 13   2  14   1  15   0  12   3  11   4  10   5   9   6   8   7 ...
                                 29  18  30  17  31  16  28  19  27  20  26  21  25  22  24  23 ...
                                 45  34  46  33  47  32  44  35  43  36  42  37  41  38  40  39 ...
                                 61  50  62  49  63  48  60  51  59  52  58  53  57  54  56  55 ...
                                 77  66  78  65  79  64  76  67  75  68  74  69  73  70  72  71 ...
                                 93  82  94  81  95  80  92  83  91  84  90  85  89  86  88  87 ...
                                109  98 110  97 111  96 108  99 107 100 106 101 105 102 104 103 ...
                                125 114 126 113 127 112 124 115 123 116 122 117 121 118 120 119]+1;
                            
predefine.probe.dbc128_8.omnetics=1:128;
predefine.probe.dbc128_8.toUse=true(1,128);          

predefine.preamp.dbc128.inputPin=1:128;
predefine.preamp.dbc128.flip=false;





