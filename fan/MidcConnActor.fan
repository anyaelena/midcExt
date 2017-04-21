//
// Copyright (c) 2017, Acme
// All Rights Reserved
//
// History:
//   4 Apr 17   Anya Petersen   Creation
//

using haystack
using connExt
using concurrent
using inet
**
** MidcConnActor
**
const class MidcConnActor : Actor {
  new make(ActorPool pool, MidcExt ext) : super.make(pool) { 
    this.ext = ext 
  }

  const MidcExt ext
  Void start() { send("start") }

  Void stop() { isAlive.val = false }

  override Obj? receive(Obj? msg)
  {
    socket := UdpSocket.make
    socket.bind(null,50260)  //todo dynamic port for each midcConn rec
    ext.log.info("midc socket bound successfully")

    //look up connection rec - for now assume exactly one  / ext 
    // TODO allow multiple conn recs for different ports
    // TODO handle error if no rec or connActor found

    while (isAlive.val)
    {
      try {
        packet := socket.receive //receive is blocking. packet is of type inet::UdpPacket
        // connActor.send(packet)
        ext.log.info("packet received. trying to make sense of it")
            try {
              connRec := ext.proj.read("midcConn")
              connActor := ext.connActor(connRec)
              data := packet.data.flip
              msg = ConnMsg("udpbroadcast", data) 
              connActor.send(msg)
            }
            catch (Err e) {
              ext.log.err("retrieving connActor", e)
            }
        // ext.log.info("ip: " + packet.addr)
        // ext.log.info("port: " + packet.port)      
      }
      catch (Err e) {
        ext.log.err("receiving msg", e)
      }
    }
    socket.close
    return null
  }

  private const AtomicBool isAlive := AtomicBool(true)
}