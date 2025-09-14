% Creating a Monte Carlo estimate using a modified version of task 2.
% This task uses a function that includes: 1) User-defined input of
% precision. 2) A graphical display should plot the random points as
% generated and is color coded based on if it's inside the circle or
% outside. 3) Precision and computed Pi value displayed in the command
% window and printed out on the plot. 4) The computed Pi value should be
% returned by the function.

function Pi_Estimate_T3 = mcpi(sigfig_precision) % function that returns the Monte Carlo estimate of Pi
% 1) Function takes in a User-defined input of precision.

stability = 5; % Number of total stability checks (Can change manually)
r = 1; % pre-determined radius
stability_check = 0; % Counter that checks to see if it matches with stability  
point_inside = 0; % Counter for points that are inside the circle
T = 0; % Total number of samples
sample_limit = 1e7; % Max number of runs to prevent errors in code
previous_pi = NaN; % Last Pi estimate at a check
pi_estimate = NaN; % Final Pi estimate

batch = 1000; % Number of samples per streamed plotting update 
x_inside = zeros(1, batch); % Stores x-cords of points inside the circle
y_inside = zeros(1, batch); % Stores y-cords of points inside the circle
x_outside = zeros(1, batch); % Stores x-cords of points outside the circle
y_outside = zeros(1, batch); % Stores y-cords of points outside the circle
inside_count = 0; % Counter for x or y points stored inside the circled (Cleared after every stability check)
outside_count = 0; % Counter for x or y points stored outside the circled (Cleared after every stability check)

% 2) Initalized plot that gets updated as it goes through the for loop 
% to create the visual for the value of pi estimate using a Monte Carlo algorithm. 
figure;
hold on; % complete plot initialization
axis square; % X and Y axis are the same
xlabel('x');
ylabel('y');
title('Pi estimation using a Monte Carlo algorithm ');

while true % Infinite loop that continues executing untial a break condition is met
    % Break condition is when the Pi estimate's stability checks equal the
    % manually assigned stability.
    x = rand(); % Returning a random element in the interval (0,1)
    y = rand();
    T = T + 1; % Update total sample

    if T >= sample_limit % If total samples greater than or equal to the sample limit
        warning('Sample Limit reached before stability was achieved.'); % Notify issue
        break; % Exit loop due to issue
    end % End the check

    
    if x.^2 + y.^2 <= r % If x and y points are in the radius (r=1)
        point_inside = point_inside + 1; % If the random point is inside the circle add a point to the counter
        inside_count = inside_count + 1; % Also add a point if a point is inside the circle, clears when greater than buffer
        x_inside(inside_count) = x; % Store the x-cord inside points that'll be plotted (dumped) when batch size is reached
        y_inside(inside_count) = y; % Store the y-cord inside points that'll be plotted (dumped) when batch size is reached

        if inside_count >= batch % If the batch size is reached then...
            plot(x_inside, y_inside, 'r.'); % Plot the points stored inside the circle as red
            drawnow limitrate; % Display Changes and help with point plotting
            inside_count = 0; % Clear and reset the counter to start over again for the next batch
        end % End loop when inside count is cleared
    else
        outside_count = outside_count + 1; % If a point is outside the circle add to counter, clears when greater than buffer
        x_outside(outside_count) = x; % Store the x-cord outside points that'll be plotted (dumped) when batch size is reached
        y_outside(outside_count) = y; % Store the y-cord outside points that'll be plotted (dumped) when batch size is reached

        if outside_count >= batch % If the batch size is reached then...
            plot(x_outside, y_outside, 'b.'); % Plot the points stored outside the circle as blue
            drawnow limitrate; % Display Changes and help with point plotting
            outside_count = 0; % Clear and reset the counter to start over again for the next batch
        end % End loop when outside count is cleared
    end % End this check if the counts aren't greater than the batch anymore

    if point_inside <= 10000 && (inside_count > 0 | outside_count > 0) 
        % Created to help plot points before visual has too many points and
        % if the counts still have points to plot if they dont meet the
        % other if requirements.
        plot(x_inside(1:inside_count), y_inside(1:inside_count), 'r.'); 
        % Plot the remaining inside points after the inside count is not
        % greater than the batch anymore
        plot(x_outside(1:outside_count), y_outside(1:outside_count), 'b.'); 
        % Plot the remaining outside points after the outside count is not
        % greater than the batch anymore
        drawnow limitrate; % Display Changes and help with point plotting
        inside_count = 0; % Final clear of the inside count after ploting is finalized
        outside_count = 0; % Final clear of the outside count after ploting is finalized
    end % End the check if the points are greater than 10,000 or if the counter has 0.
    pi_estimate = 4 * (point_inside / T);
    % This calculation is based on the Probability 'P' which is equal to Pi/4.
    % Since we want Pi the equation becomes Pi = 4 * P.
    % P "represents the probability that a given random point will fall inside the circle."
    target_sigfig = 10^(-sigfig_precision); % User-inputed significant figure

    if ~isnan(previous_pi) % Checks to see if there is a previous estimate
        if abs(pi_estimate - previous_pi) < target_sigfig
        % Checks to see if the signficant figures of the current
        % and previous estimates are less than the desired signifiant figure.                
            stability_check = stability_check + 1; 
        % If the significant figures do match add 1 to the counter
        else
            stability_check = 0; % Reset stability check if not matching
        end
    end
    previous_pi = pi_estimate; % Update previous pi estimate for next iteration
        
    if stability_check >= stability % Check if stability condition is met
        break; % Exit the loop if stable
    end
end
Pi_Estimate_T3 = pi_estimate; 
% 4) Final Pi estimate that is returned from the function with the chosen precision level

fprintf('Computed Value of Pi in %d Significant Figures: %.4f, Number of Samples %d', sigfig_precision, Pi_Estimate_T3, T);
% 3) Computed final value of Pi written out with the user-specified precision.
text(0.05, 0.05, sprintf('Computed Pi Value: %.4f\n Precision: %d', Pi_Estimate_T3, sigfig_precision),...
    'color', 'black', 'BackgroundColor', 'white');
% 3) Computed Value of Pi and precision is printed on the plot.
end % End of the function mcpi

%[appendix]{"version":"1.0"}
%---
