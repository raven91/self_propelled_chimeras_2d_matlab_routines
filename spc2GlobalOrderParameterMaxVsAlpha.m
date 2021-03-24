function [] = spc2GlobalOrderParameterMaxVsAlpha
    
    clc;
    figure;
    
    dt_recip = 100;
    dt = 1.0 / dt_recip;
    
    folder = '/Users/nikita/Documents/Projects/spc2/spc2OdeIntegration/rk4_max_time/';
    MarkerTypes = ['^'; '^'; 'v'; 'v'; 'd'];
    MarkerColors = [200 60 0;
                    0 0 0;
                    62 0 193;
                    0 0 0;
                    233 164 0] / 255;
    LegendHandles = zeros(5, 1);
%     LegendNames = string(5, 1);
    for rho_i = 1 : 2 : 5
        rho = rho_i * 0.1;
        listing = dir(fullfile(folder, strcat('summary_statistics*_rho_', num2str(rho), '_*.txt')));
        MaxTimes = zeros(length(listing), 2);
        for l = 1 : length(listing)
            SummaryStatistics = dlmread(fullfile(folder, listing(l).name));
            AveragedOrderParameter = flipud(my_tsmovavg(flipud(SummaryStatistics(:, 2)), 's', 10 * dt_recip, 1));
            Gradient = gradient(AveragedOrderParameter) * dt_recip;
            Gradient(AveragedOrderParameter < 0.5) = Inf;
            NonIncrDiff = find(Gradient <= 1e-3);
            
            key = '_alpha_';
            index = strfind(listing(l).name, key);
            alpha = sscanf(listing(l).name(index + length(key) : end), '%g', 1)
            MaxTimes(l, 1) = alpha;
            MaxTimes(l, 2) = NonIncrDiff(1) * dt;
        end
        MaxTimes = sortrows(MaxTimes);
%         LegendHandles(rho_i, 1) = plot(MaxTimes(:,1), MaxTimes(:,2), '.-', 'LineWidth', 2, 'MarkerSize', 26);
        LegendHandles(rho_i, 1) = plot(MaxTimes(:,1), MaxTimes(:,2), '-k', 'LineWidth', 2, 'MarkerSize', 10);
%         LegendNames(10*rho, 1) = strcat('{\it \rho } = ', rho);
        hold on;
        grid off;
        box on;
    end
    line([pi/2 pi/2], [0 1000], 'Color', [0 0 0], 'LineStyle', '--', 'LineWidth', 2);
    
    set(gca,...
        'Units', 'normalized',...
        'FontUnits', 'points',...
        'FontWeight', 'normal',...
        'FontSize', 36,...
        'FontName', 'Helvetica',...
        'linew', 1);
    LegendNames = {'\rho = 0.1', '\rho = 0.2', '\rho = 0.3', '\rho = 0.4', '\rho = 0.5'};
%     hLegend = legend(LegendHandles(1:2:rho_i), LegendNames(1:2:rho_i), 'interpreter', 'tex', 'Location', 'northwest');
%     set(hLegend, 'FontName', 'Helvetica', 'FontSize', 24);
    
%     listing = dir(fullfile(folder, 'summary_statistics*_rho_0.4_*.txt'));
%     for l = 1 : length(listing)
%         SummaryStatistics = dlmread(fullfile(folder, listing(l).name));
%         AveragedOrderParameter = flipud(my_tsmovavg(flipud(SummaryStatistics(:, 2)), 's', 10 * dt_recip, 1));
%         [Pks, Locs] = findpeaks(AveragedOrderParameter, 'MinPeakHeight', 0.5);
%         
%         key = '_alpha_';
%         index = strfind(listing(l).name, key);
%         alpha = sscanf(listing(l).name(index + length(key) : end), '%g', 1);
%         h_p = plot(alpha, Locs(1) * dt, '.k', 'MarkerSize', 20);
% %         plot(alpha, mean(SummaryStatistics(1 : end)), '.k', 'MarkerSize', 20);
% %         h_e = errorbar(alpha, mean(SummaryStatistics(1 : end)), std(SummaryStatistics(1 : end)));
%         hold on;
%         grid on;
%         box on;
% 
%         set(h_p, 'LineStyle', 'none', 'Marker', '.', 'Color', [.3 .3 .3]);
%         set(h_p, 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7]);
%         set(gca, 'FontName', 'Helvetica', 'FontSize', 24);
%     end
end