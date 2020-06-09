function X = test_julia_data
%% Cost to pre-order Pokemon: Shield
p  = 59.99; % Listed price
rc = 25.00; % Rewards certificate
gc = 0.20;  % Gamer's Club discount
bb = 0.05;  % Best Buy card discount

[gclub , pp] = computeDiscount(p, gc);
[bbuy , pp]  = computeDiscount(pp, bb);
pp           = pp - rc;

msg = sprintf('So you want to buy Pokemon Shield, eh? Let'' see if you have what it takes.\nWinston, RUN THE NUMBERS!');
fprintf('\n%s\nListed price: $%.02f\nReward Certificate: $%.02f\nGamer''Club Discount: $%.02f\nVisa Card Discount: $%.02f\nTotal cost: $%.02f\nTotal Savings: $%.02f (!!!)\n', ...
    msg, p, rc, gclub, bbuy, pp, rc + gclub + bbuy);

DOL2YEN = 109;
ppp     = pp * DOL2YEN;

msg = sprintf('So you want to buy Pokemon Shield, arigato? Let'' see if you have what it takes.\nVegeta, KAMEHAMEHA!');
fprintf('\n%s\nListed price: %.02f yen\nReward Certificate: %.02f yen\nGamer''Club Discount: %.02f yen\nVisa Card Discount: %.02f yen\nTotal cost: %.02f yen\nTotal Savings: %.02f  yen (!!!)\n', ...
    msg, p*DOL2YEN, rc*DOL2YEN, gclub*DOL2YEN, bbuy*DOL2YEN, pp*DOL2YEN, (rc + gclub + bbuy)*DOL2YEN);

% pp = ((p - (p * gc)) - ((p - (p * gc)) * bb)) - rc;

end

function [s , t] = computeDiscount(p, d)
% p: listed price
% d: discount (in decimals)
% s: amount saved
% t: new total cost

s = p * d;
t = p - s;

end

