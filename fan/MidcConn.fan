//
// Copyright (c) 2017, Acme
// All Rights Reserved
//
// History:
//   4 Apr 17   Anya Petersen   Creation
//

using haystack
using connExt
// using inet
**
** MidcConn
**
class MidcConn : Conn
{
  new make(ConnActor actor, Dict rec) : super(actor, rec) {}

  override Obj? receive(ConnMsg msg) { 
    // Todo receive udppacket from background actor that receives broadcast and update point curvals
    return super.receive(msg) 
  }

  override Void onOpen() { 
    
    log.info("onOpen started for Midc . Logger name is $log.name")
    
  
  }

  override Void onClose() {
    log.info("closing midc connection")

  }

  override Dict onPing() { Etc.emptyDict }


}

