#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "stopwatch.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    
    // Create stopwatch instance
    Stopwatch stopwatch;
    
    // Expose stopwatch to QML
    engine.rootContext()->setContextProperty("stopwatch", &stopwatch);
    
    // Load QML file
    const QUrl url(QStringLiteral("qrc:/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
