#ifndef SPOUTDATA_H
#define SPOUTDATA_H
#include "Spout.h"
#include "SpoutReceiver.h"

#include <QWidget>
extern  unsigned char* pixelBuffer ;
class SpoutData{
public:
    GLuint m_texID = 0; //纹理Id
    GLuint m_SpoutTexID = 0;
    SpoutData();

private:
    int SenderSize = 0;

    SpoutReceiver m_SpoutReceiver;
    unsigned int g_SenderWidth;
    unsigned int g_SenderHeight;
    unsigned int g_SenderFormat;
public slots:
    void getImageData();
};

#endif // SPOUTDATA_H
