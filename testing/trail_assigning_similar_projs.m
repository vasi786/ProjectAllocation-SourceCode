clc;clear


a = [7 7 10 10 10 15 1 1 15 15 7 16 17 1 18]';
a = sort(a);
[ii,jj,kk]=unique(a);
repeated=ii(histc(kk,1:numel(ii))>1);


k = 1;

while true
    for i = 1: length(a)
        for j = i:length(a)
            if repeated(k) == a(j)
                a(j,2) = k;
            end
            
        end
    end
    k = k + 1;
    
    if k > length(repeated)
        break
    end
end

a

