function y = SLS_relax_Funct_General_2_term_Set_Tau_20k_12h(p,t)
%SLSCreepFunct Defines the relax function for the SLS model
% Used for ME 287
A = p(1);
B = p(2);
tau_epsilon = 14330.56862;
C = p(3);
tau_epsilon_2 = p(4);

%Strain applied is 10%
strain = 0.1;

y = (A+B*exp(-t/(tau_epsilon))+C*exp(-t/tau_epsilon_2))*strain;
end