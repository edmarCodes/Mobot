
_motorManager_GetState:

;motorManager.c,9 :: 		motor_manager_state_t motorManager_GetState(void)
;motorManager.c,11 :: 		return motor_manager_state;
	MOVF       _motor_manager_state+0, 0
	MOVWF      R0+0
;motorManager.c,12 :: 		}
L_end_motorManager_GetState:
	RETURN
; end of _motorManager_GetState

_motorManager_Init:

;motorManager.c,13 :: 		void motorManager_Init(void)
;motorManager.c,16 :: 		}
L_end_motorManager_Init:
	RETURN
; end of _motorManager_Init

_motorManager_UpdateManager:

;motorManager.c,18 :: 		void motorManager_UpdateManager(void)
;motorManager.c,20 :: 		switch(motor_manager_state)
	GOTO       L_motorManager_UpdateManager0
;motorManager.c,22 :: 		case MOTOR_INIT:
L_motorManager_UpdateManager2:
;motorManager.c,24 :: 		motor_manager_state =  MOTOR_OFF;
	MOVLW      1
	MOVWF      _motor_manager_state+0
;motorManager.c,25 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,28 :: 		case MOTOR_OFF:
L_motorManager_UpdateManager3:
;motorManager.c,30 :: 		motorManager_MotorAMoveBackward();
	BCF        PORTB+0, 2
;motorManager.c,31 :: 		motorManager_MotorBMoveBackward();
	BCF        PORTB+0, 3
;motorManager.c,32 :: 		motorManager_MotorAOff();
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,33 :: 		motorManager_MotorBOff();
	CLRF       FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,35 :: 		if(inputManager_GetState() == LEFT_SIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager4
;motorManager.c,37 :: 		motor_manager_state = SLOW_LEFT;
	MOVLW      2
	MOVWF      _motor_manager_state+0
;motorManager.c,38 :: 		}
	GOTO       L_motorManager_UpdateManager5
L_motorManager_UpdateManager4:
;motorManager.c,39 :: 		else if(inputManager_GetState() ==RIGHT_SIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager6
;motorManager.c,41 :: 		motor_manager_state = SLOW_RIGHT;
	MOVLW      3
	MOVWF      _motor_manager_state+0
;motorManager.c,42 :: 		}
	GOTO       L_motorManager_UpdateManager7
L_motorManager_UpdateManager6:
;motorManager.c,43 :: 		else if(inputManager_GetState() ==BOTH_SIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager8
;motorManager.c,45 :: 		motor_manager_state = BACKWARD;
	MOVLW      4
	MOVWF      _motor_manager_state+0
;motorManager.c,46 :: 		}
L_motorManager_UpdateManager8:
L_motorManager_UpdateManager7:
L_motorManager_UpdateManager5:
;motorManager.c,49 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,51 :: 		case SLOW_LEFT:
L_motorManager_UpdateManager9:
;motorManager.c,52 :: 		motorManager_MotorAMoveBackward();
	BCF        PORTB+0, 2
;motorManager.c,53 :: 		motorManager_MotorBMoveForward();
	BSF        PORTB+0, 3
;motorManager.c,54 :: 		motorManager_MotorAMoveSlow();
	MOVLW      204
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,55 :: 		motorManager_MotorBMoveSlow();
	MOVLW      204
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,57 :: 		if(inputManager_GetState() ==NO_SIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager10
;motorManager.c,59 :: 		motor_manager_state = MOTOR_OFF;
	MOVLW      1
	MOVWF      _motor_manager_state+0
;motorManager.c,60 :: 		}
	GOTO       L_motorManager_UpdateManager11
L_motorManager_UpdateManager10:
;motorManager.c,61 :: 		else if(inputManager_GetState() ==RIGHT_SIGHT || lineManager_GetState() == PARTIAL_LEFT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager65
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager65
	GOTO       L_motorManager_UpdateManager14
L__motorManager_UpdateManager65:
;motorManager.c,63 :: 		motor_manager_state = SLOW_RIGHT;
	MOVLW      3
	MOVWF      _motor_manager_state+0
;motorManager.c,64 :: 		}
	GOTO       L_motorManager_UpdateManager15
L_motorManager_UpdateManager14:
;motorManager.c,65 :: 		else if(inputManager_GetState() == BOTH_SIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager16
;motorManager.c,67 :: 		motor_manager_state = BACKWARD;
	MOVLW      4
	MOVWF      _motor_manager_state+0
;motorManager.c,68 :: 		}else if(lineManager_GetState() == HALF_LEFT || lineManager_GetState() == FULL){
	GOTO       L_motorManager_UpdateManager17
L_motorManager_UpdateManager16:
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager64
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager64
	GOTO       L_motorManager_UpdateManager20
L__motorManager_UpdateManager64:
;motorManager.c,69 :: 		motor_manager_state = FAST_RIGHT;
	MOVLW      7
	MOVWF      _motor_manager_state+0
;motorManager.c,70 :: 		}else if(lineManager_GetState() == HALF_RIGHT || lineManager_GetState() == FULL){
	GOTO       L_motorManager_UpdateManager21
L_motorManager_UpdateManager20:
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager63
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager63
	GOTO       L_motorManager_UpdateManager24
L__motorManager_UpdateManager63:
;motorManager.c,71 :: 		motor_manager_state = FAST_LEFT;
	MOVLW      8
	MOVWF      _motor_manager_state+0
;motorManager.c,72 :: 		}
L_motorManager_UpdateManager24:
L_motorManager_UpdateManager21:
L_motorManager_UpdateManager17:
L_motorManager_UpdateManager15:
L_motorManager_UpdateManager11:
;motorManager.c,73 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,75 :: 		case  SLOW_RIGHT:
L_motorManager_UpdateManager25:
;motorManager.c,76 :: 		motorManager_MotorAMoveForward();
	BSF        PORTB+0, 2
;motorManager.c,77 :: 		motorManager_MotorBMoveBackward();
	BCF        PORTB+0, 3
;motorManager.c,78 :: 		motorManager_MotorAMoveSlow();
	MOVLW      204
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,79 :: 		motorManager_MotorBMoveSlow();
	MOVLW      204
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,81 :: 		if(inputManager_GetState() ==NO_SIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager26
;motorManager.c,83 :: 		motor_manager_state = MOTOR_OFF;
	MOVLW      1
	MOVWF      _motor_manager_state+0
;motorManager.c,84 :: 		}
	GOTO       L_motorManager_UpdateManager27
L_motorManager_UpdateManager26:
;motorManager.c,85 :: 		else if(inputManager_GetState() ==LEFT_SIGHT || lineManager_GetState() == PARTIAL_RIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager62
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager62
	GOTO       L_motorManager_UpdateManager30
L__motorManager_UpdateManager62:
;motorManager.c,87 :: 		motor_manager_state = SLOW_LEFT;
	MOVLW      2
	MOVWF      _motor_manager_state+0
;motorManager.c,88 :: 		}
	GOTO       L_motorManager_UpdateManager31
L_motorManager_UpdateManager30:
;motorManager.c,89 :: 		else if(inputManager_GetState() ==BOTH_SIGHT)
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager32
;motorManager.c,91 :: 		motor_manager_state = BACKWARD;
	MOVLW      4
	MOVWF      _motor_manager_state+0
;motorManager.c,92 :: 		}else if(lineManager_GetState() == HALF_LEFT || lineManager_GetState() == FULL){
	GOTO       L_motorManager_UpdateManager33
L_motorManager_UpdateManager32:
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager61
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager61
	GOTO       L_motorManager_UpdateManager36
L__motorManager_UpdateManager61:
;motorManager.c,93 :: 		motor_manager_state = FAST_RIGHT;
	MOVLW      7
	MOVWF      _motor_manager_state+0
;motorManager.c,94 :: 		}else if(lineManager_GetState() == HALF_RIGHT || lineManager_GetState() == FULL){
	GOTO       L_motorManager_UpdateManager37
L_motorManager_UpdateManager36:
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager60
	CALL       _lineManager_GetState+0
	MOVF       R0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__motorManager_UpdateManager60
	GOTO       L_motorManager_UpdateManager40
L__motorManager_UpdateManager60:
;motorManager.c,95 :: 		motor_manager_state = FAST_LEFT;
	MOVLW      8
	MOVWF      _motor_manager_state+0
;motorManager.c,96 :: 		}
L_motorManager_UpdateManager40:
L_motorManager_UpdateManager37:
L_motorManager_UpdateManager33:
L_motorManager_UpdateManager31:
L_motorManager_UpdateManager27:
;motorManager.c,100 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,102 :: 		case FAST_RIGHT:
L_motorManager_UpdateManager41:
;motorManager.c,104 :: 		motorManager_MotorAMoveForward();
	BSF        PORTB+0, 2
;motorManager.c,105 :: 		motorManager_MotorBMoveBackward();
	BCF        PORTB+0, 3
;motorManager.c,106 :: 		motorManager_MotorAMoveFast();
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,107 :: 		motorManager_MotorBMoveFast();
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,109 :: 		if(inputManager_GetState() == LEFT_SIGHT){
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager42
;motorManager.c,110 :: 		motor_manager_state = SLOW_LEFT;
	MOVLW      2
	MOVWF      _motor_manager_state+0
;motorManager.c,111 :: 		}else if(inputManager_GetState() == RIGHT_SIGHT){
	GOTO       L_motorManager_UpdateManager43
L_motorManager_UpdateManager42:
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager44
;motorManager.c,112 :: 		motor_manager_state = SLOW_RIGHT;
	MOVLW      3
	MOVWF      _motor_manager_state+0
;motorManager.c,113 :: 		}else if(inputManager_GetState() == BOTH_SIGHT){
	GOTO       L_motorManager_UpdateManager45
L_motorManager_UpdateManager44:
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager46
;motorManager.c,114 :: 		motor_manager_state = BACKWARD;
	MOVLW      4
	MOVWF      _motor_manager_state+0
;motorManager.c,115 :: 		}
L_motorManager_UpdateManager46:
L_motorManager_UpdateManager45:
L_motorManager_UpdateManager43:
;motorManager.c,117 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,119 :: 		case FAST_LEFT:
L_motorManager_UpdateManager47:
;motorManager.c,121 :: 		motorManager_MotorAMoveBackward();
	BCF        PORTB+0, 2
;motorManager.c,122 :: 		motorManager_MotorBMoveForward();
	BSF        PORTB+0, 3
;motorManager.c,123 :: 		motorManager_MotorAMoveFast();
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,124 :: 		motorManager_MotorBMoveFast();
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,126 :: 		if(inputManager_GetState() == LEFT_SIGHT){
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager48
;motorManager.c,127 :: 		motor_manager_state = SLOW_LEFT;
	MOVLW      2
	MOVWF      _motor_manager_state+0
;motorManager.c,128 :: 		}else if(inputManager_GetState() == RIGHT_SIGHT){
	GOTO       L_motorManager_UpdateManager49
L_motorManager_UpdateManager48:
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager50
;motorManager.c,129 :: 		motor_manager_state = SLOW_RIGHT;
	MOVLW      3
	MOVWF      _motor_manager_state+0
;motorManager.c,130 :: 		}else if(inputManager_GetState() == BOTH_SIGHT){
	GOTO       L_motorManager_UpdateManager51
L_motorManager_UpdateManager50:
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager52
;motorManager.c,131 :: 		motor_manager_state = BACKWARD;
	MOVLW      4
	MOVWF      _motor_manager_state+0
;motorManager.c,132 :: 		}
L_motorManager_UpdateManager52:
L_motorManager_UpdateManager51:
L_motorManager_UpdateManager49:
;motorManager.c,134 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,136 :: 		case  BACKWARD:
L_motorManager_UpdateManager53:
;motorManager.c,138 :: 		motorManager_MotorAMoveBackward();
	BCF        PORTB+0, 2
;motorManager.c,139 :: 		motorManager_MotorBMoveBackward();
	BCF        PORTB+0, 3
;motorManager.c,140 :: 		motorManager_MotorAMoveSlow();
	MOVLW      204
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,141 :: 		motorManager_MotorBMoveSlow();
	MOVLW      204
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,143 :: 		motor_manager_state = DELAY;
	MOVLW      5
	MOVWF      _motor_manager_state+0
;motorManager.c,145 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,147 :: 		case DELAY:
L_motorManager_UpdateManager54:
;motorManager.c,149 :: 		motorManager_MotorAMoveBackward();
	BCF        PORTB+0, 2
;motorManager.c,150 :: 		motorManager_MotorBMoveBackward();
	BCF        PORTB+0, 3
;motorManager.c,152 :: 		Delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_motorManager_UpdateManager55:
	DECFSZ     R13+0, 1
	GOTO       L_motorManager_UpdateManager55
	DECFSZ     R12+0, 1
	GOTO       L_motorManager_UpdateManager55
	DECFSZ     R11+0, 1
	GOTO       L_motorManager_UpdateManager55
	NOP
;motorManager.c,153 :: 		motorManager_MotorAOff();
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,154 :: 		motorManager_MotorBOff();
	CLRF       FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,155 :: 		Delay_ms(1500);
	MOVLW      39
	MOVWF      R11+0
	MOVLW      13
	MOVWF      R12+0
	MOVLW      38
	MOVWF      R13+0
L_motorManager_UpdateManager56:
	DECFSZ     R13+0, 1
	GOTO       L_motorManager_UpdateManager56
	DECFSZ     R12+0, 1
	GOTO       L_motorManager_UpdateManager56
	DECFSZ     R11+0, 1
	GOTO       L_motorManager_UpdateManager56
	NOP
;motorManager.c,157 :: 		motor_manager_state = FAST_FORWARD;
	MOVLW      6
	MOVWF      _motor_manager_state+0
;motorManager.c,159 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,161 :: 		case FAST_FORWARD:
L_motorManager_UpdateManager57:
;motorManager.c,163 :: 		motorManager_MotorAMoveForward();
	BSF        PORTB+0, 2
;motorManager.c,164 :: 		motorManager_MotorBMoveForward();
	BSF        PORTB+0, 3
;motorManager.c,165 :: 		motorManager_MotorAMoveFast();
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motorManager.c,166 :: 		motorManager_MotorBMoveFast();
	MOVLW      255
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motorManager.c,168 :: 		if(inputManager_GetState() ==NO_SIGHT){
	CALL       _inputManager_GetState+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager58
;motorManager.c,169 :: 		motor_manager_state = MOTOR_OFF;
	MOVLW      1
	MOVWF      _motor_manager_state+0
;motorManager.c,170 :: 		}
L_motorManager_UpdateManager58:
;motorManager.c,172 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,174 :: 		default:
L_motorManager_UpdateManager59:
;motorManager.c,175 :: 		break;
	GOTO       L_motorManager_UpdateManager1
;motorManager.c,177 :: 		}
L_motorManager_UpdateManager0:
	MOVF       _motor_manager_state+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager2
	MOVF       _motor_manager_state+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager3
	MOVF       _motor_manager_state+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager9
	MOVF       _motor_manager_state+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager25
	MOVF       _motor_manager_state+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager41
	MOVF       _motor_manager_state+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager47
	MOVF       _motor_manager_state+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager53
	MOVF       _motor_manager_state+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager54
	MOVF       _motor_manager_state+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_motorManager_UpdateManager57
	GOTO       L_motorManager_UpdateManager59
L_motorManager_UpdateManager1:
;motorManager.c,178 :: 		}
L_end_motorManager_UpdateManager:
	RETURN
; end of _motorManager_UpdateManager

_motorManager_UpdateManager2:

;motorManager.c,180 :: 		void motorManager_UpdateManager2(void)
;motorManager.c,225 :: 		}
L_end_motorManager_UpdateManager2:
	RETURN
; end of _motorManager_UpdateManager2
