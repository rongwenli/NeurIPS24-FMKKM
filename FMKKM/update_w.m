function w = update_w(err, t)
if ~exist('t', 'var')
    t = 0.5;
end

s = max(err,eps).^(1/(t-1));
w = s./(sum(s.^t).^(1/t));
end