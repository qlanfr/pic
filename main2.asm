
	       INCLUDE <P16F877A.inc>
#DEFINE      LCD_RS  PORTA,3
#DEFINE      LCD_RW  PORTA,2
#DEFINE      LCD_EN  PORTA,1    
#DEFINE      BTN     PORTC,0
#DEFINE      LED     PORTD,0 

COM_BUF      EQU  0X20
DATA_PTR     EQU  0X24
COUNT1       EQU  0X25
COUNT2       EQU  0X26
COUNT3       EQU  0X27

            ORG  0x0000
            GOTO MAIN

MAIN  
            NOP
            CALL INIT_LCD
            CALL L1home_LCD
            CALL DSP_DATA1

            CALL L2home_LCD
            CALL DSP_DATA2

LOOP_S      BTFSC BTN             
            GOTO  BTN_PRESSED
            GOTO  BTN_NOT_PRESSED

BTN_PRESSED
            CALL L1home_LCD
            CALL CLR_LCD
            CALL DSP_DATA1
            BSF   LED               
            
            GOTO  LOOP_S

BTN_NOT_PRESSED
            CALL L1home_LCD
            CALL CLR_LCD
            CALL DSP_DATA2
            BCF   LED               
                    
            GOTO  LOOP_S

INIT_LCD
            BSF      STATUS,RP0
            MOVLW    B'00000111'
            MOVWF    ADCON1
            MOVLW    B'00000000'
            MOVWF    TRISB
            MOVLW    B'00000000'    
            MOVWF    TRISA
            MOVLW    B'00000000'    
            MOVWF    TRISD
            BSF      STATUS,RP0
            MOVLW    B'00000001'
            MOVWF    TRISC 
            BCF      STATUS,RP0

            CALL     DELAY_25M
            CALL     DELAY_25M

FUNCTION_SET 
            MOVLW    B'00111000'
            MOVWF    COM_BUF
            CALL     IWRT_COM
            CALL     DELAY_50U

DISPLAY_ON_OFF
            MOVLW    B'00001101'
            MOVWF    COM_BUF
            CALL     IWRT_COM
            CALL     DELAY_50U

DISPLAY_CLEAR
            MOVLW    B'00000001'
            MOVWF    COM_BUF
            CALL     IWRT_COM
            CALL     DELAY_2M

ENTRY_SET 
            MOVLW    B'00000110'
            MOVWF    COM_BUF
            CALL     IWRT_COM
            CALL     DELAY_50U 
            RETURN

DSP_DATA1
            CLRF DATA_PTR
DDT1        MOVF DATA_PTR, W
            CALL DATA_TABLE1

            IORLW  0X00
            BTFSC  STATUS,ZF
            GOTO   RTN1

            CALL   PUT_LCD
            INCF   DATA_PTR, F
            GOTO   DDT1
RTN1        RETURN

DSP_DATA2
            CLRF   DATA_PTR
DDT2        MOVF   DATA_PTR, W
            CALL   DATA_TABLE2
            IORLW  0X00
            BTFSC  STATUS,ZF
            GOTO   RTN2

            CALL   PUT_LCD
            INCF   DATA_PTR, F
            GOTO   DDT2
RTN2        RETURN

CLR_LCD
            MOVLW    B'00000001'
            MOVWF    COM_BUF
            CALL     IWRT_COM
            CALL     DELAY_2M
            RETURN 

PUT_LCD
            MOVWF  COM_BUF
            CALL   DWRT_COM
	    CALL   DELAY_25M
            RETURN

L1home_LCD  
            MOVLW 0X80
            MOVWF COM_BUF
            CALL  IWRT_COM
            RETURN

L2home_LCD  
            MOVLW  0XC0
            MOVWF  COM_BUF
            CALL   IWRT_COM
            RETURN 

BUSY_CHK
            CLRF   PORTB
            BSF    STATUS,RP0
            MOVLW  0XFF
            MOVWF  TRISB
            BCF    STATUS,RP0

            BCF    LCD_RS
            BSF    LCD_RW
            NOP
            NOP

            BCF    LCD_RS
            BSF    LCD_RW
            NOP
            NOP

            BSF    LCD_EN
            BTFSC  PORTB,7
            GOTO   RE_CHK
            BCF    LCD_EN
            RETURN
RE_CHK      BCF    LCD_EN
            GOTO   BUSY_CHK

DWRT_COM
            CALL  BUSY_CHK
            BSF   LCD_RS
            GOTO  WRT_COM

IWRT_COM   
            CALL  BUSY_CHK
            BCF   LCD_RS

WRT_COM   
            BCF   LCD_RW
            CLRF  PORTB
            BSF   STATUS,RP0
            CLRF  TRISB
            BCF   STATUS,RP0

            BSF   LCD_EN
            MOVF  COM_BUF,W
            MOVWF PORTB
            NOP
            NOP
            BCF   LCD_EN
            RETURN

DELAY_25M
            MOVLW  .200
            MOVWF  COUNT3
LP4         CALL   DELAY_125U
            DECFSZ COUNT3, F
            GOTO   LP4
            RETURN

DELAY_50U  
            MOVLW  .16
            MOVLW  COUNT1
LP3         DECFSZ COUNT1, F
            GOTO   LP3
            RETURN

DELAY_2M    MOVLW  .16
            MOVWF  COUNT2
LP2         CALL   DELAY_125U
            DECFSZ COUNT2,F
            GOTO   LP2
            RETURN

DELAY_125U
            MOVLW .40
            MOVWF COUNT1
LP1         DECFSZ COUNT1, F
            GOTO   LP1
            RETURN

DELAY_1S


            MOVLW 0xC8     
            MOVWF COUNT1
DELAY_1S_LOOP
            CALL DELAY_25M
            DECFSZ COUNT1, F
            GOTO DELAY_1S_LOOP
            RETURN

DATA_TABLE1
            MOVLW 'L'
	    CALL PUT_LCD
	    MOVLW 'E'
	    CALL PUT_LCD
	    MOVLW 'D'
	    CALL PUT_LCD
	    MOVLW ' '
	    CALL PUT_LCD
	    MOVLW 'O'
	    CALL PUT_LCD
	    MOVLW 'N'
	    CALL PUT_LCD
	    
            
            RETLW .0

DATA_TABLE2
            MOVLW 'L'
	    CALL PUT_LCD
	    MOVLW 'E'
	    CALL PUT_LCD
	    MOVLW 'D'
	    CALL PUT_LCD
	    MOVLW ' '
	    CALL PUT_LCD
	    MOVLW 'O'
	    CALL PUT_LCD
	    MOVLW 'F'
	    CALL PUT_LCD
	    MOVLW 'F'
	    CALL PUT_LCD
            RETLW .0
            END