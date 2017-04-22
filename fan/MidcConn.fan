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
      
      // Timestamp format is always mountain time without daylight savings, so just parse as AZ time and then convert to Denver
      ts := DateTime.fromLocale(data[0],"YYYY-MM-DD_hh-mm-ss",TimeZone.fromStr("America/Phoenix")).toTimeZone(TimeZone.fromStr("Denver"))
      this.points.each |pt, i| {
        tmp := (Number)pt.rec["udpPayloadIndex"]
        payloadIndex := tmp.toInt
        vals := HisItem[HisItem(ts, Number(data[payloadIndex]))]
        res := pt.updateHisOk(vals, Span("today")) 
        //log.debug("result of updatehisok: $res")
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

