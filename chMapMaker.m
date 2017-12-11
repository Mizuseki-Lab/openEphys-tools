function chMapMaker(probes,preamps,mapFileName,preampOrder)
% chmap file generator for open ephys
%
% chMapMaker(probes,preamps,mapFileName,preampOrder)
%
% probes and preamp are cells, each has prebe or preamp info
% in format defiend in predefineMaps.m
%
% mapFileName is output file.
% when it's empty or not given, results are shown on screen
%
% preampOrder is order of connection on the system.
% if it's not specified, it is assumed that probes and premans are given in
% the connected order.
%
% Dec 2017, Hiroyuki Miyawaki 
%
if ~exist('mapFileName','var')
    mapFileName='';
end
if ~exist('preampOrder','var')
    preampOrder=1:length(probes);
else
    if size(preampOrder,1)>1 && size(preampOrder,2)==1
        preampOrder=preampOrder';
    end
    
    %remove gaps
    preampOrder=tiedrank(preampOrder);
end

for n=1:preampOrder
    shanks{n}=reshape(probes{n}.shank,1,[]);
    omnetics{n}=reshape(probes{n}.omnetics,1,[]);
    toUse{n}=reshape(probes{n}.toUse,1,[]);
    if preamps{n}.flip
       preamps{n}.inputPin=rot90(preamps{n}.inputPin,2);
    end    
    inputPin{n}=reshape(preamps{n}.inputPin,1,[]);
end

order=1:sum(cellfun(@length,shanks));

%%
chOnShank=[];
for n=1:length(shanks)
    chOnShank=[chOnShank,shanks{n}+sum(cellfun(@length,shanks(1:n-1)))];
end


chOnConnector=[];
for n=1:length(omnetics)
    chOnConnector=[chOnConnector,omnetics{n}+sum(cellfun(@length,omnetics(1:n-1)))];
end

chOnPreamp=[];
for n=1:length(inputPin)
    chOnPreamp=[chOnPreamp,inputPin{n}+sum(cellfun(@length,inputPin(1:n-1)))];
end

chToUse=[];
for n=1:length(toUse)
    chToUse=[chToUse,toUse{n}];
end

shankMap=sortrows([order;chOnShank]',2)';
for n=1:size(shankMap,2)
    channelMap(n,:)=[chOnPreamp(n),shankMap(1,chOnConnector(n))];
end
channelMap=sortrows(channelMap,2)';



%%

if isempty(mapFileName)
    func=@(x) fprintf(x{:});
else
    fh=fopen(mapFileName,'w');
    func=@(x) fprintf(fh,x{:});
end    

func({'{\r\n'});
func({'    "0": {\r\n'});

func({'      "mapping": [\r\n'});
for n=1:size(channelMap,2)
    func({'        %d',channelMap(1,n)});
    if n<size(channelMap,2)
         func({',\r\n',channelMap(1,n)});
    else
         func({'\r\n',channelMap(1,n)});
    end
end
func({'      ],\r\n'});

func({'      "reference": [\r\n'});
for n=1:size(channelMap,2)
    func({'        -1'});
    if n<size(channelMap,2)
         func({',\r\n',channelMap(1,n)});
    else
         func({'\r\n',channelMap(1,n)});
    end
end 
func({'      ],\r\n'});

func({'      "enabled": [\r\n'});
for n=1:size(channelMap,2)
    if chToUse(n)
        func({'        true'});
    else
        func({'        false'});
    end
    if n<size(channelMap,2)
         func({',\r\n',channelMap(1,n)});
    else
         func({'\r\n',channelMap(1,n)});
    end
end 
func({'      ],\r\n'});
func({'    },\r\n'});

func({'    "refs": {\r\n'});
func({'      "channels": [\r\n'});
func({'        -1,\r\n'});
func({'        -1,\r\n'});
func({'        -1,\r\n'});
func({'        -1\r\n'});
func({'      ]\r\n'});
func({'    },\r\n'});

func({'    "recording": {\r\n'});
func({'      "channels": [\r\n'});
for n=1:size(channelMap,2)
    if chToUse(n)
        func({'        true'});
    else
        func({'        false'});
    end
    if n<size(channelMap,2)
         func({',\r\n',channelMap(1,n)});
    else
         func({'\r\n',channelMap(1,n)});
    end
end 

func({'      ]\r\n'});
func({'    }\r\n'});
func({'  }\r\n'});

if ~isempty(mapFileName)
    fclose(fh);
end