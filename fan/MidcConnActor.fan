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
  new make(ActorPool pool, MidcExt ext, Int port) : super.make(pool) { 
    this.ext = ext 
    this.port = port
  }

  const MidcExt ext
  const Int port

  Void start() { send("start") }

  Void stop() { isAlive.val = false }

  override Obj? receive(Obj? msg)
  {
    socket := UdpSocket.make
    socket.bind(null,port)  
    ext.log.info("midc socket bound successfully on port $port")

    while (isAlive.val)
    {
      try {
        packet := socket.receive //receive is blocking. packet is of type inet::UdpPacket
        // ext.log.info("packet received on port $port")
            try { 
              // TODO error handling
              connRec := ext.proj.read("midcConn and port==$port")
              connActor := ext.connActor(connRec)
              
              data := packet.data.flip.readLine.split(',') 
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