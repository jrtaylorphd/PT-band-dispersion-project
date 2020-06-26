
function STR = fstring(X);

STR  = num2str(X,4);
ind  = find(STR=='.');
STR  = strcat(STR(1:ind-1),'_',STR(ind+1:length(STR)));
if isempty(ind)
  STR = num2str(X);
end
