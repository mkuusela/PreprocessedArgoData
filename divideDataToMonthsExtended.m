close all;
clear;

% Extract the full dataset
cd ./Data/
system('tar -xvzf Argo_data_aggr.tar.gz');
cd ..

for iMonth=1:12
    
    disp(iMonth);

    load('./Data/Argo_data_aggr.mat');

    % Select three month subset of data

    month = iMonth;

    switch month
        case 1
            idx = (profMonthAggr == 1 | profMonthAggr == 2 | profMonthAggr == 12);
        case 12
            idx = (profMonthAggr == 11 | profMonthAggr == 12 | profMonthAggr == 1);
        otherwise
            idx = (profMonthAggr >= month-1 & profMonthAggr <= month+1);
    end

    profPresAggr = profPresAggr(idx);
    profTempAggr = profTempAggr(idx);
    profPsalAggr = profPsalAggr(idx);
    profYearAggr = profYearAggr(idx);
    profLatAggr = profLatAggr(idx);
    profLongAggr = profLongAggr(idx);
    profJulDayAggr = profJulDayAggr(idx);
    profFloatIDAggr = profFloatIDAggr(idx);
    profCycleNumberAggr = profCycleNumberAggr(idx);

    nProf = sum(idx);

    % Filter using the Roemmich-Gilson land mask

    latGrid = linspace(-65,65,131);
    longGrid = linspace(20,380,361);

    mask = ncread('RG_ArgoClim_Temperature_2016.nc','BATHYMETRY_MASK',[1 1 25],[Inf Inf 1]); % Load land mask from the RG climatology (http://sio-argo.ucsd.edu/RG_Climatology.html)
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
    profCycleNumberAggr = profCycleNumberAggr(idx);

    nProf = sum(idx);

    save(['./Data/Extended/Argo_data_aggr_',num2str(month,'%02d'),'_extended.mat'],'startYear','endYear','nProf','profLatAggr','profLongAggr','profYearAggr','profFloatIDAggr','profCycleNumberAggr','profJulDayAggr','profPresAggr','profTempAggr','profPsalAggr');

end

system('rm ./Data/Argo_data_aggr.mat');