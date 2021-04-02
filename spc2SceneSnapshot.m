function [] = spc2SceneSnapshot

    clc;
    
%     folder = '/Users/nikita/Documents/spc2/spc2ContinuationMethod_nonlocalized/rejected/';
%     N = 1000;
%     S = 3;
%     
%     listing = dir(fullfile(folder, '*.bin'));
%     for l = 1 : length(listing)
%         file_id = fopen(fullfile(folder, listing(l).name));
%         X = fread(file_id, [S * N, 1], 'float');
%         fclose(file_id);
%         scatter(mod(X(1 : S : S * N - 2), 1), mod(X(2 : S : S * N - 1), 1), [], mod(X(3 : S : S * N), 2 * pi) ./ (2 * pi), 'filled');
%         xlim([0 1]);
%         ylim([0 1]);
%         axis square;
%         grid on;
%         box on;
%         xlabel('x');
%         ylabel('y');
%         
%         [~, name, ~] = fileparts(listing(l).name);
%         print(strcat(folder, name, '.eps'), '-depsc2');
%     end
    
    file_name = sprintf('/Users/nikita/Documents/Projects/spc2/spc2OdeIntegration/v0_1_sigma_4_rho_0.3_alpha_1.54_Dphi_0_N_10000_0_0.bin');
    file_id = fopen(file_name);
    
    n = 10000;
    s = 3; % number of particle state variables
    skip_times = 200;
    
    size_of_float = 4;
    status = fseek(file_id, (1 + s * n) * skip_times * size_of_float, 'bof'); % skip time steps
    assert(~status);
    t = fread(file_id, 1, 'float')
    system_state = fread(file_id, [s * n, 1], 'float'); % without time
    
%     [R, G, B] = jet2rgb(mod(X(3 : S : S * N).', 2*pi)/(2*pi));
    x = mod(system_state(1 : s : s*n-2), 1);
    y = mod(system_state(2 : s : s*n-1), 1);
    phi = mod(system_state(3 : s : s*n), 2*pi) ./ (2*pi);
    figure;
    h = scatter(x, y, [], phi, 'filled', 'MarkerEdgeColor', [0 0 0]);
    caxis([0 1]); colormap(hsv);
    axis square;
    grid on;
    box on;
    
    set(gca,...
        'Units', 'normalized',...
        'FontUnits', 'points',...
        'FontWeight', 'normal',...
        'FontSize', 24,...
        'FontName', 'Helvetica',...
        'linew', 1);
    set(gcf, 'Units', 'normalized', 'Position', [.1 .1 .6 .6]);
        
end