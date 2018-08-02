EESchema Schematic File Version 4
LIBS:motion_light-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L crumpschemes:APA102 U2
U 1 1 59B43E23
P 9200 1100
F 0 "U2" H 9000 1400 60  0000 C CNN
F 1 "APA102" H 9100 800 60  0000 C CNN
F 2 "CrumpPrints:APA102_hand_solder" H 9200 650 60  0001 C CNN
F 3 "" H 9200 650 60  0001 C CNN
F 4 "-" H 0   0   50  0001 C CNN "MFR"
F 5 "APA102C" H 0   0   50  0001 C CNN "MPN"
F 6 "Ali Express" H 0   0   50  0001 C CNN "SPR"
F 7 "-" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    9200 1100
	1    0    0    -1  
$EndComp
$Comp
L crumpschemes:APA102 U3
U 1 1 59B43E3A
P 10450 1100
F 0 "U3" H 10250 1400 60  0000 C CNN
F 1 "APA102" H 10350 800 60  0000 C CNN
F 2 "CrumpPrints:APA102_hand_solder" H 10450 650 60  0001 C CNN
F 3 "" H 10450 650 60  0001 C CNN
F 4 "-" H 0   0   50  0001 C CNN "MFR"
F 5 "APA102C" H 0   0   50  0001 C CNN "MPN"
F 6 "Ali Express" H 0   0   50  0001 C CNN "SPR"
F 7 "-" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    10450 1100
	1    0    0    -1  
$EndComp
$Comp
L MCU_Microchip_ATtiny:ATtiny84A-SSU U1
U 1 1 59B43E7D
P 10000 2800
F 0 "U1" H 9150 3550 50  0000 C CNN
F 1 "ATTINY84A-SSU" H 10000 2800 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 10000 2600 50  0001 C CIN
F 3 "http://www.microchip.com/mymicrochip/filehandler.aspx?ddocname=en590190" H 10000 2800 50  0001 C CNN
F 4 "Microchip Technology" H 450 200 50  0001 C CNN "MFR"
F 5 "ATTINY84A-SSUR" H 450 200 50  0001 C CNN "MPN"
F 6 "Digikey" H 450 200 50  0001 C CNN "SPR"
F 7 "ATTINY84A-SSURCT-ND" H 450 200 50  0001 C CNN "SPN"
F 8 "-" H 450 200 50  0001 C CNN "SPURL"
	1    10000 2800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 59B43FA0
P 5650 750
F 0 "SW1" H 5700 850 50  0000 L CNN
F 1 "SW_Push" H 5600 650 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_SPST_Angled_PTS645Vx83-2LFS" H 5650 950 50  0001 C CNN
F 3 "http://www.ckswitches.com/media/1471/pts645.pdf" H 5650 950 50  0001 C CNN
F 4 "C&K" H 0   0   50  0001 C CNN "MFR"
F 5 "PTS645VL83-2 LFS" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "CKN9123-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    5650 750 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 59B440F3
P 5850 750
F 0 "#PWR01" H 5850 500 50  0001 C CNN
F 1 "GND" H 5850 600 50  0000 C CNN
F 2 "" H 5850 750 50  0001 C CNN
F 3 "" H 5850 750 50  0001 C CNN
	1    5850 750 
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J1
U 1 1 59B442E7
P 7450 1050
F 0 "J1" H 7450 1250 50  0000 C CNN
F 1 "MOTION" V 7550 1050 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Horizontal" H 7450 1050 50  0001 C CNN
F 3 "https://media.digikey.com/PDF/Data%20Sheets/Sullins%20PDFs/xRxCzzzSxxN-M71RC_11637-B.pdf" H 7450 1050 50  0001 C CNN
F 4 "Sullins Connector Solutions" H 0   0   50  0001 C CNN "MFR"
F 5 "PRPC040SBAN-M71RC" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "S1111EC-40-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    7450 1050
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR02
U 1 1 59B443A5
P 10000 1900
F 0 "#PWR02" H 10000 1750 50  0001 C CNN
F 1 "VCC" H 10000 2050 50  0000 C CNN
F 2 "" H 10000 1900 50  0001 C CNN
F 3 "" H 10000 1900 50  0001 C CNN
	1    10000 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 59B443C3
P 10000 3700
F 0 "#PWR03" H 10000 3450 50  0001 C CNN
F 1 "GND" H 10000 3550 50  0000 C CNN
F 2 "" H 10000 3700 50  0001 C CNN
F 3 "" H 10000 3700 50  0001 C CNN
	1    10000 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 59B44548
P 7750 1250
F 0 "#PWR04" H 7750 1000 50  0001 C CNN
F 1 "GND" H 7750 1100 50  0000 C CNN
F 2 "" H 7750 1250 50  0001 C CNN
F 3 "" H 7750 1250 50  0001 C CNN
	1    7750 1250
	1    0    0    -1  
$EndComp
$Comp
L Connector:AVR-ISP-6 CON1
U 1 1 59B44627
P 7200 2850
F 0 "CON1" H 7150 2900 50  0000 C CNN
F 1 "AVR-ISP-6" H 6935 2620 50  0000 L BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" V 6680 2890 50  0001 C CNN
F 3 "" H 7175 2850 50  0001 C CNN
F 4 "Harwin Inc." H -300 250 50  0001 C CNN "MFR"
F 5 "M20-9980345" H -300 250 50  0001 C CNN "MPN"
F 6 "Digikey" H -300 250 50  0001 C CNN "SPR"
F 7 "952-2120-ND" H -300 250 50  0001 C CNN "SPN"
F 8 "-" H -300 250 50  0001 C CNN "SPURL"
	1    7200 2850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR05
U 1 1 59B44758
P 7100 2350
F 0 "#PWR05" H 7100 2200 50  0001 C CNN
F 1 "VCC" H 7100 2500 50  0000 C CNN
F 2 "" H 7100 2350 50  0001 C CNN
F 3 "" H 7100 2350 50  0001 C CNN
	1    7100 2350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 59B44778
P 7100 3250
F 0 "#PWR06" H 7100 3000 50  0001 C CNN
F 1 "GND" H 7100 3100 50  0000 C CNN
F 2 "" H 7100 3250 50  0001 C CNN
F 3 "" H 7100 3250 50  0001 C CNN
	1    7100 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery BT1
U 1 1 59B46A94
P 4550 1050
F 0 "BT1" H 4650 1150 50  0000 L CNN
F 1 "Battery" H 4650 1050 50  0000 L CNN
F 2 "StaticfreeFootprints:Keystone_2464_3xAA" V 4550 1110 50  0001 C CNN
F 3 "http://www.keyelco.com/product-pdf.cfm?p=1029" V 4550 1110 50  0001 C CNN
F 4 "Keystone Electronics" H 0   0   50  0001 C CNN "MFR"
F 5 "2464" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "36-2464-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    4550 1050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 59B46B1F
P 4550 850
F 0 "#PWR07" H 4550 700 50  0001 C CNN
F 1 "VCC" H 4550 1000 50  0000 C CNN
F 2 "" H 4550 850 50  0001 C CNN
F 3 "" H 4550 850 50  0001 C CNN
	1    4550 850 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 59B46B41
P 4550 1250
F 0 "#PWR08" H 4550 1000 50  0001 C CNN
F 1 "GND" H 4550 1100 50  0000 C CNN
F 2 "" H 4550 1250 50  0001 C CNN
F 3 "" H 4550 1250 50  0001 C CNN
	1    4550 1250
	1    0    0    -1  
$EndComp
$Comp
L Device:R_PHOTO R1
U 1 1 59B47F29
P 6800 900
F 0 "R1" H 6850 950 50  0000 L CNN
F 1 "R_PHOTO" H 6850 900 50  0000 L TNN
F 2 "OptoDevice:R_LDR_5.1x4.3mm_P3.4mm_Vertical" V 6850 650 50  0001 L CNN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/Photonic%20Detetectors%20Inc%20PDFs/PDV-P8103.pdf" H 6800 850 50  0001 C CNN
F 4 "Luna Optoelectronics" H 0   0   50  0001 C CNN "MFR"
F 5 "PDV-P8103" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "PDV-P8103-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    6800 900 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 59B47F68
P 6800 1200
F 0 "R2" V 6880 1200 50  0000 C CNN
F 1 "10K" V 6800 1200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6730 1200 50  0001 C CNN
F 3 "" H 6800 1200 50  0001 C CNN
F 4 "Stackpole" H 0   0   50  0001 C CNN "MFR"
F 5 "RNCP0805FTD10K0" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "RNCP0805FTD10K0CT-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    6800 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 59B47FCA
P 6800 1350
F 0 "#PWR09" H 6800 1100 50  0001 C CNN
F 1 "GND" H 6800 1200 50  0000 C CNN
F 2 "" H 6800 1350 50  0001 C CNN
F 3 "" H 6800 1350 50  0001 C CNN
	1    6800 1350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR010
U 1 1 59E6DA53
P 5300 2600
F 0 "#PWR010" H 5300 2450 50  0001 C CNN
F 1 "VCC" H 5300 2750 50  0000 C CNN
F 2 "" H 5300 2600 50  0001 C CNN
F 3 "" H 5300 2600 50  0001 C CNN
	1    5300 2600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 59E6DA7B
P 5300 3000
F 0 "#PWR011" H 5300 2750 50  0001 C CNN
F 1 "GND" H 5300 2850 50  0000 C CNN
F 2 "" H 5300 3000 50  0001 C CNN
F 3 "" H 5300 3000 50  0001 C CNN
	1    5300 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:LED_ALT D1
U 1 1 59E6E06F
P 4100 900
F 0 "D1" V 4100 1000 50  0000 C CNN
F 1 "LED" V 4100 800 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4100 900 50  0001 C CNN
F 3 "" H 4100 900 50  0001 C CNN
F 4 "-" H 0   0   50  0001 C CNN "MFR"
F 5 "-" H 0   0   50  0001 C CNN "MPN"
F 6 "-" H 0   0   50  0001 C CNN "SPR"
F 7 "-" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    4100 900 
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R3
U 1 1 59E6E0D0
P 4100 1250
F 0 "R3" V 4180 1250 50  0000 C CNN
F 1 "1K" V 4100 1250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4030 1250 50  0001 C CNN
F 3 "" H 4100 1250 50  0001 C CNN
F 4 "Stackpole" H 0   0   50  0001 C CNN "MFR"
F 5 "RNCP0805FTD1K00" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "RNCP0805FTD1K00CT-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    4100 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR012
U 1 1 59E6E9D6
P 4100 1450
F 0 "#PWR012" H 4100 1200 50  0001 C CNN
F 1 "GND" H 4100 1300 50  0000 C CNN
F 2 "" H 4100 1450 50  0001 C CNN
F 3 "" H 4100 1450 50  0001 C CNN
	1    4100 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 59E6F89A
P 4500 2700
F 0 "#PWR013" H 4500 2450 50  0001 C CNN
F 1 "GND" H 4500 2550 50  0000 C CNN
F 2 "" H 4500 2700 50  0001 C CNN
F 3 "" H 4500 2700 50  0001 C CNN
	1    4500 2700
	1    0    0    -1  
$EndComp
$Comp
L steve_parts:PIR_MODULE U4
U 1 1 59E6FCD5
P 4050 2600
F 0 "U4" H 4150 2800 60  0000 C CNN
F 1 "PIR_MODULE" H 4150 2400 60  0000 C CNN
F 2 "StaticfreeFootprints:PaPIR_PIR_SENSOR" H 4050 2600 60  0001 C CNN
F 3 "http://www3.panasonic.biz/ac/e_download/control/sensor/human/catalog/bltn_eng_papirs.pdf" H 4050 2600 60  0001 C CNN
F 4 "Panasonic" H 0   0   50  0001 C CNN "MFR"
F 5 "EKMC1603112" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "255-3087-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    4050 2600
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 59E75352
P 5650 1200
F 0 "SW2" H 5700 1300 50  0000 L CNN
F 1 "SW_Push" H 5600 1100 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_SPST_Angled_PTS645Vx83-2LFS" H 5650 1400 50  0001 C CNN
F 3 "http://www.ckswitches.com/media/1471/pts645.pdf" H 5650 1400 50  0001 C CNN
F 4 "C&K" H 0   0   50  0001 C CNN "MFR"
F 5 "PTS645VL83-2 LFS" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "CKN9123-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    5650 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR014
U 1 1 59E75359
P 5850 1200
F 0 "#PWR014" H 5850 950 50  0001 C CNN
F 1 "GND" H 5850 1050 50  0000 C CNN
F 2 "" H 5850 1200 50  0001 C CNN
F 3 "" H 5850 1200 50  0001 C CNN
	1    5850 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 59F51723
P 4650 2000
F 0 "#PWR015" H 4650 1750 50  0001 C CNN
F 1 "GND" H 4650 1850 50  0000 C CNN
F 2 "" H 4650 2000 50  0001 C CNN
F 3 "" H 4650 2000 50  0001 C CNN
	1    4650 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 59F517DC
P 4500 2000
F 0 "R4" V 4580 2000 50  0000 C CNN
F 1 "68.1K" V 4500 2000 39  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4430 2000 50  0001 C CNN
F 3 "https://www.seielect.com/Catalog/SEI-rncp.pdf" H 4500 2000 50  0001 C CNN
F 4 "Stackpole Electronics Inc." H 0   0   50  0001 C CNN "MFR"
F 5 "RNCP0805FTD68K1" H 0   0   50  0001 C CNN "MPN"
F 6 "Digikey" H 0   0   50  0001 C CNN "SPR"
F 7 "RNCP0805FTD68K1CT-ND" H 0   0   50  0001 C CNN "SPN"
F 8 "-" H 0   0   50  0001 C CNN "SPURL"
	1    4500 2000
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x05 J2
U 1 1 59F61956
P 5950 2800
F 0 "J2" H 5950 3100 50  0000 C CNN
F 1 "Conn_01x05" H 5950 2500 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Vertical" H 5950 2800 50  0001 C CNN
F 3 "" H 5950 2800 50  0001 C CNN
F 4 "-" H -50 300 50  0001 C CNN "MFR"
F 5 "-" H -50 300 50  0001 C CNN "MPN"
F 6 "-" H -50 300 50  0001 C CNN "SPR"
F 7 "-" H -50 300 50  0001 C CNN "SPN"
F 8 "-" H -50 300 50  0001 C CNN "SPURL"
	1    5950 2800
	1    0    0    -1  
$EndComp
Text Label 5050 750  0    60   ~ 0
BUTTON1
Text Label 11150 2600 2    60   ~ 0
SCK
Text Label 8450 950  0    60   ~ 0
SDA
Text Label 8450 1100 0    60   ~ 0
SCK
Text Label 11150 2800 2    60   ~ 0
SDA
Text Label 11150 3300 2    60   ~ 0
BUTTON1
Text Label 8200 950  2    60   ~ 0
MOTION
Text Label 11150 2200 2    60   ~ 0
MOTION
Text Label 8000 2650 2    60   ~ 0
MISO
Text Label 8000 2750 2    60   ~ 0
SDA
Text Label 8000 2850 2    60   ~ 0
SCK
Text Label 8000 2950 2    60   ~ 0
RESET
Text Label 11150 3400 2    60   ~ 0
RESET
Text Label 11150 2700 2    60   ~ 0
MISO
Text Label 6300 1050 0    60   ~ 0
AMBIENT
Text Label 11150 2300 2    60   ~ 0
AMBIENT
Text Label 5300 2800 0    60   ~ 0
PA7
Text Label 5300 2900 0    60   ~ 0
PB0
Text Label 11150 3100 2    60   ~ 0
PB0
Text Label 11150 2900 2    60   ~ 0
PA7
Text Label 11150 2500 2    60   ~ 0
~ACC_PWR_EN
Text Label 11150 2400 2    60   ~ 0
STATUS_LED
Text Notes 5000 1600 0    39   ~ 0
Use internal pull-up on BUTTON pin
Text Label 4100 650  2    60   ~ 0
STATUS_LED
Text Label 4850 2600 2    60   ~ 0
MOTION
Text Label 5050 1200 0    60   ~ 0
BUTTON2
Text Label 11150 3200 2    60   ~ 0
BUTTON2
Text Label 3950 2000 0    60   ~ 0
MOTION
NoConn ~ 10900 950 
NoConn ~ 10900 1100
$Comp
L Device:C C1
U 1 1 5A38B28C
P 9300 2800
F 0 "C1" H 9325 2900 50  0000 L CNN
F 1 "10uF" H 9100 2900 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 9338 2650 50  0001 C CNN
F 3 "" H 9300 2800 50  0001 C CNN
	1    9300 2800
	1    0    0    -1  
$EndComp
Text Label 6300 650  0    60   ~ 0
ACC_PWR
Text Label 2250 1050 0    60   ~ 0
~ACC_PWR_EN
Wire Wire Line
	5450 750  5050 750 
Wire Wire Line
	10600 2600 11150 2600
Wire Wire Line
	9650 1100 10000 1100
Wire Wire Line
	9650 950  10000 950 
Wire Wire Line
	10900 1250 11050 1250
Wire Wire Line
	9650 1250 9800 1250
Wire Wire Line
	8750 950  8450 950 
Wire Wire Line
	8750 1100 8450 1100
Wire Wire Line
	10600 2800 11150 2800
Wire Wire Line
	10600 3300 11150 3300
Wire Wire Line
	11050 1250 11050 650 
Wire Wire Line
	7650 950  8200 950 
Wire Wire Line
	7650 1050 8200 1050
Wire Wire Line
	7650 1150 7750 1150
Wire Wire Line
	7750 1150 7750 1250
Wire Wire Line
	10600 2200 11150 2200
Wire Wire Line
	10600 3400 11150 3400
Wire Wire Line
	10600 2700 11150 2700
Wire Wire Line
	6800 1050 6300 1050
Wire Wire Line
	10600 2300 11150 2300
Wire Notes Line
	2050 1700 11200 1700
Wire Notes Line
	7250 1700 7250 500 
Wire Notes Line
	6150 1700 6150 500 
Wire Notes Line
	4950 1700 4950 500 
Wire Notes Line
	2050 3950 11200 3950
Wire Notes Line
	6400 3950 6400 1700
Wire Notes Line
	4300 1700 4300 500 
Wire Wire Line
	5750 2600 5300 2600
Wire Wire Line
	5300 2900 5750 2900
Wire Wire Line
	5750 2800 5300 2800
Wire Wire Line
	5750 2700 5300 2700
Wire Wire Line
	10600 2400 11150 2400
Wire Wire Line
	10600 2500 11150 2500
Wire Wire Line
	10600 2900 11150 2900
Wire Wire Line
	10600 3100 11150 3100
Wire Wire Line
	10600 3200 11150 3200
Wire Notes Line
	4900 3500 4900 1700
Wire Wire Line
	4100 1400 4100 1450
Wire Wire Line
	4100 1100 4100 1050
Wire Wire Line
	4100 750  4100 650 
Wire Notes Line
	3500 1700 3500 500 
Wire Wire Line
	4500 2600 4850 2600
Wire Wire Line
	5450 1200 5050 1200
Wire Notes Line
	3750 3500 3750 1700
Wire Wire Line
	3950 2000 4350 2000
Wire Wire Line
	5300 3000 5750 3000
Connection ~ 6800 1050
Wire Notes Line
	8350 500  8350 1700
Wire Notes Line
	8200 3950 8200 1700
Wire Wire Line
	6800 750  6800 650 
Wire Wire Line
	6800 650  6300 650 
Wire Wire Line
	2750 1050 2250 1050
Wire Wire Line
	3050 850  2250 850 
Text Label 2250 850  0    60   ~ 0
ACC_PWR
Wire Wire Line
	9800 1250 9800 650 
$Comp
L power:GND #PWR016
U 1 1 59B441B9
P 8750 1250
F 0 "#PWR016" H 8750 1000 50  0001 C CNN
F 1 "GND" H 8750 1100 50  0000 C CNN
F 2 "" H 8750 1250 50  0001 C CNN
F 3 "" H 8750 1250 50  0001 C CNN
	1    8750 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 59B4419D
P 10000 1250
F 0 "#PWR017" H 10000 1000 50  0001 C CNN
F 1 "GND" H 10000 1100 50  0000 C CNN
F 2 "" H 10000 1250 50  0001 C CNN
F 3 "" H 10000 1250 50  0001 C CNN
	1    10000 1250
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:BSS83P Q1
U 1 1 5A54396E
P 2950 1050
F 0 "Q1" H 3150 1125 50  0000 L CNN
F 1 "BSS83P" H 3150 1050 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3150 975 50  0001 L CIN
F 3 "" H 2950 1050 50  0001 L CNN
	1    2950 1050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR018
U 1 1 5A543B0A
P 3050 1250
F 0 "#PWR018" H 3050 1100 50  0001 C CNN
F 1 "VCC" H 3050 1400 50  0000 C CNN
F 2 "" H 3050 1250 50  0001 C CNN
F 3 "" H 3050 1250 50  0001 C CNN
	1    3050 1250
	-1   0    0    1   
$EndComp
Wire Wire Line
	11050 650  9800 650 
Connection ~ 9800 650 
Text Label 9350 650  0    60   ~ 0
ACC_PWR
Wire Notes Line
	2050 500  2050 3500
Text Label 5300 2700 0    60   ~ 0
ACC_PWR
Wire Wire Line
	4500 2500 4850 2500
Text Label 4850 2500 2    60   ~ 0
ACC_PWR
Text Label 8200 1050 2    60   ~ 0
ACC_PWR
$Comp
L Connector:USB_B_Micro J3
U 1 1 5A6A8C04
P 3200 2600
F 0 "J3" H 3000 3050 50  0000 L CNN
F 1 "USB_MICRO" H 2950 2950 50  0000 L CNN
F 2 "Connector_USB:USB_Micro-B_Molex-105017-0001" H 3350 2550 50  0001 C CNN
F 3 "" H 3350 2550 50  0001 C CNN
	1    3200 2600
	1    0    0    -1  
$EndComp
NoConn ~ 3500 2600
NoConn ~ 3500 2700
NoConn ~ 3500 2800
$Comp
L power:VCC #PWR019
U 1 1 5A6A8D45
P 3500 2400
F 0 "#PWR019" H 3500 2250 50  0001 C CNN
F 1 "VCC" H 3500 2550 50  0000 C CNN
F 2 "" H 3500 2400 50  0001 C CNN
F 3 "" H 3500 2400 50  0001 C CNN
	1    3500 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 5A6A8DC7
P 3200 3000
F 0 "#PWR020" H 3200 2750 50  0001 C CNN
F 1 "GND" H 3200 2850 50  0000 C CNN
F 2 "" H 3200 3000 50  0001 C CNN
F 3 "" H 3200 3000 50  0001 C CNN
	1    3200 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR021
U 1 1 5A6A8DFF
P 3100 3000
F 0 "#PWR021" H 3100 2750 50  0001 C CNN
F 1 "GND" H 3100 2850 50  0000 C CNN
F 2 "" H 3100 3000 50  0001 C CNN
F 3 "" H 3100 3000 50  0001 C CNN
	1    3100 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9800 650  9350 650 
$Comp
L Connector:USB_B_Micro J4
U 1 1 5B5AE751
P 2550 2600
F 0 "J4" H 2350 3050 50  0000 L CNN
F 1 "USB_MICRO" H 2250 2950 50  0000 L CNN
F 2 "Connector_USB:USB_Micro-B_Molex-105017-0001" H 2700 2550 50  0001 C CNN
F 3 "" H 2700 2550 50  0001 C CNN
	1    2550 2600
	1    0    0    -1  
$EndComp
NoConn ~ 2850 2600
NoConn ~ 2850 2700
NoConn ~ 2850 2800
$Comp
L power:VCC #PWR0101
U 1 1 5B5AE75B
P 2850 2400
F 0 "#PWR0101" H 2850 2250 50  0001 C CNN
F 1 "VCC" H 2850 2550 50  0000 C CNN
F 2 "" H 2850 2400 50  0001 C CNN
F 3 "" H 2850 2400 50  0001 C CNN
	1    2850 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5B5AE761
P 2550 3000
F 0 "#PWR0102" H 2550 2750 50  0001 C CNN
F 1 "GND" H 2550 2850 50  0000 C CNN
F 2 "" H 2550 3000 50  0001 C CNN
F 3 "" H 2550 3000 50  0001 C CNN
	1    2550 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5B5AE767
P 2450 3000
F 0 "#PWR0103" H 2450 2750 50  0001 C CNN
F 1 "GND" H 2450 2850 50  0000 C CNN
F 2 "" H 2450 3000 50  0001 C CNN
F 3 "" H 2450 3000 50  0001 C CNN
	1    2450 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 1900 9300 2650
Wire Wire Line
	9300 1900 10000 1900
Connection ~ 10000 1900
Wire Wire Line
	10000 3700 9300 3700
Wire Wire Line
	9300 3700 9300 2950
Connection ~ 10000 3700
Wire Wire Line
	7600 2850 8000 2850
Wire Wire Line
	8000 2950 7600 2950
Wire Wire Line
	8000 2650 7600 2650
Wire Wire Line
	8000 2750 7600 2750
$EndSCHEMATC
