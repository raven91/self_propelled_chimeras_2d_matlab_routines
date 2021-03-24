function [] = spc2GlobalOrderParameterVsTime

    clc;
    hold off;
    
    t_0 = 0;
    dt_recip = 100;
    t_1 = 2000 * dt_recip;
    N = 10000;
    S = 3;
    figure;
    
%     folder = '/Users/nikita/Documents/Projects/spc2/spc2OdeIntegration/rk4/';
%     listing = dir(fullfile(folder, 'sigma_1_rho_0.3_alpha_1.54_Dphi_0_N_1000_*.bin'));
%     for l = 1 : length(listing)
%         file_id = fopen(fullfile(folder, listing(l).name));
%         SystemState = fread(file_id, [1 + S * N, t_1 - t_0 + 1], 'float');
%        
%         OrderParameter = zeros(1, t_1 - t_0 + 1);
%         for t = t_0 : 1 : t_1 - 1
%             fprintf('%f\n', t);
%             for i = 1 : N
%                 OrderParameter(t + 1, 1) = OrderParameter(t + 1, 1) + complex(cos(SystemState(1 + S * i, t + 1)), sin(SystemState(1 + S * i, t + 1)));            
%             end
%         end
%         OrderParameter = OrderParameter ./ N;
% 
% %         AveragedOrderParameter = flipud(my_tsmovavg(flipud(abs(OrderParameter)), 's', 10 * dt_recip, 1));
% %         plot([1 : t_1] ./ 10, AveragedOrderParameter(1 : t_1), 'Color', [0.56 0.67 0.74], 'LineWidth', 2);
%         plot(SystemState(1, :), abs(OrderParameter(:, 1)));
%         ylim([0 1]);
%         hold on;
%         grid on;
%         box on;
%     end

    folder = '/Users/nikita/Documents/Projects/spc2/spc2OdeIntegration/Rk4Nonlocalized/';
    listing = dir(fullfile(folder, 'summary_statistics_sigma_1_rho_0.03_alpha_1.5_Dphi_0_N_1000_*.txt'));
    L = 2; % LC:8, NLC:2
    for l = 1 : length(listing)
        fprintf("file #%d\n", l);
        if l ~= L
            SummaryStatistics = dlmread(fullfile(folder, listing(l).name));

            AveragedOrderParameter = flipud(my_tsmovavg(flipud(SummaryStatistics(:, 2)), 's', 10 * dt_recip, 1));
            color = [0.5 0.5 0.5];
            plot([1 : t_1] ./ (dt_recip), AveragedOrderParameter(1 : t_1, 1), 'Color', color);
%             plot(SummaryStatistics(:, 1), SummaryStatistics(:, 2), 'Color', color);
            ylim([0 1]);
            hold on;
            grid on;
            box on;

%             [~, name, ~] = fileparts(listing(l).name);
%             print(strcat(folder, name, '.eps'), '-depsc2');
        end
    end
    
    SummaryStatistics = dlmread(fullfile(folder, listing(L).name));
    AveragedOrderParameter = flipud(my_tsmovavg(flipud(SummaryStatistics(:, 2)), 's', 10 * dt_recip, 1));
    color = [0 0 0];%[0.9 0.34 0];
    plot([1 : t_1] ./ (dt_recip), AveragedOrderParameter(1 : t_1), 'Color', color, 'LineWidth', 2);
%     plot(SummaryStatistics(:, 1), SummaryStatistics(:, 2), 'Color', color);
    ylim([0 1]);
    hold on;
    grid off;
    box on;
    
    AveragedOrderParameter = flipud(my_tsmovavg(flipud(SummaryStatistics(:, 2)), 's', 20 * dt_recip, 1));
    Gradient = gradient(AveragedOrderParameter) * dt_recip;
    Gradient(AveragedOrderParameter < 0.5) = Inf;
    NonIncrDiff = find(Gradient <= 1e-4);
    AveragedOrderParameter = flipud(my_tsmovavg(flipud(SummaryStatistics(:, 2)), 's', 10 * dt_recip, 1));
    plot(NonIncrDiff(1)/dt_recip, AveragedOrderParameter(NonIncrDiff(1)), '.k', 'MarkerSize', 30);
    line([NonIncrDiff(1)/dt_recip NonIncrDiff(1)/dt_recip], [0 AveragedOrderParameter(NonIncrDiff(1))], 'Color', [0 0 0], 'LineWidth', 2, 'LineStyle', '--');
    fprintf('%f\n', NonIncrDiff(1)/dt_recip);

    set(gca,...
        'Units', 'normalized',...
        'FontUnits', 'points',...
        'FontWeight', 'normal',...
        'FontSize', 36,...
        'FontName', 'Helvetica',...
        'XTick', [0 : 500 : 2000],...
        'YTick', [0 : 0.5 : 1],...
        'linew', 1);
    
%     hLegend = legend([p_lc p_nlc], ...
%         'LC', 'NLC');
%     set([hLegend gca], 'FontName', 'Helvetica');
%     set([hLegend gca], 'FontSize', 24);
%     hLegend = legend([p1 p4], ...
%         '{\it \sigma } = 1', '{\it \sigma } = 4');

end