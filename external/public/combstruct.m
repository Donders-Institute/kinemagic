function S = combstruct(Sa,Sb)
% S = COMBSTRUCT(Sa,Sb)
% combine structures: S = Sa, but all (sub)fields of Sb are added to Sa. If
% the same fields are present, the Sb fields overwrite those of Sa.

% return quickly
if nargin < 1,  S = struct; return; end

% base new structure (S) on first input (Sa)
S = Sa;
if nargin < 2,	return;	end

% copy fields from Sb to S (overwriting existing fields)
fn = fieldnames(Sb);
for f = 1:length(fn)
    
    % loop over the elements of Sa and Sb
    for i = 1:max(length(S),length(Sb))
        %if length(Sb) < i,  continue;   end
        if length(Sb) < i
            S = S(1:i-1);
            break
        end
        
        % if the fields are also structures, call combstruct iteratively
        if length(S) >= i && isfield(S(i),fn{f}) && isstruct(S(i).(fn{f})) && isstruct(Sb(i).(fn{f}))
            S(i).(fn{f}) = combstruct(S(i).(fn{f}),Sb(i).(fn{f}));
            
        % otherwise overwrite the Sa field with the Sb field
        else
            S(i).(fn{f}) = Sb(i).(fn{f});
        end
    end    
    
end

