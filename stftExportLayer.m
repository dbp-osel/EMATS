classdef stftExportLayer < nnet.layer.Layer & nnet.layer.Formattable

properties
        % Layer properties.
        Fs;
        FFTLength;
        Window;
        OverlapLength;
        idxC
        idxB
        idxT
    end

    methods
        function layer = stftExportLayer(args)
            % layer = samplingLayer creates a sampling layer for VAEs.
            %
            % layer = samplingLayer(Name=name) also specifies the layer 
            % name.

            % Parse input arguments.
            arguments
                args.Name = "";
                args.Fs = 100;
                args.FFTLength = 256*2;
                args.Window = hann(240,'periodic');
                args.OverlapLength = 180;
            end

            % Layer properties.
            layer.Name = args.Name;
            layer.Type = "Export";
            layer.Description = "For exporting STFT";
            layer.OutputNames = ["real","imaginary"];
            layer.Fs = args.Fs;
            layer.FFTLength = args.FFTLength;
            layer.Window = args.Window;
            layer.OverlapLength = args.OverlapLength;
        end

        function layer = initialize(layer,layout)
            layer.idxC = finddim(layout,"C");
            layer.idxT = finddim(layout,"T");
            layer.idxB = finddim(layout,"B");
        end

        function [ZR,ZI] = predict(layer,X)
            % [Z,mu,logSigmaSq] = predict(~,Z) Forwards input data through
            % the layer at prediction and training time and output the
            % result.
            %
            % Inputs:
            %         X 
            % Outputs:
            %         ZR          - Real
            %         ZI          - Imaginary
            x = permute(extractdata(X),[layer.idxT,layer.idxC,layer.idxB]);
            Z = stft(x,layer.Fs,"FFTLength",layer.FFTLength,"Window",layer.Window,"OverlapLength",layer.OverlapLength,"FrequencyRange","onesided");
            ZR = real(Z);
            ZI = imag(Z);
            ZR = dlarray(ZR,"STCB");
            ZI = dlarray(ZI,"STCB");
        end

    end
    
end