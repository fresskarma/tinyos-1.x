// *** WARNING ****** WARNING ****** WARNING ****** WARNING ****** WARNING ***
// ***                                                                     ***
// *** This file was automatically generated by create_NeighborExt.pl.     ***
// *** Any and all changes made to this file WILL BE LOST!                 ***
// ***                                                                     ***
// *** WARNING ****** WARNING ****** WARNING ****** WARNING ****** WARNING ***

//!! Config 3 { uint8_t tuple_mag_retries = 0; }

includes cqueue;
includes SchemaType;
includes Command;
includes NestArch;

module TuplePublisherM
{
  provides
  {
    interface TuplePublisher;
    interface StdControl;

    interface Neighbor_location;
    interface Neighbor_ucb_location_nak;
    interface Neighbor_mag;  }
  uses
  {
    interface Leds;
    interface TupleStore;
    interface TupleManager;
    interface RoutingSendByBroadcast;
    interface RoutingSendByBroadcast as CommandBroadcast;
    interface RoutingReceive;
    interface StdControl as CommandControl;
    interface CommandRegister as Publish;
    interface Random;
    interface Timer;
  }
}
implementation
{
  TOS_Msg m_msg;
  bool m_is_sending;
  uint8_t m_tupleTypeToBePublished;
  uint16_t m_nodeIDToBePublished;



  enum {
    MAX_QUEUE_SIZE = 12,
  };

  TupleMsgHeader_t m_queue[ MAX_QUEUE_SIZE ];
  cqueue_t m_cq;

  command result_t StdControl.init()
  {
    ParamList paramList;
    m_is_sending = FALSE;
    init_cqueue( &m_cq, MAX_QUEUE_SIZE );
    call CommandControl.init();
    paramList.numParams=1;
    paramList.params[0]=INT8;
    paramList.params[1]=INT16;
    if (call Publish.registerCommand("Publish", VOID, 0, &paramList) != SUCCESS)
			return FAIL;
    return SUCCESS;
  }

  command result_t StdControl.start()
  {
    call CommandControl.start();
    return SUCCESS;
  }

  command result_t StdControl.stop()
  { 
   call CommandControl.stop();
   return SUCCESS;
  }

  event result_t Publish.commandFunc(char *commandName, char *resultBuf, SchemaErrorNo *errorNo, ParamVals *params)
	{
	    	                	    uint32_t randomDelay;
	    m_tupleTypeToBePublished = *(uint8_t*)params->paramDataPtr[0];
	    m_nodeIDToBePublished = *(uint16_t*)params->paramDataPtr[1];
	    if(m_nodeIDToBePublished == 0)
		m_nodeIDToBePublished = TOS_LOCAL_ADDRESS;
	    randomDelay = call Random.rand() & 0x0fff;             call Timer.start(TIMER_ONE_SHOT, randomDelay);
	    return SUCCESS;
	}

  event result_t Timer.fired() 
  {
	call TuplePublisher.publish(m_tupleTypeToBePublished, m_nodeIDToBePublished);
	return SUCCESS;
  }

  task void do_publish();

  result_t requestRemoteTuples(uint8_t tupleType)
  {
    if( push_back_cqueue(&m_cq) == SUCCESS )
    {
      m_queue[ m_cq.back ].address   = 0;
      m_queue[ m_cq.back ].tupletype = tupleType;
      post do_publish();
      return SUCCESS;
    }
    return FAIL;
  }
      
  result_t createRemoteTupleRequest(uint8_t tupleType)
  {
    struct CommandMsg* cmdHeaders;
    char* cmdName;
    uint8_t* tupleTypeParam;
    uint16_t* nodeIDParam;

       if( (cmdHeaders = (struct CommandMsg*)initRoutingMsg( &m_msg, sizeof(struct CommandMsg) )) == 0 )
         return FAIL;
   if( (cmdName = (char*)pushToRoutingMsg( &m_msg, sizeof("Publish") )) == 0 )
      return FAIL;
   if( (tupleTypeParam = (uint8_t*)pushToRoutingMsg( &m_msg, sizeof(uint8_t) )) == 0 )
      return FAIL;
   if( (nodeIDParam = (uint16_t*)pushToRoutingMsg( &m_msg, sizeof(uint16_t) )) == 0 )
      return FAIL;

      cmdHeaders->nodeid = TOS_BCAST_ADDR;
   cmdHeaders->fromBase = 0;
   strcpy(cmdName, "Publish");
   *tupleTypeParam = tupleType;
   *nodeIDParam = 0;    return SUCCESS;
  }
      


  command void Neighbor_location.set( uint16_t address, location_t* location )
  {
    Neighbor_t* nn = call TupleStore.privateGetByAddress( address );

    if( nn != 0 )
    {
      nn->location = *location;
    }
    else
    {
      nn = call TupleManager.getByAddress( address );
      nn->location = *location;
      call TupleManager.setTuple( nn );
    }

    call TuplePublisher.publish( 2, address );
  }

  command void Neighbor_location.requestRemoteTuples()
  {
      requestRemoteTuples( 2);
  }

  command void Neighbor_location.publish()
  {
    call TuplePublisher.publish( 2, TOS_LOCAL_ADDRESS );
  }


  default event void Neighbor_location.updatedFromRemote( uint16_t address )
  {
  }

  command NeighborPtr_t Neighbor_location.getByAddress(uint16_t address)
  {
      return call TupleStore.getByAddress(address);
  }

  command TupleIterator_t Neighbor_location.initIterator()
  {
      return call TupleStore.initIterator();
  }

  command bool Neighbor_location.getNext(TupleIterator_t* iterator)
  {
      return call TupleStore.getNext(iterator);
  }

  command void Neighbor_ucb_location_nak.set( uint16_t address, bool* ucb_location_nak )
  {
    Neighbor_t* nn = call TupleStore.privateGetByAddress( address );

    if( nn != 0 )
    {
      nn->ucb_location_nak = *ucb_location_nak;
    }
    else
    {
      nn = call TupleManager.getByAddress( address );
      nn->ucb_location_nak = *ucb_location_nak;
      call TupleManager.setTuple( nn );
    }

    call TuplePublisher.publish( 3, address );
  }

  command void Neighbor_ucb_location_nak.requestRemoteTuples()
  {
      requestRemoteTuples( 3);
  }

  command void Neighbor_ucb_location_nak.publish()
  {
    call TuplePublisher.publish( 3, TOS_LOCAL_ADDRESS );
  }


  default event void Neighbor_ucb_location_nak.updatedFromRemote( uint16_t address )
  {
  }

  command NeighborPtr_t Neighbor_ucb_location_nak.getByAddress(uint16_t address)
  {
      return call TupleStore.getByAddress(address);
  }

  command TupleIterator_t Neighbor_ucb_location_nak.initIterator()
  {
      return call TupleStore.initIterator();
  }

  command bool Neighbor_ucb_location_nak.getNext(TupleIterator_t* iterator)
  {
      return call TupleStore.getNext(iterator);
  }

  command void Neighbor_mag.set( uint16_t address, MagHood_t* mag )
  {
    Neighbor_t* nn = call TupleStore.privateGetByAddress( address );

    if( nn != 0 )
    {
      nn->mag = *mag;
    }
    else
    {
      nn = call TupleManager.getByAddress( address );
      nn->mag = *mag;
      call TupleManager.setTuple( nn );
    }

    call TuplePublisher.publish( 20, address );
  }

  command void Neighbor_mag.requestRemoteTuples()
  {
      requestRemoteTuples( 20);
  }

  command void Neighbor_mag.publish()
  {
    call TuplePublisher.publish( 20, TOS_LOCAL_ADDRESS );
  }


  default event void Neighbor_mag.updatedFromRemote( uint16_t address )
  {
  }

  command NeighborPtr_t Neighbor_mag.getByAddress(uint16_t address)
  {
      return call TupleStore.getByAddress(address);
  }

  command TupleIterator_t Neighbor_mag.initIterator()
  {
      return call TupleStore.initIterator();
  }

  command bool Neighbor_mag.getNext(TupleIterator_t* iterator)
  {
      return call TupleStore.getNext(iterator);
  }


  command void TuplePublisher.publish( uint8_t tupletype, uint16_t address )
  {
    if( address != TOS_LOCAL_ADDRESS )
      return;

    if( push_back_cqueue(&m_cq) == SUCCESS )
    {
      m_queue[ m_cq.back ].address   = address;
      m_queue[ m_cq.back ].tupletype = tupletype;
      post do_publish();
    }
  }

  task void post_do_publish()
  {
    post do_publish();
  }

  task void do_publish()
  {
    TupleMsgHeader_t* head;
    void* msgdata;
    TupleMsgHeader_t headdata;
    const Neighbor_t* nn;

        if( (m_is_sending == TRUE) || (is_empty_cqueue( &m_cq ) == TRUE) )
      return;

        headdata = m_queue[ m_cq.front ];
    pop_front_cqueue( &m_cq );

        if( headdata.address == 0 )
    {
       if( createRemoteTupleRequest(headdata.tupletype) == FAIL)
          return;
                    if( call CommandBroadcast.send( 0, &m_msg ) == SUCCESS )
      {
         m_is_sending = TRUE;
       }
       else
       {
         if( push_front_cqueue( &m_cq ) == TRUE ) 
         m_queue[ m_cq.front ] = headdata;
         post post_do_publish();
       }
    }
    else
    {

              if( (nn = call TupleStore.getByAddress(headdata.address)) == 0 )
        return;
 
              switch( headdata.tupletype )
       {
      case 2: // location
        if( (msgdata = initRoutingMsg( &m_msg, sizeof(location_t) )) == 0 )
	  return;
	*(location_t*)msgdata = nn->location;
	break;

      case 3: // ucb_location_nak
        if( (msgdata = initRoutingMsg( &m_msg, sizeof(bool) )) == 0 )
	  return;
	*(bool*)msgdata = nn->ucb_location_nak;
	break;

      case 20: // mag
        if( (msgdata = initRoutingMsg( &m_msg, sizeof(MagHood_t) )) == 0 )
	  return;
	*(MagHood_t*)msgdata = nn->mag;
	m_msg.ext.retries = G_Config.tuple_mag_retries;
	break;

         default:
     	   return;
       }

                     if( (head = (TupleMsgHeader_t*)pushToRoutingMsg( &m_msg, sizeof(TupleMsgHeader_t) )) == 0 )
         return;

              *head = headdata;


                     if( call RoutingSendByBroadcast.send( 0, &m_msg ) == SUCCESS )
       {
         m_is_sending = TRUE;
       }
       else
       {
         if( push_front_cqueue( &m_cq ) == TRUE )
	   m_queue[ m_cq.front ] = headdata;
         post post_do_publish();
       }
    }
  }

  event result_t RoutingSendByBroadcast.sendDone( TOS_MsgPtr msg, result_t success )
  {
    if( msg == &m_msg )
      m_is_sending = FALSE;
    post do_publish();
    return SUCCESS;
  }

  event result_t CommandBroadcast.sendDone( TOS_MsgPtr msg, result_t success )
  {
    if( msg == &m_msg )
      m_is_sending = FALSE;
    return SUCCESS;
  }

  event TOS_MsgPtr RoutingReceive.receive( TOS_MsgPtr msg )
  {
    TupleMsgHeader_t* head;
    void* msgdata;

    
    if( (head = (TupleMsgHeader_t*)popFromRoutingMsg( msg, sizeof(TupleMsgHeader_t) )) == 0 )
      return msg;

    switch( head->tupletype )
    {
      case 2: // location
        if( (msgdata = popFromRoutingMsg( msg, sizeof(location_t) )) == 0 )
	  return msg;
	call Neighbor_location.set( head->address, (location_t*)msgdata );
	signal Neighbor_location.updatedFromRemote( head->address );
	break;

      case 3: // ucb_location_nak
        if( (msgdata = popFromRoutingMsg( msg, sizeof(bool) )) == 0 )
	  return msg;
	call Neighbor_ucb_location_nak.set( head->address, (bool*)msgdata );
	signal Neighbor_ucb_location_nak.updatedFromRemote( head->address );
	break;

      case 20: // mag
        if( (msgdata = popFromRoutingMsg( msg, sizeof(MagHood_t) )) == 0 )
	  return msg;
	call Neighbor_mag.set( head->address, (MagHood_t*)msgdata );
	signal Neighbor_mag.updatedFromRemote( head->address );
	break;

      default:
	return msg;
    }

    
    return msg;
  }
}


