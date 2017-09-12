close all;
clear;

load('./My_data/Argo_data_aggr.mat');

%% Temporal selection

month = 8;

idx = (profMonthAggr >= month-1 & profMonthAggr <= month+1);

profPresAggr = profPresAggr(idx);
profTempAggr = profTempAggr(idx);
profPsalAggr = profPsalAggr(idx);
profYearAggr = profYearAggr(idx);
profLatAggr = profLatAggr(idx);
profLongAggr = profLongAggr(idx);
profJulDayAggr = profJulDayAggr(idx);
profFloatIDAggr = profFloatIDAggr(idx);

nProf = sum(idx);

%% Spatial selection

latGrid = linspace(-65,65,131);
longGrid = linspace(20,380,361);

mask = ncread('./RG_climatology/RG_ArgoClim_Temperature_2016.nc','BATHYMETRY_MASK',[1 1 25],[Inf Inf 1]);
mask(mask == 0) = 1;

idx = zeros(nProf,1);

for iProf = 1:nProf
    if profLatAggr(iProf) < -65 || profLatAggr(iProf) >= 65
        continue;
    end
    iLat = find(profLatAggr(iProf) >= latGrid,1,'last');
    iLong = find(profLongAggr(iProf) >= longGrid,1,'last');
    idx(iProf) = ~isnan(mask(iLong,iLat));
end

idx = logical(idx);

profPresAggr = profPresAggr(idx);
profTempAggr = profTempAggr(idx);
profPsalAggr = profPsalAggr(idx);
profYearAggr = profYearAggr(idx);
profLatAggr = profLatAggr(idx);
profLongAggr = profLongAggr(idx);
profJulDayAggr = profJulDayAggr(idx);
profFloatIDAggr = profFloatIDAggr(idx);

nProf = sum(idx);

%%

save(['./My_data/Argo_data_aggr_',num2str(month,'%02d'),'_extended.mat'],'startYear','endYear','nProf','profLatAggr','profLongAggr','profYearAggr','profFloatIDAggr','profJulDayAggr','profPresAggr','profTempAggr','profPsalAggr');