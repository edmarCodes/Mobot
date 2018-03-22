#line 1 "C:/Users/Edmar/Documents/School Related/ModSim/Sir ran/inputManager.c"
#line 1 "c:/users/edmar/documents/school related/modsim/sir ran/inputmanager.h"
#line 1 "c:/users/edmar/documents/school related/modsim/sir ran/macro.h"
#line 6 "c:/users/edmar/documents/school related/modsim/sir ran/inputmanager.h"
typedef enum
{
 NO_SIGHT =0,
 LEFT_SIGHT=1,
 RIGHT_SIGHT=2,
 BOTH_SIGHT=3
}input_manager_state_t;





input_manager_state_t inputManager_GetState(void);


void inputManager_Init(void);

void inputManager_UpdateManager(void);
 void inputManager_UpdateManager2(void);
#line 1 "c:/users/edmar/documents/school related/modsim/sir ran/macro.h"
#line 4 "C:/Users/Edmar/Documents/School Related/ModSim/Sir ran/inputManager.c"
input_manager_state_t input_manager_state = NO_SIGHT;

input_manager_state_t inputManager_GetState(void)
{
 return input_manager_state;
}

void inputManager_Init(void)
{
}



void inputManager_UpdateManager2(void)
{

 if(  PORTB.f4 )
 {
  PORTB |= 0x01 ;
 }
 else
 {
  PORTB &= ~0x01 ;
 }


 if(  PORTB.f5 )
 {
  PORTB |= 0x02 ;
 }
 else
 {
  PORTB &= ~0x02 ;
 }


}



void inputManager_UpdateManager(void)
{
 switch(input_manager_state)
 {

 case NO_SIGHT:

  PORTB &= ~0x01 ;
  PORTB &= ~0x02 ;

 if( PORTB.f4  && ! PORTB.f5 )
 {
 input_manager_state = LEFT_SIGHT;
  PORTB |= 0x01 ;
 }
 else if(! PORTB.f4  &&  PORTB.f5 )
 {
 input_manager_state = RIGHT_SIGHT;
  PORTB |= 0x02 ;
 }
 break;

 case LEFT_SIGHT:


 if(! PORTB.f4  && ! PORTB.f5 )
 {
 input_manager_state = NO_SIGHT;

  PORTB &= ~0x02 ;
  PORTB &= ~0x01 ;

 }
 else if(! PORTB.f4  &&  PORTB.f5 )
 {
 input_manager_state = RIGHT_SIGHT;

  PORTB |= 0x02 ;
  PORTB &= ~0x01 ;

 }
 else if( PORTB.f4  &&  PORTB.f5 )
 {
 input_manager_state = BOTH_SIGHT;
  PORTB |= 0x02 ;
  PORTB |= 0x01 ;

 }

 break;


 case RIGHT_SIGHT:


 if(! PORTB.f4  && ! PORTB.f5 )
 {
 input_manager_state = NO_SIGHT;
  PORTB &= ~0x02 ;
  PORTB &= ~0x01 ;
 }
 else if( PORTB.f4  && ! PORTB.f5 )
 {
 input_manager_state = LEFT_SIGHT;
  PORTB &= ~0x02 ;
  PORTB |= 0x01 ;
 }
 else if( PORTB.f4  &&  PORTB.f5 )
 {
 input_manager_state = BOTH_SIGHT;
  PORTB |= 0x02 ;
  PORTB |= 0x01 ;
 }

 break;

 case BOTH_SIGHT:

 if( PORTB.f4  && ! PORTB.f5 )
 {
 input_manager_state = LEFT_SIGHT;
  PORTB &= ~0x02 ;
  PORTB |= 0x01 ;
 }
 else if(! PORTB.f4  &&  PORTB.f5 )
 {
 input_manager_state = RIGHT_SIGHT;
  PORTB |= 0x02 ;
  PORTB &= ~0x01 ;
 }
 else if(! PORTB.f4  && ! PORTB.f5 )
 {
 input_manager_state = NO_SIGHT;
  PORTB &= ~0x02 ;
  PORTB &= ~0x01 ;

 PORTB |= 0x02;
 PORTB |= 0x01;

 }
 break;

 default:
 input_manager_state = NO_SIGHT;
  PORTB &= ~0x02 ;
  PORTB &= ~0x01 ;
 break;
 }


}
