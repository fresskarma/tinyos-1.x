function J = SumGammaCostFun(u)
% NEED TO ADD GRADIENT CALC
% J = cost(Ppos-Epos) + cost(u) - sum(gamma) with weights
% Input: u  nT*1 vector, n is the dimension of the control, h is the
%           control time horizon.  Stacked u's, [u(:,1); u(:,2); ...]
% Ouput: Value of the cost, J & g, the gradient
%
% Works with PpolicyNonLinOpt.

global P;
global Pctrlr;
global SN; % Placeholder for the Pursuer's estimate of the sensor network
global testT; % 0 means we are not testing, otherwise represents time.

if (~isempty(testT) && (testT ~= 0))
    Epos = Pctrlr.E(:,testT);
    Ppos = Pctrlr.measPos(:,testT);
else
    Epos = Pctrlr.E(:,end);
    Ppos = Pctrlr.measPos(:,end);
end
Gamma = [];
A_e = Pctrlr.Emodel.a;
A_p = Pctrlr.Pmodel.a;
B = Pctrlr.Pmodel.b;
for t = 1:Pctrlr.ph
    Epos(:,end+1) = A_e*Epos(:,end);
    if (t <= Pctrlr.ch)
        Ppos(:,end+1) = A_p*Ppos(:,end) + B*u(2*t-1:2*t);
    else
        Ppos(:,end+1) = A_p*Ppos(:,end);
    end
    % Gamma(t) = Pctrlr.gamma(Ppos(1:2,t),Epos(1:2,t)); % If precomputed

    x_p = Ppos(1,end);
    y_p = Ppos(2,end);
    x_e = Epos(1,end);
    y_e = Epos(2,end);
    
    % finding the closest node to the pursuer
    F =  - [x_p - SN.nodes(1,:); y_p - SN.nodes(2,:)];
    F(1,:) = F(1,:).*F(1,:);
    F(2,:) = F(2,:).*F(2,:);
    F = sqrt([1 1] * F);
    [r_minP closeNodeP] = min(F);
    % finding the closest node to the evader
    G = [x_e - SN.nodes(1,:); y_e - SN.nodes(2,:)];
    G(1,:) = G(1,:).*G(1,:);
    G(2,:) = G(2,:).*G(2,:);
    G = sqrt([1 1] * G);
    [r_minE closeNodeE] = min(G);
    % Calculate the probabilities
    p = SN.connProb(closeNodeP,closeNodeE); %autogenerated
    Rp = SN.nodes(4,closeNodeP); %comm radius
    if(r_minP < Rp)
        b = SN.nodes(6,closeNodeP);
        p_lastHop = b/(b+r_minP^SN.alphaR);
        Gamma(t) = p*(1-(1-p_lastHop^3)); %allow 3 retransmissions
    else 
        Gamma(t) = 0;
    end
%    Gamma(t) = p*max(0,Rp-r_minP)/Rp;%*(Re-r_minE)/Re;
end

J = -Pctrlr.gWt*sum(Gamma);
for t = 2:Pctrlr.ph+1 %recall that Epos has 2-dim length h+1
    x_diff = Epos(:,t) - Ppos(:,t);
    J = J + x_diff'*Pctrlr.xWt*x_diff;
end
J = J + u'*Pctrlr.uWt*u;

% IMPLEMENTATION NOTES:
% Evaluates the expected value for Gamma, the probability for receiving a
% packet, given a vector of control inputs u.
% Note that this function depends on the state of the Pursuer and the
% Estimated State of the Evader.
%
% Technically, we should compute Gamma by using NOT the closest node to the
% pursuer but the node with the best connectivity.  We'll fix this later.