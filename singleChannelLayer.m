classdef singleChannelLayer < nnet.layer.Layer & nnet.layer.Formattable & nnet.layer.Acceleratable % (Optional)

    properties
        % (Optional) Layer properties.

        ChannelNum;
    end

    properties (Learnable)
        % (Optional) Layer learnable parameters.

        % Declare learnable parameters here.
    end

    properties (State)
        % (Optional) Layer state parameters.

        % Declare state parameters here.
    end

    properties (Learnable, State)
        % (Optional) Nested dlnetwork objects with both learnable
        % parameters and state parameters.

        % Declare nested networks with learnable and state parameters here.
    end

    methods
        function layer = singleChannelLayer(channelNum,args)
            % (Optional) Create a myLayer.
            % This function must have the same name as the class.

            arguments
                channelNum
                args.name = '';
            end
            name = args.name;

            layer.Name = name;
            layer.ChannelNum = channelNum;
            layer.Description = "Remove all but channel " + num2str(channelNum);
            layer.Type = "All to One";

        end


%         function layer = initialize(layer,layout)
%             % (Optional) Initialize layer learnable and state parameters.
%             %
%             % Inputs:
%             %         layer  - Layer to initialize
%             %         layout - Data layout, specified as a networkDataLayout
%             %                  object
%             %
%             % Outputs:
%             %         layer - Initialized layer
%             %
%             %  - For layers with multiple inputs, replace layout with 
%             %    layout1,...,layoutN, where N is the number of inputs.
%             
%             % Define layer initialization function here.
%         end
        

        function Z = predict(layer,X)
            % Forward input data through the layer at prediction time and
            % output the result and updated state.
            %
            idx = finddim(X,"C");
            if length(size(X))==3
                switch idx
                    case 1
                        Z = X(layer.ChannelNum,:,:);
                    case 2
                        Z = X(:,layer.ChannelNum,:);
                    case 3
                        Z = X(:,:,layer.ChannelNum);
                end
            elseif length(size(X))==4
                switch idx
                    case 1
                        Z = X(layer.ChannelNum,:,:,:);
                    case 2
                        Z = X(:,layer.ChannelNum,:,:);
                    case 3
                        Z = X(:,:,layer.ChannelNum,:);
                    case 4
                        Z = X(:,:,:,layer.ChannelNum);
                end
            end
        end

        

%         function layer = resetState(layer)
%             % (Optional) Reset layer state.
% 
%             % Define reset state function here.
%         end
% 
%         function [dLdX,dLdW,dLdSin] = backward(layer,X,Z,dLdZ,dLdSout,memory)
%             % (Optional) Backward propagate the derivative of the loss
%             % function through the layer.
%             %
%             % Inputs:
%             %         layer   - Layer to backward propagate through 
%             %         X       - Layer input data 
%             %         Z       - Layer output data 
%             %         dLdZ    - Derivative of loss with respect to layer 
%             %                   output
%             %         dLdSout - (Optional) Derivative of loss with respect 
%             %                   to state output
%             %         memory  - Memory value from forward function
%             % Outputs:
%             %         dLdX   - Derivative of loss with respect to layer input
%             %         dLdW   - (Optional) Derivative of loss with respect to
%             %                  learnable parameter 
%             %         dLdSin - (Optional) Derivative of loss with respect to 
%             %                  state input
%             %
%             %  - For layers with state parameters, the backward syntax must
%             %    include both dLdSout and dLdSin, or neither.
%             %  - For layers with multiple inputs, replace X and dLdX with
%             %    X1,...,XN and dLdX1,...,dLdXN, respectively, where N is
%             %    the number of inputs.
%             %  - For layers with multiple outputs, replace Z and dlZ with
%             %    Z1,...,ZM and dLdZ,...,dLdZM, respectively, where M is the
%             %    number of outputs.
%             %  - For layers with multiple learnable parameters, replace 
%             %    dLdW with dLdW1,...,dLdWP, where P is the number of 
%             %    learnable parameters.
%             %  - For layers with multiple state parameters, replace dLdSin
%             %    and dLdSout with dLdSin1,...,dLdSinK and 
%             %    dLdSout1,...,dldSoutK, respectively, where K is the number
%             %    of state parameters.
% 
%             % Define layer backward function here.
%         end
    end
end