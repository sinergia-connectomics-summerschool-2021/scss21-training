1. **When installing the VM I get the error code `E_INVALIDARG (0x80070057)` (Windows) / `VBOX_E_IPRT_ERROR (0x80BB0005)` (MacOSX)**: 
  
    This error is related to a lack of space in the disk. You should free some space (>70GB) before importing the Virtual Machine Image (`.ova` file). 

2. **I don’t have space in my laptop / PC. Can I install the VM in an SSD / Hard drive?**
  
    Yes, it won’t be the optimal solution in terms of speed, but it is possible. You will need to go to:

      `Virtual Machine` > `Preferences` > `Genera` > `Default Machine Folder`

    and change the location to be in the external drive. Make sure to delete the folder created by a failed import in the old “Default Machine Folder”. Otherwise you might get the same error as in **1)**. 

3. **One of the software crashes during execution.** 
  
    This is probably related to a lack of computational resources dedicated to the VM. You can try increasing them. We recommend setting them to **at least 12 GB of RAM** and the **maximum amount of cores available to the VM**. 

4. **How can I copy the Freesurfer license to the appropriate folder in the VM?**
  
    You need to first configure a shared folder before starting the VM. Then you will be able to transfer files back and forth from your computer to the VM. You can find the instructions on how to do this in [this section](https://sinergia-connectomics-summerschool-2021.github.io/scss21-training/#shared_folder_vm) of the tutorial materials. 

5. **How should I access the presentations and tutorials? Via Zoom or GatherTown?**
  
    The best way is by using the Auditorium link in GatherTown. In this way, others would know that you are around in the virtual space of the summerschool and will be able to interact with you. This would also make the task of going back and forth from GatherTown to Zoom easier. But anyone is free to access directly from Zoom. Be aware that interactions with the speakers during the breaks will only be possible in GatherTown. 

6. **Where should I ask my questions to be considered during the lecture and tutorial sessions?**
  
    You should ask your questions in the two following Slack channels dedicated to the lectures and tutorials separately on the summerschool Slack workspace:
    
      - [\#questions-lectures](https://braindynamics-qjs9104.slack.com/archives/C02H78MM0LC)
      - [\#questions-tutorials](https://braindynamics-qjs9104.slack.com/archives/C02GQC15XBR)
  
    If you haven’t joined the Slack workspace yet, you can join it [here](https://join.slack.com/t/braindynamics-qjs9104/shared_invite/zt-wgvofbw6-tdV0JgGKjt_eRrIhfoU7ug)!
    
