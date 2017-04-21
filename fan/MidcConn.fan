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
    if (msg.id == "udpbroadcast") {
      
      data := (Str[])msg.a
      log.info("received "+ data.typeof +" in midcConn receive")

      //2017-04-14_11-24-00 sample incoming datetime format (always mountain time, never DST)
      // Parse as AZ time, as this does not use DST.
      ts := DateTime.fromLocale(data[0],"YYYY-MM-DD_hh-mm-ss",TimeZone.fromStr("America/Phoenix")) 
      log.info("parsed timestamp: " + ts.toHttpStr) 
       

      return null
    }
    else {
      return super.receive(msg) 
    }
  }

  override Void onOpen() { 
    
    log.info("onOpen started for Midc . Logger name is $log.name")
    
  
  }

  override Void onClose() {
    log.info("closing midc connection")

  }

  override Dict onPing() { Etc.emptyDict }


}

