function [] = spc2GlobalOrderParameterVsAlpha
    
    clc;
    
    t_0 = 0;
    dt_recip = 100;
    t_1 = 1000 * dt_recip;
    N = 1000;
    S = 3;
    
    folder = '/Users/nikita/Documents/spc2/spc2ContinuationMethod_nonlocalized/summary_statistics/';
    listing = dir(fullfile(folder, 'order_parameter_*_rho_0.05_*.txt'));
    for l = 1 : length(listing)
        SummaryStatistics = dlmread(fullfile(folder, listing(l).name));
        
        key = '_alpha_';
        index = strfind(listing(l).name, key);
        alpha = sscanf(listing(l).name(index + length(key) : end), '%g', 1);
        if alpha <= 1.565
%             plot(alpha, mean(SummaryStatistics(1 : end)), '.k', 'MarkerSize', 20);
            h_e = errorbar(alpha, mean(SummaryStatistics(1 : end)), std(SummaryStatistics(1 : end)));
            hold on;
            grid on;
            box on;
            
            set(h_e, 'LineStyle', 'none', 'Marker', '.', 'Color', [.3 .3 .3]);
            set(h_e, 'LineWidth', 2, 'Marker', 'o', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [.7 .7 .7]);
            set(gca, 'FontName', 'Helvetica', 'FontSize', 24);
        end
    end
end