function [] = spc2GlobalOrderParameterVsRho
    
    clc;
    figure;
    
    t_0 = 0;
    dt_recip = 100;
    t_1 = 1000 * dt_recip;
    N = 1000;
    S = 3;
    
    folder = '/Users/nikita/Documents/Projects/spc2/spc2ContinuationMethod_localized/summary_statistics/';
    listing = dir(fullfile(folder, 'order_parameter_*_alpha_1.54_*.txt'));
%     listing = dir(fullfile(folder, 'order_parameter_*_alpha_1.5_*.txt'));
    Rhos = zeros(length(listing), 3);
    for l = 1 : length(listing)
        SummaryStatistics = dlmread(fullfile(folder, listing(l).name));
        
        key = '_rho_';
        index = strfind(listing(l).name, key);
        rho = sscanf(listing(l).name(index + length(key) : end), '%g', 1);
        if rho >= 0.0
%             plot(rho, mean(SummaryStatistics(1 : end)), '.k', 'MarkerSize', 20);
%             h_e = errorbar(rho, mean(SummaryStatistics(1 : end)), std(SummaryStatistics(1 : end)));
            hold on;
            grid off;
            box on;

%             set(h_e, 'LineStyle', 'none', 'Marker', '.', 'Color', [.3 .3 .3]);
%             set(h_e, 'LineWidth', 2, 'Marker', 'o', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7]);
%             set(gca, 'FontName', 'Helvetica', 'FontSize', 24);
            Rhos(l, 1) = rho;
            Rhos(l, 2) = mean(SummaryStatistics(1 : end));
            Rhos(l, 3) = std(SummaryStatistics(1 : end));
        end
    end
    
    [l,p] = boundedline(Rhos(:,1), Rhos(:,2), Rhos(:,3), '-', 'alpha');
    l.LineWidth = 2;
    l.Color = [0.5 0.5 0.5];
    p.FaceColor = [0.5 0.5 0.5];
    p.EdgeColor = [0.5 0.5 0.5];
    outlinebounds(l,p);
%     errorbar(Rhos(:,1), Rhos(:,2), Rhos(:,3));
    
    ylim([0 1]);
    xlim([0.24 0.35]);
%     xlim([0.01 0.1]);
    set(gca,...
        'Units', 'normalized',...
        'FontUnits', 'points',...
        'FontWeight', 'normal',...
        'FontSize', 36,...
        'FontName', 'Helvetica',...
        'XTick', [0.25 : 0.05 : 0.35],...
        'linew', 1);

end