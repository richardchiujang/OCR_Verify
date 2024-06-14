REM Usage: test_run.bat dbn_model_path crnn_checkpoint by batch_run.py
call C:\anaconda3\Scripts\activate.bat C:\anaconda3
call conda activate hch_ocr
cd C:\develop\hch_ocr
python hch_ocr.py --drc_checkpoint_path %1 --dbn_model_path %2 --crnn_checkpoint %3 --no-ocrdebug --drc_flag --crnn_mode "inference" --no-crnn_return --log_level "info" --device "cpu"

@REM @ping 127.0.0.1 -n 1 -w 1000 > nul
@REM cd C:\develop\OCR_Verify
@REM Powershell.exe -ExecutionPolicy Bypass -File C:\develop\OCR_Verify\compare.ps1

@REM options:
@REM   -h, --help            show this help message and exit
@REM   --drc_config_file DRC_CONFIG_FILE
@REM                         drcmodel config file path
@REM   --drc_checkpoint_path DRC_CHECKPOINT_PATH
@REM                         drcmodel wehight file path
@REM   --drc_flag, --no-drc_flag
@REM                         document direction drcmodel enable or disable (default: False)
@REM   --drc_input_folder DRC_INPUT_FOLDER
@REM                         assign img folder path for input path default is work/input
@REM   --dbn_model_path DBN_MODEL_PATH
@REM                         dbnmodel wehight path
@REM   --dbn_output_folder DBN_OUTPUT_FOLDER
@REM                         img path for ocr result output default is work/output/inference
@REM   --thre THRE           the threshould of dbn post_processing
@REM   --polygon, --no-polygon
@REM                         output polygon(not work this version) (default: False)
@REM   --show, --no-show     show result on screen (default: False)
@REM   --crnn_cfg CRNN_CFG   crnn config file path
@REM   --crnn_checkpoint CRNN_CHECKPOINT
@REM                         crnn weight path
@REM   --crnn_output_folder CRNN_OUTPUT_FOLDER
@REM                         redirect the path for crnn output, this is ocr result. default is work/output/ocr_result
@REM   --crnn_mode CRNN_MODE
@REM                         None or 'inference'(default) if inference mode then enable crnn_output_folder parameter and disable purge_debug_folder
@REM   --device DEVICE       'cuda:0' or 'cuda' or 'cpu'(default)
@REM   --ocrdebug, --no-ocrdebug
@REM                         debug mode True, this will enable purge image and log file in work/output (default: True)
@REM   --crnn_return, --no-crnn_return
@REM                         return result mode True (default: True)
@REM   --log_level LOG_LEVEL
@REM                         log level 'debug' or 'info'(default)
@REM   --while_mode, --no-while_mode
@REM                         batch mode waiting data in a loop (default: False)