# Get the x axis values around val
function x = computeXaxis(pivot)
    i = 0
    val = floor(pivot/10)
    while (val > 0)
        val = floor(val/10)
        i++
    endwhile
    step_scale = i
    step = 10 ** step_scale
    step = step / 10
    printf("Step will be: %d\n", step)
    ut = pivot * 1.5
    lt = pivot * 0.5
    x = lt:step:ut
endfunction

function y = getOptionProfit(n, x, strikePrice, p, premium)
    if (nargin != 5)
        usage ("getOptionProfit(n, x, strikePrice, p, premium)")
    endif
    y = n*(x-strikePrice)*p;
    for i = 1:length(y)
        ro = 1
        if (y(i) < 0)
            ro = 0
        endif
        y(i) = y(i) * ro - n * premium;
    endfor
    y
endfunction

function z = getStockProfit(N, x, entryPrice)
    if (nargin != 3)
        usage ("getStockProfit(N, x, entryPrice)")
    endif
    z = N * (x - entryPrice);
endfunction

# pivot - the value we want to graph around.
# n - number of stocks we own.
# N - number of options we own.
# Epsilon - option strike price.
# Ep - stock entry price
# p - leverage (>0 for calls, < 0 for puts)
function plotYZgraph(pivot, N, Ep, n, Epsilon, p, premium)
    if (nargin != 7)
        usage ("plotYZgraph(pivot, N, Ep, n, Epsilon, p, premium)")
    endif

    x = computeXaxis(pivot)

    figure(1, 'position',[800,600,1200,800])
    subplot (3, 1, 1)
    y = getOptionProfit(n, x, Epsilon, p, premium)
    plot (x, y)
    xlabel ("Stock Price");
    ylabel ("Option Profit ");

    subplot (3, 1, 2)
    z = getStockProfit(N, x, Ep)
    plot (x, z)
    xlabel ("Stock Price");
    ylabel ("Stock Profit ");

    yz = y + z;

    subplot (3, 1, 3)
    plot (x, yz)
    xlabel ("Stock Price");
    ylabel ("Stock - Option Profit ");

    pause(3600)
endfunction
