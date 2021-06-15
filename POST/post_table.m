model='BGM';

if (strcmp(model,'BGM'))
  load(strcat('FIG/',model,'_EUL_AMM52/output_LR'))
  for pp=1:2

    fprintf(strcat('forecast rmse\t', forecast(pp).res, ':\t', num2str(mean(forecast(pp).rmse(2:41)),3), '\n'))
    fprintf(strcat('analysis rmse\t', forecast(pp).res, ':\t', num2str(mean(analysis(pp).rmse(1:41)),3), '\n'))
    fprintf(strcat('forecast sdev\t', forecast(pp).res, ':\t', num2str(mean(forecast(pp).sdev(2:41)),3), '\n'))
    fprintf(strcat('analysis sdev\t', forecast(pp).res, ':\t', num2str(mean(analysis(pp).sdev(1:41)),3), '\n'))
  end
end

if (strcmp(model,'KSM'))
  load(strcat('FIG/',model,'_EUL_AMM32/output_LR'))
  for pp=1:2
    fprintf(strcat('forecast rmse\t', forecast(pp).res, ':\t', num2str(mean(forecast(pp).rmse(21:101)),3), '\n'))
    fprintf(strcat('analysis rmse\t', forecast(pp).res, ':\t', num2str(mean(analysis(pp).rmse(21:101)),3), '\n'))
    fprintf(strcat('forecast sdev\t', forecast(pp).res, ':\t', num2str(mean(forecast(pp).sdev(21:101)),3), '\n'))
    fprintf(strcat('analysis sdev\t', forecast(pp).res, ':\t', num2str(mean(analysis(pp).sdev(21:101)),3), '\n'))
  end
end
