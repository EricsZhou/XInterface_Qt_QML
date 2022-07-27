#include "spoutdata.h"
#include "SpoutGL/Spout.h"
#include "SpoutGL/SpoutReceiver.h"
SpoutData::SpoutData()
{
}
void SpoutData::getImageData()
{
    m_SpoutReceiver.SetReceiverName("SpoutCamera_Front1");
    if (m_SpoutReceiver.ReceiveImage(pixelBuffer, GL_RGBA, false))
    {
//       // IsUpdated() returns true if the sender has changed
       if (m_SpoutReceiver.IsUpdated())
       {
//           // Update globals
           g_SenderWidth = m_SpoutReceiver.GetSenderWidth();
           g_SenderHeight = m_SpoutReceiver.GetSenderHeight();
           g_SenderFormat = m_SpoutReceiver.GetSenderFormat();

           if (pixelBuffer)
           {
               free(pixelBuffer);
           }

           pixelBuffer = static_cast<unsigned char*>(malloc(g_SenderWidth * g_SenderHeight * 4));

       }
    }
}
