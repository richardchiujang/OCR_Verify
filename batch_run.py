import os, glob, time, datetime
drc_wt_list = glob.glob(r'C:\develop\doc_rotate_classification\output\*.pth')
dbn_wt_list = glob.glob(r'C:\develop\DBNet_pytorch_Wenmu\output\DBNet_resnet18_FPN_DBHead\checkpoint\*.pth')
crnn_wt_list = glob.glob(r'C:\develop\CRNN_Chinese_Characters_Rec\output\360CC\checkpoints\*.pth')

print(drc_wt_list[0], len(drc_wt_list), '\n', dbn_wt_list[0], len(dbn_wt_list), '\n', crnn_wt_list[0], len(crnn_wt_list))

# best model weights 
drc_checkpoint = r'C:\develop\doc_rotate_classification\output\model.pth'
dbn_checkpoint = r'C:\develop\DBNet_pytorch_Wenmu\output\DBNet_resnet18_FPN_DBHead\checkpoint\model_best_e46_h0.9149915183758589_l0.6437240391969681.pth'      
crnn_checkpoint = r'C:\develop\CRNN_Chinese_Characters_Rec\output\360CC\checkpoints\checkpoint_96_acc_0.9420_0.000034300.pth'

for drc_checkpoint in drc_wt_list[:]:
# for dbn_checkpoint in dbn_wt_list[:]:
# for crnn_checkpoint in crnn_wt_list[:]:
    open('log.txt', 'a').write(f'{datetime.datetime.fromtimestamp(time.time()).strftime("%Y-%m-%d %H:%M:%S")}\n')
    os.system(f'test_run.bat "{drc_checkpoint}" "{dbn_checkpoint}" "{crnn_checkpoint}"')
    time.sleep(1)
    # open('log.txt', 'a').write(f'{datetime.datetime.fromtimestamp(time.time()).strftime("%Y-%m-%d %H:%M:%S")}')
    open('log.txt', 'a').write(f'{drc_checkpoint}\n{dbn_checkpoint}\n{crnn_checkpoint}\n')
    os.system('Powershell.exe -ExecutionPolicy Bypass -File C:\develop\OCR_Verify\compare_short.ps1 >> log.txt')
    # open('log.txt', 'a').write(f'{dbn_wt} {crnn_checkpoint}\n')
    print(f'{drc_checkpoint} {dbn_checkpoint} {crnn_checkpoint} Done')


# dbn_checkpoint = r'C:\develop\hch_ocr\weights\model_best_recall0940255_precision0967293_hmean0953583_train_loss0673593_best_model_epoch23.pth'      
# crnn_checkpoint = r'C:\develop\hch_ocr\weights\checkpoint_88_acc_0.9387_0.000006887.pth'

# open('log.txt', 'a').write(f'{datetime.datetime.fromtimestamp(time.time()).strftime("%Y-%m-%d %H:%M:%S")}\n')
# os.system(f'test_run.bat {dbn_checkpoint} {crnn_checkpoint}')
# time.sleep(1)
# # open('log.txt', 'a').write(f'{datetime.datetime.fromtimestamp(time.time()).strftime("%Y-%m-%d %H:%M:%S")}')
# open('log.txt', 'a').write(f'{dbn_checkpoint} {crnn_checkpoint}\n')
# os.system('Powershell.exe -ExecutionPolicy Bypass -File C:\develop\OCR_Verify\compare_short.ps1 >> log.txt')
# # open('log.txt', 'a').write(f'{dbn_wt} {crnn_checkpoint}\n')
# print(f' {dbn_checkpoint} {crnn_checkpoint} Done')
