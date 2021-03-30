function varargout = linPF1(Operation,Global,input)
% <problem> <linPF>
% Scalable Test Problems for Evolutionary Multi-Objective Optimization
% operator --- EAreal

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    switch Operation
        %% Initialize the parameter setting, and randomly generate a population
        case 'init'
            % Set the default number of objectives
            Global.M        = 3;
            % Set the default number of decision variables
            Global.D        = Global.M + 9;
            % Set the lower bound of each decision variable
            Global.lower    = zeros(1,Global.D);
            % Set the upper bound of each decision variable
            Global.upper    = ones(1,Global.D);
            % Set the default operator for this problem
            Global.operator = @EAreal;
            % Randomly generate a number of solutions' decision variables
            PopDec    = rand(input,Global.D);
            % Return the set of decision variables
            varargout = {PopDec};
        %% Calculate the objective values of a population
        case 'value'
            % The set of decision variables
            PopDec = input;
            % The number of objectives
            M      = Global.M;
            N = size(PopDec,1);
            % Calculate the objective values according to the decision
            % variables, note that here the objective values of multiple
            % solutions are calculated at the same time
            
            centre=ones(1,M)/M;
            
            x=[0.2*PopDec(:,1)+0.8,PopDec(:,2:M-1)*pi/2+pi/4];       
            g      = (1+sin(pi*x(:,1)/2)).*sum((PopDec(:,M:end)-sin(pi*x(:,1)/2)).^2,2);
     
            f=zeros(N,M);
            f(:,1)=1-x(:,1).*(cos(x(:,2)));
            for i=2:M-1
                f(:,i)=i+x(:,1).*(cos(x(:,2))-sum(sin(x(:,2:i-1).^2),2)+sin(x(:,i).^2));
            end
            f(:,end)=M+x(:,1).*(cos(x(:,2))-sum(sin(x(:,2:M-1).^2),2));
            
            PopObj =repmat(1+g,1,M).*(centre + f);
            % Calculate the constraint values
            PopCon = [];
            % Return the decision variables, objective values, and
            % constraint values
            varargout = {input,PopObj,PopCon};
        %% Generate reference points on the true Pareto front
        case 'PF'
            % Generate a set of reference points on the true Pareto front
            N=10000;
            h=N^(1/Global.M);
            if Global.M==3
                p=ones(1,3)/3;
                [x,y]=meshgrid(linspace(0,1,ceil(h)));
                y=y*pi/2+pi/4;
                x=0.2*x+0.8;
                f3=(p(1)+x.*cos(y)-x.*sin(y.^2)+3);
                f2=(p(2)+x.*cos(y)+x.*sin(y.^2)+2);
                f1=(p(3)-x.*cos(y)+1);
                f=[reshape(f1,[],1), reshape(f2,[],1),reshape(f3,[],1)];
            end
            % Return the reference points
            varargout = {f};
    end
end