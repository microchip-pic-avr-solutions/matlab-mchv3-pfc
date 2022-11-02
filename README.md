![image](images/microchip.png) 
# Demonstration Readme for Mathematical Model of Single-Stage Boost Power Factor Correction Converter using MATLAB and Simulink

## 1. INTRODUCTION
The design of switched-mode power supply (SMPS) for different power applications is a significant concern in industries. The quality of the power consumed should be taken care of during the design, which demands a near unity power factor (PF) to be maintained. Applying a power factor correction(PFC) converter is one of the methods of improving the power quality, and it has become an essential part of power supplies and drives. Controllers are required along with the converter to achieve good PF. The compensator design is the major issue in the implementation of PFC. This work mainly discusses the design for a Single Stage Boost PFC converter. A mathematical model is also developed by using MATLAB software.

## 2.	SUGGESTED DEMONSTRATION REQUIREMENTS
### 2.1 MATLAB Model Required for the Demonstration
-  MATLAB model can be cloned or downloaded as zip file from the Github repository ([link](https://github.com/microchip-pic-avr-solutions/matlab-mchv3-pfc)).

### 2.2	Software Tools Used for Testing the MATLAB/Simulink Model
1.	MATLAB R2022a

> **NOTE:**</br>
>The software used for testing the model during release is listed above. It is recommended to use the version listed above or later versions for building the model.

### 2.3	Hardware Tools Required for the Demonstration
- dsPICDEM™ MCHV-3 Development Board [DM330023-3](https://www.microchip.com/en-us/development-tool/dm330023-3)

> **NOTE:**</br>
>In this document, hereinafter High-Voltage Motor Control Development Board selected for setting up the demonstration is referred as Development Board. 

> **NOTE:**</br>
>All items listed under this section Hardware Tools Required for the Demonstration are available at [microchip DIRECT](https://www.microchipdirect.com/).



## 3.	BASIC DEMONSTRATION
Follow the below instructions step-by-step, to set up and run the PFC demo application:

1. Launch MATLAB (refer the section [“2.2 Sofware Tools Used for Testing the MATLAB/Simulink Model"](#22-software-tools-used-for-testing-the-matlabsimulink-model)).
2. Open the folder downloaded from the repository, in which MATLAB files are saved (refer the section ["2.1 MATLAB Model Required for the Demonstration"](#21-matlab-model-required-for-the-demonstration)).

    <p align="left" >
    <img  src="images/dem1.png"></p>

3. Double click and open the .m file. This .m file contains the configuration parameters required for running the PFC.Run the file by clicking the **Run** icon and wait till all variables gets loaded on the **Workspace** tab.

    <p align="left">
      <img  src="images/dem2.png"></p>
    </p>

4. Double click on the PFC Simulink model.

    <p align="left">
      <img  src="images/dem3.png">

5. This opens the Simulink model as shown below. Click on the **Run** icon to start the simulation.

    <p align="left">
      <img  src="images/dem4.png">

6. Simulink Scope is used to plot the signals.

    <p align="left">
      <img  src="images/dem5.png">

    <p align="left">
      <img  src="images/dem8.png"> 

    <p align="left">
      <img  src="images/dem9.png">   

7. Variable load is configured in the model to see the dynamic perfomance of the system where the load can be varied by using a manual switch.

    <p align="left">
      <img  src="images/dem6.png">

8. Similarly, the variation with respect to the input voltage is also incorporated in the model where input voltage can be varied by using a manual switch.
    <p align="left">
      <img  src="images/dem7.png">


REFERENCES
