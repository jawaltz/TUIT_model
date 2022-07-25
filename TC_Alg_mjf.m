

function [RTpred misc1 misc2]=TC_Alg(Response,Reward, Params, avg_RT, cond);

global Vstart
global Go NoGo
NumTrls_TrlType = length(Response);
RTpred = Response(1)*ones(1,1); % can't predict first choice due to learning so just set it to actual sub RT
V = Vstart;
misc = 0;
joint_ent=1.0;

lambda = Params(1);
explore = Params(2);
alpha1 =  Params(3);
alpha2 = Params(4);
alphaV =  0.1; % Params(7); %0.1
K = Params(5);
scale = Params(6);
decay = 1; % scale; % decay counts for beta distribution 1= nodecay
exp_alt = Params(7); % param for alternative exp models of rt swings
meandiff = Params(8); % can use this to predict rt's as function of difference between fast/slow distributions
 
vars=3000; varf =3000; % initial variances of fast/slow resps for kalman filter
vars=(std(Reward))^2; varf =(std(Reward))^2; % initial variances of fast/slow resps for kalman filter

var = 10000; % this for initializing variance if using kalman filter for learning V (critic)
%mean_s = V; mean_f = V;
mean_s = 0; mean_f = 0;
 

%% alpha1*alphaK for pos Pe's and alpha2 for neg Pe's - instead of go/nogo... (w/ rtbest) works well for d32 not quite d2 (but close)
%  7.3289
 
% go/nogo + kalman works with and without rtbest (except d2 w/out p=.07)

 Noise=0;
dist_type = 'beta'; asym_kalman =0; % instead of go/nogo use asymmetrical learning rates modulating kalman gain


% GENERATIVE model
 global generative;
if (generative ==1)
lambda = 0.2;
explore = 3000;
alpha1 = .3;
alpha2 = .3;
K = 1500;
exp_alt =500;
scale = .25;
meandiff = 1000;
if dist_type == 'Gauss'
    meandiff=20;
    explore = 10;
end
Noise=2000;
end

exp=0;exp1=0; exp1a=0;lose_switch=0; regress=0;
RT_avg = avg_RT; % set avg on first trial..

alph_long=1.01; b_long=1.01; % init counters and beta distribution hyperparams..
alph_short=1.01; b_short=1.01;
cnt_short=0; cnt_long=0;
cnt_speed=0; cnt_slow=0;

RT_new = Response(1); % just for init;
RT_last =  Response(1); % just for init
RT_last2 = Response(1); % just for init
RT_last3 = Response(1); % just for init
bestRT= K; % just for init

for (trial = 2:NumTrls_TrlType)
    lasttrial = trial-1;

    exp1_last = exp1; exp_last = exp; exp1a_last = exp1a;
      
     
    if(generative==1) % if generating responses make last rt the prev predicted rt
    
       if trial > 2 RT_last2= RT_last; end
        RT_last = RT_new;  
    else  
        
    RT_last = Response(lasttrial);     
    if trial > 2 RT_last2 = Response(trial-2); end
    if trial > 3 RT_last3 = Response(trial-3); end

    end
     
     
    mom = (RT_last - RT_last2); % momentum
    if mom==0 mom=1; end

    Rew_last = Reward(lasttrial); %^scale;  % can squash mag reps with exponential
    if (generative==1)
        Rew_last = RewFunction(RT_last, cond); % calculate reward if model generating own rt's
    end
    
    if RT_last>RT_last2   % Reverse-momentum model
        cnt_slow = cnt_slow +1; cnt_speed =0; % count number of responses slower than previous
    else
        cnt_speed = cnt_speed +1; cnt_slow =0;
    end

    V_last = V(lasttrial);
    V_new = V_last +alphaV*(Rew_last - V_last); % update critic value

     
    %   V_new = V_last + alphaK*(Rew_last - V_last); kalman filter update of V

    rew_max = max(Reward(1:lasttrial)); % max reward received in block thus far
    rew_std = std(Reward(1:lasttrial)); % stddev of rewards in block thus far

    if Rew_last >V_last && Rew_last>= (rew_max-rew_std) bestRT=RT_last; % save Rt corresponding to best reward
    end;

    Go_last = Go(lasttrial);
    NoGo_last = NoGo(lasttrial);
    Go_new = Go_last; NoGo_new = NoGo_last; %  unless updated below by PE

    if(Rew_last> V_last)

        Go_new = Go_last + alpha1*(Rew_last - V_last);

    elseif(Rew_last<=V_last)
        NoGo_new = NoGo_last +alpha2*(V_last - Rew_last);

    end

    if(RT_last> RT_avg) % last response was slow/long
        cnt_long = cnt_long +1; cnt_short =0; % for sutton exp bonus

        regress = -exp_alt;  % simple oscillation explore
 

      if strcmp(dist_type,'beta')
          
        if(Rew_last> V_last)

            alph_long = alph_long +1; % increment count for beta distribution

        else
            b_long = b_long+1;
            lose_switch = -exp_alt; % if was slow go fast after neg PE
        end

        alph_long=decay*alph_long; % if decay <1 then this decays counts, making beta dists less confident (Daw et al) but this not bayesian
        b_long=decay*b_long;
        alph_short=decay*alph_short;
        b_short=decay*b_short;

        % these are mode and variances of beta dists
        var_short = alph_short*b_short/(((alph_short+b_short)^2)*(alph_short+b_short+1));
        var_long = alph_long*b_long/(((alph_long+b_long)^2)*(alph_long+b_long+1));
        mode_long = (alph_long -1) / (alph_long + b_long -2);
        mode_short = (alph_short -1) / (alph_short + b_short -2);
        mean_long = (alph_long) / (alph_long + b_long);
        mean_short = (alph_short) / (alph_short + b_short);
 
        exp1 = - explore*(sqrt(var_short) - sqrt(var_long));  % speed up if more uncertain about fast responses
     
      elseif strcmp(dist_type,'Gauss')
        
        rewvar = (std(Reward))^2;
        alphaKs = vars/(vars+rewvar); % Kalman gain for slow responses
        vars = (1 - alphaKs)*vars; % Kalaman variance for slow resps
        
        
        if asym_kalman ==1
            if Rew_last>V_last
                mean_s = mean_s + alphaKs*alpha1*((Rew_last - V_last) - mean_s);
            else
                mean_s = mean_s + alphaKs*alpha2*((Rew_last - V_last) - mean_s);
            end

        else

            mean_s = mean_s + alphaKs*((Rew_last - V_last) - mean_s);
        end
       
        
        mean_long = mean_s; mean_short=mean_f;
        exp1 = - explore*(sqrt(varf) - sqrt(vars));  % using kalman filter gaussian distributions.

      end
         
        if RT_last<RT_last2   && exp1<0 exp1=0; %-exp1; % reset if already explored in this direction last trial (see supp)
        elseif RT_last>RT_last2   &&exp1>0 exp1=0; %-exp1;
        end;


    elseif (RT_last<= RT_avg)  % last resp was fast/short

        cnt_short = cnt_short +1; cnt_long =0; % for sutton exp bonus
 
        regress = +exp_alt; %  regress mean oscillation

      if strcmp(dist_type,'beta')
          
          if(Rew_last> V_last)
            alph_short = alph_short +1;
        else
            b_short = b_short +1;
            lose_switch =exp_alt; % if was fast, slow down after neg PE
        end
        alph_long=decay*alph_long;
        b_long=decay*b_long;
        alph_short=decay*alph_short;
        b_short=decay*b_short;

        % mode and variances of beta distribution
        var_short = alph_short*b_short/(((alph_short+b_short)^2)*(alph_short+b_short+1));
        var_long = alph_long*b_long/(((alph_long+b_long)^2)*(alph_long+b_long+1));
        mode_long = (alph_long -1) / (alph_long + b_long -2);
        mode_short = (alph_short -1) / (alph_short + b_short -2);
        mean_long = (alph_long) / (alph_long + b_long);
        mean_short = (alph_short) / (alph_short + b_short);

       

        exp1 = + explore*(sqrt(var_long) - sqrt(var_short));
      
      elseif strcmp(dist_type,'Gauss')
        
        rewvar = (std(Reward))^2;
        alphaKf = varf / (varf +rewvar);
        varf = (1 - alphaKf)*varf;
        
        
        if asym_kalman ==1

            if Rew_last>V_last
                mean_f = mean_f + alphaKf*alpha1*((Rew_last - V_last) - mean_f);
            else
                mean_f = mean_f + alphaKf*alpha2*((Rew_last - V_last) - mean_f);
            end

        else
            mean_f = mean_f + alphaKf*((Rew_last - V_last) - mean_f);

        end
        
        
        mean_short = mean_f;mean_long = mean_s;
        
         exp1 = + explore*(sqrt(vars) - sqrt(varf));  % using kalman filter normal distributions.
          end
          
          
        if RT_last<RT_last2   && exp1<0 exp1=0; %-exp1;  % reset if already explored in this direction last trial (see supp)
        elseif RT_last>RT_last2   && exp1>0 exp1=0; %-exp1;
        end;

    end;

    revmom=0;
    if cnt_speed > scale revmom=exp_alt*cnt_speed;
    elseif cnt_slow > scale revmom = -exp_alt*cnt_slow;
    end


    %% with kalman, explore still works + meandiff. but not quite d2.  
          % BUT - works if use kalman on size of PE rather than reward...
          
    % try with beta + mode_diff.. not quite d32.. 
         %add rtbest.. d2 works, d32 works... add explore, still pretty
         %good but d32 p=.07 
    
         
    
    exp = exp_alt*(sqrt(cnt_short)-sqrt(cnt_long)); % sutton exploration bonus

    %if explore >0 % only save uncertainties for subjects with positive explore param 
     %  exp1a = (sqrt(var_long) - sqrt(var_short));  % speed up if more uncertain about fast responses
   %end
    
   if strcmp(dist_type,'Gauss')
       if asym_kalman ==1 Go_new =0; NoGo_new=0;
       end
   end
  
    RT_new = K+ lambda*RT_last - Go_new + NoGo_new  +exp1 + meandiff*(mean_long-mean_short) + scale*(bestRT-avg_RT)+ Noise*(rand-0.5); %  + 0*lose_switch + 0*revmom  + 0*meandiff*(bestRT-avg_RT)  -0*exp_alt*mom + 0*exp;
    %  + 0*meandiff*(mean_s - mean_f) + meandiff*(mode_long-mode_short);  

    
    
    rtvar = (std(Response))^2;
    alphaK = var/(var+rtvar); % alphaK = kalman gain; 
    var = (1 - alphaK)*var;
    
  
    RT_avg = RT_avg +alphaV*(RT_last-RT_avg); %update average RT locally...

    RTpred = [RTpred; RT_new]; % add new RT pred to vector
    V = [V; V_new];
    Go = [Go; Go_new];
    NoGo = [NoGo; NoGo_new];


    % store misc variables (default: PE and explore, but can change to alph and beta for plotting evolving beta dists)
    misc1a = Rew_last - V_last; % alph_long
    misc2a =  exp1_last; % b_long
      
    misc1b=0; misc1c=0;
   if RT_last > RT_avg 
       if mean_short>mean_long
       misc1b=1; % last trial was exploratory
       misc1c=RT_last-RT_avg;   % extent of explore
       end
   else 
       if mean_short<mean_long
       misc1b=-1; % last trial was exploratory speed
       misc1c=RT_last-RT_avg;
       end
   end 
    
    if trial ==2
        misc1 =misc1a;
        misc2=misc2a;
    else
        misc1=[misc1;  misc1a];
        misc2=[misc2; misc2a];
    end

end

misc1b=0; misc1c=0;
   if Response(trial) > RT_avg 
       if mean_short>mean_long
       misc1b=1; % last trial was exploratory
       misc1c=Response(trial)-RT_avg;   
       end
   else 
       if mean_short<mean_long
       misc1b=-1; % last trial was exploratory speed
       misc1c=Response(trial)-RT_avg;
       end
   end
   
% after looping through trials add one last value for last trial to misc
 
misc1 = [misc1; Reward(trial) - V_new]; % alph_long;
misc2 = [misc2; exp1]; %b_long];

Vstart=  V_new;  % set V_start for next block.

Go = 0; %scale*Go_new*ones(1,1);
NoGo = 0; %scale*NoGo_new*ones(1,1);






