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
      
      //2017-04-14_11-24-00 sample incoming datetime format 
      // Format is always mountain time without daylight savings, so just parse as AZ time
      ts := DateTime.fromLocale(data[0],"YYYY-MM-DD_hh-mm-ss",TimeZone.fromStr("America/Phoenix")) 
      log.info("parsed timestamp: " + ts.toHttpStr) 
      pts := this.points
      // log.info("points count "+points.size)
      points.each |pt, i| {
        tmp := (Number)pt.rec["udpPayloadIndex"]
        payloadIndex := tmp.toInt
        // log.info("point: " + pt.dis + " val: " + data[payloadIndex])
        pt.updateCurOk(Number(data[payloadIndex]))
      }

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

