QT       += core gui
QT       += quickwidgets
QT       += quickcontrols2
QT       += websockets
QT +=core gui opengl
LIBS+=-lopengl32 -lglu32
QT += quick

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11


# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    Server.cpp \
    Tcp.cpp \
    configdata.cpp \
    imageprovider.cpp \
    main.cpp \
    qchdbghelp.cpp \
    showimage.cpp
HEADERS += \
    Server.h \
    Tcp.h \
    configdata.h \
    imageprovider.h \
    qchdbghelp.h \
    showimage.h

FORMS += \
    Tcp.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    res.qrc
##release版本可调试
QMAKE_CXXFLAGS_RELEASE += $$QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO
##release版也将生成“.pdb”后缀的调试信息文件
QMAKE_LFLAGS_RELEASE = /INCREMENTAL:NO /DEBUG
#调用库
LIBS += -lDbgHelp

