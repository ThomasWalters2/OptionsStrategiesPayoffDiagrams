%% Saddle 
clear all; close all; clc
% MATLAB Script for Straddle Options Payoff Diagram

% Inputs
strike_price = 100;    % Strike price of both call and put options
call_premium = 10;     % Premium of the call option
put_premium = 10;       % Premium of the put option
stock_range = 50:150;  % Range of stock prices to evaluate

% Initialize payoff arrays
call_payoff = zeros(size(stock_range));
put_payoff = zeros(size(stock_range));
total_payoff = zeros(size(stock_range));

% Calculate payoffs
for i = 1:length(stock_range)
    S = stock_range(i);
    call_payoff(i) = max(0, S - strike_price) - call_premium;  % Call option payoff
    put_payoff(i) = max(0, strike_price - S) - put_premium;    % Put option payoff
    total_payoff(i) = call_payoff(i) + put_payoff(i);          % Total straddle payoff
end

% Plot the payoff diagram
figure;
plot(stock_range, call_payoff, 'c-', 'LineWidth', 1); hold on;
plot(stock_range, put_payoff, 'b-', 'LineWidth', 1);
plot(stock_range, total_payoff, 'k-', 'LineWidth', 1.25);
xlabel('Stock Price at Expiration');
ylabel('Payoff');
title('Straddle Options Strategy Payoff Diagram');
legend('Call Payoff', 'Put Payoff', 'Total Payoff');
grid off;
hold off;

% Display information
fprintf('Strike Price: $%.2f\n', strike_price);
fprintf('Call Premium: $%.2f\n', call_premium);
fprintf('Put Premium: $%.2f\n', put_premium);

%% Iron Condor
clear all; close all; clc
% MATLAB Script for Iron Condor Options Strategy Payoff Diagram

% Inputs: Modify these values to customize the strategy
stock_range = 50:0.1:150;   % Range of stock prices to evaluate at expiration
K1 = 80;                    % Strike price of the long put
K2 = 90;                    % Strike price of the short put
K3 = 110;                   % Strike price of the short call
K4 = 120;                   % Strike price of the long call
premium_long_put = 5;       % Premium of the long put
premium_short_put = 8;      % Premium of the short put
premium_short_call = 7;     % Premium of the short call
premium_long_call = 4;      % Premium of the long call

% Initialize payoff arrays
long_put_payoff = zeros(size(stock_range));
short_put_payoff = zeros(size(stock_range));
short_call_payoff = zeros(size(stock_range));
long_call_payoff = zeros(size(stock_range));
total_payoff = zeros(size(stock_range));

% Calculate payoffs
for i = 1:length(stock_range)
    S = stock_range(i);
    % Long Put Payoff
    long_put_payoff(i) = max(K1 - S, 0) - premium_long_put;
    % Short Put Payoff
    short_put_payoff(i) = premium_short_put - max(K2 - S, 0);
    % Short Call Payoff
    short_call_payoff(i) = premium_short_call - max(S - K3, 0);
    % Long Call Payoff
    long_call_payoff(i) = max(S - K4, 0) - premium_long_call;
    
    % Total Payoff
    total_payoff(i) = long_put_payoff(i) + short_put_payoff(i) + short_call_payoff(i) + long_call_payoff(i);
end

% Plot the payoff diagram
figure;
plot(stock_range, long_put_payoff, 'b', 'LineWidth', 0.75); hold on;
plot(stock_range, short_put_payoff, 'c', 'LineWidth', 0.75);
plot(stock_range, short_call_payoff, 'r', 'LineWidth', 0.75);
plot(stock_range, long_call_payoff, 'm', 'LineWidth', 0.75);
plot(stock_range, total_payoff, 'k', 'LineWidth', 1.25);
xlabel('Stock Price at Expiration');
ylabel('Payoff');
title('Iron Condor Options Strategy Payoff Diagram');
legend('Long Put Payoff', 'Short Put Payoff', 'Short Call Payoff', 'Long Call Payoff', 'Total Payoff');
grid off;
hold off;

% Display information
fprintf('Strike Prices: K1 = $%.2f, K2 = $%.2f, K3 = $%.2f, K4 = $%.2f\n', K1, K2, K3, K4);
fprintf('Premiums: Long Put = $%.2f, Short Put = $%.2f, Short Call = $%.2f, Long Call = $%.2f\n', premium_long_put, premium_short_put, premium_short_call, premium_long_call);

%% Butterfly

% MATLAB Script for Butterfly Spread Options Strategy Payoff Diagram

% Inputs: Modify these values to customize the strategy
stock_range = 50:0.1:150;   % Range of stock prices to evaluate at expiration
K1 = 80;                    % Strike price of the lower call
K2 = 100;                   % Strike price of the middle call
K3 = 120;                   % Strike price of the higher call
premium_long_call1 = 5;     % Premium of the lower strike long call
premium_short_call = 10;    % Premium of the middle strike short call (per option)
premium_long_call2 = 4;     % Premium of the higher strike long call

% Initialize payoff arrays
long_call1_payoff = zeros(size(stock_range));
short_call_payoff = zeros(size(stock_range));
long_call2_payoff = zeros(size(stock_range));
total_payoff = zeros(size(stock_range));

% Calculate payoffs
for i = 1:length(stock_range)
    S = stock_range(i);
    % Lower Strike Long Call Payoff
    long_call1_payoff(i) = max(S - K1, 0) - premium_long_call1;
    % Middle Strike Short Call Payoff (x2)
    short_call_payoff(i) = 2 * (premium_short_call - max(S - K2, 0));
    % Higher Strike Long Call Payoff
    long_call2_payoff(i) = max(S - K3, 0) - premium_long_call2;
    
    % Total Payoff
    total_payoff(i) = long_call1_payoff(i) + short_call_payoff(i) + long_call2_payoff(i);
end

% Plot the payoff diagram with the specified line styles and colors
figure;
plot(stock_range, long_call1_payoff, 'b', 'LineWidth', 0.75); hold on;
plot(stock_range, short_call_payoff, 'c', 'LineWidth', 0.75);
plot(stock_range, long_call2_payoff, 'r', 'LineWidth', 0.75);
plot(stock_range, total_payoff, 'k', 'LineWidth', 1.25);
xlabel('Stock Price at Expiration');
ylabel('Payoff');
title('Butterfly Spread Options Strategy Payoff Diagram');
legend('Long Call (K1)', 'Short Calls (2 x K2)', 'Long Call (K3)', 'Total Payoff');
grid on;
hold off;

% Display information
fprintf('Strike Prices: K1 = $%.2f, K2 = $%.2f, K3 = $%.2f\n', K1, K2, K3);
fprintf('Premiums: Long Call1 = $%.2f, Short Call (x2) = $%.2f, Long Call2 = $%.2f\n', premium_long_call1, premium_short_call, premium_long_call2);


%% Bull Call Spread

% MATLAB Script for Bull Call Spread Options Strategy Payoff Diagram

% Inputs: Modify these values to customize the strategy
stock_range = 50:0.1:150;   % Range of stock prices to evaluate at expiration
K1 = 90;                    % Strike price of the lower call (long call)
K2 = 110;                   % Strike price of the higher call (short call)
premium_long_call = 7;      % Premium of the lower strike long call
premium_short_call = 3;     % Premium of the higher strike short call

% Initialize payoff arrays
long_call_payoff = zeros(size(stock_range));
short_call_payoff = zeros(size(stock_range));
total_payoff = zeros(size(stock_range));

% Calculate payoffs
for i = 1:length(stock_range)
    S = stock_range(i);
    % Lower Strike Long Call Payoff
    long_call_payoff(i) = max(S - K1, 0) - premium_long_call;
    % Higher Strike Short Call Payoff
    short_call_payoff(i) = premium_short_call - max(S - K2, 0);
    
    % Total Payoff
    total_payoff(i) = long_call_payoff(i) + short_call_payoff(i);
end

% Plot the payoff diagram with the specified line styles and colors
figure;
plot(stock_range, long_call_payoff, 'b', 'LineWidth', 0.75); hold on;
plot(stock_range, short_call_payoff, 'r', 'LineWidth', 0.75);
plot(stock_range, total_payoff, 'k', 'LineWidth', 1.25);
xlabel('Stock Price at Expiration');
ylabel('Payoff');
title('Bull Call Spread Options Strategy Payoff Diagram');
legend('Long Call (K1)', 'Short Call (K2)', 'Total Payoff');
hold off;

% Grid off for this plot
grid off;

% Display information
fprintf('Strike Prices: K1 = $%.2f, K2 = $%.2f\n', K1, K2);
fprintf('Premiums: Long Call = $%.2f, Short Call = $%.2f\n', premium_long_call, premium_short_call);




